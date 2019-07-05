//
//  UCAREnvironmentManager.h
//  UCARRobot
//
//  Created by suzhiqiu on 2019/7/2.
//

#import <Foundation/Foundation.h>
#import "UCAREnviromentModel.h"

NS_ASSUME_NONNULL_BEGIN


/*点击列表开始修改环境通知*/
static NSString *const UCAREnvironmentDidChangeNotification = @"UCAREnvironmentDidChangeNotification";
/*点击列表开始修改通知*/
static NSString *const UCAREnvironmentEndChangeNotification = @"UCAREnvironmentEndChangeNotification";

@interface UCAREnvironmentManager : NSObject
    
/*当前环境类型*/
+ (UCAREnviromentType)currentType;
/*设置当前环境*/
+ (void)setCurrentType:(UCAREnviromentType)type;

@end

NS_ASSUME_NONNULL_END
