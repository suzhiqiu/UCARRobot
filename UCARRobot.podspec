#
# Be sure to run `pod lib lint UCARRobot.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UCARRobot'
  s.version          = '0.1.0'
  s.summary          = 'UCARRobot  is a performance testing tool '

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://gitlab.10101111.com:8888/ucar_ios_team/ucarrobot'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '364121248@qq.com' => 'zhiqiu.su@ucarinc.com' }
  s.source           = { :git => 'http://gitlab.10101111.com:8888/ucar_ios_team/ucarrobot.git', :tag => s.version.to_s }


  s.ios.deployment_target = '8.0'
  
  s.default_subspec = 'Core','UCARDokit','WithLoad'
  
  s.subspec 'Core' do |ss|
      ss.source_files = 'UCARRobot/Classes/Core/**/*{.h,.m}'
      ss.resource_bundles = {
          'UCARRobot' => 'UCARRobot/Resource/**/*'
      }
      s.prefix_header_contents =
      '#import "DoraemonDefine.h"'
  end
  
  s.subspec 'UCARDokit' do |ss|
      ss.source_files = 'UCARRobot/Classes/UCARDokit/**/*{.h,.m}'
      ss.dependency 'UCARRobot/Core'
  end
  
  s.subspec 'WithLoad' do |ss|
    ss.source_files = 'UCARRobot/Classes/MethodUseTime/**/*{.h,.m}'
    ss.pod_target_xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) DoraemonWithLoad'
    }
    ss.dependency 'UCARRobot/Core'
    ss.vendored_frameworks = 'UCARRobot/Framework/*.framework'
  end
  
  s.subspec 'WithLogger' do |ss|
      ss.source_files = 'UCARRobot/Classes/Logger/**/*{.h,.m}'
      ss.pod_target_xcconfig = {
          'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) DoraemonWithLogger'
      }
      ss.dependency 'UCARRobot/Core'
      ss.dependency 'CocoaLumberjack'
  end
  

  
  s.dependency 'PNChart'
  s.dependency 'BSBacktraceLogger'
  s.dependency 'fishhook'
  s.dependency 'UITextView+Placeholder'
  
end
