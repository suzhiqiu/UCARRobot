app# UCARRobot

[![CI Status](https://img.shields.io/travis/364121248@qq.com/UCARRobot.svg?style=flat)](https://travis-ci.org/364121248@qq.com/UCARRobot)
[![Version](https://img.shields.io/cocoapods/v/UCARRobot.svg?style=flat)](https://cocoapods.org/pods/UCARRobot)
[![License](https://img.shields.io/cocoapods/l/UCARRobot.svg?style=flat)](https://cocoapods.org/pods/UCARRobot)
[![Platform](https://img.shields.io/cocoapods/p/UCARRobot.svg?style=flat)](https://cocoapods.org/pods/UCARRobot)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

UCARRobot is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

1、cocoapods依赖

```ruby
pod 'UCARRobot', :configurations => ['Debug'] #必选
pod 'UCARRobot/WithLogger', :configurations => ['Debug'] #可选 日志是基于CocoaLumberjack
```

2、AppDelegate接入
#ifdef DEBUG
#import <UCARRobot.h>
#endif

#ifdef DEBUG
[UCARRobot setUp];
#endif

3、切换环境接入 参考代码

NSString * const EnvDevelop = @"develop";
NSString * const EnvPrePoduct = @"preproduct";
NSString * const EnvProduct= @"product";

#pragma mark - 环境切换测试代码
- (NSString *)getEnvKey:(UCAREnviromentType)envType{
NSString *envKey = EnvProduct;
if (envType == UCAREnviromentTypeTest) {
envKey = EnvDevelop;
}else if (envType == UCAREnviromentTypePreissue) {
envKey = EnvPrePoduct;
}else if (envType == UCAREnviromentTypeProduction) {
envKey = EnvProduct;
}
return envKey;
}
- (void)changeEnvironment:(NSNotification *)notify{
NSNumber *envTypeNum = notify.userInfo[@"envType"];
if(!envTypeNum){
return;
}
UCAREnviromentType envType = [envTypeNum integerValue];
NSString *envKey = [self getEnvKey:envType];
[self initEnvironment:envKey];
[UCAREnvironmentManager setCurrentType:envType];
}
- (void)initEnvironment{
NSString *envKey = EnvProduct;
#ifdef DEBUG
UCAREnviromentType envType = [UCAREnvironmentManager currentType];
if(!envType){//首次默认--测试环境
envType = UCAREnviromentTypeTest;
[UCAREnvironmentManager setCurrentType:envType];
}
envKey = [self getEnvKey:envType];
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEnvironment:) name:UCAREnvironmentDidChangeNotification object:nil];
#else
envKey = EnvProduct;
#endif
[self initEnvironment:envKey];
}

- (void)initEnvironment:(NSString *)envKey {
NSLog(@"envKey:%@",envKey);
}




## Author

zhiqiu.su@ucarinc.com

## License

UCARRobot is available under the MIT license. See the LICENSE file for more info.
