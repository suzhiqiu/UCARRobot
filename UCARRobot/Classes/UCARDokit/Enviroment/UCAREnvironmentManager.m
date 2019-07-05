//
//  UCAREnvironmentManager.m
//  UCARRobot
//
//  Created by suzhiqiu on 2019/7/2.
//

#import "UCAREnvironmentManager.h"

NSString *const STORE_UCAREnvironment = @"STORE_UCAREnvironment";

@implementation UCAREnvironmentManager
    
    

+ (UCAREnviromentType)currentType {
#ifdef DEBUG
    UCAREnviromentType type = [[NSUserDefaults standardUserDefaults] integerForKey:STORE_UCAREnvironment];
    return type;
#else
    return UCAREnviromentTypeProduction;
#endif
}
    
+ (void)setCurrentType:(UCAREnviromentType)type {
#ifdef DEBUG
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:STORE_UCAREnvironment];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:UCAREnvironmentEndChangeNotification object:nil];
#endif
}

@end
