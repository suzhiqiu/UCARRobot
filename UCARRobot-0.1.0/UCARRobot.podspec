Pod::Spec.new do |s|
  s.name = "UCARRobot"
  s.version = "0.1.0"
  s.summary = "A short description of UCARRobot."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"364121248@qq.com"=>"zhiqiu.su@ucarinc.com"}
  s.homepage = "https://github.com/suzhiqiu/UCARBox"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/UCARRobot.framework'
end
