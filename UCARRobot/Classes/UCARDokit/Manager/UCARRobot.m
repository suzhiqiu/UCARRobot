//
//  UCARRobot.m
//  UCARRobot
//
//  Created by suzhiqiu on 2019/6/28.
//

#import "UCARRobot.h"
#import "DoraemonManager.h"
#import "UCAREnviromentPlugin.h"

@implementation UCARRobot


+ (void)setUp{
    [self addUCarPlugin];
    [[DoraemonManager shareInstance] install];
}
//添加UCar的插件
+ (void)addUCarPlugin{
    NSString *moduleName = @"";
    moduleName =DoraemonLocalizedString(@"常用工具");
    [[DoraemonManager shareInstance] addPluginWithTitle:@"网络环境"
                                                   icon:@"doraemon_network"
                                                   desc:nil
                                             pluginName:NSStringFromClass([UCAREnviromentPlugin class])
                                               atModule:moduleName];
}

@end
