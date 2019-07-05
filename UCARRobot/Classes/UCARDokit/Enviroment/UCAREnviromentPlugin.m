//
//  UCAREnviromentPlugin.m
//  AFNetworking
//
//  Created by suzhiqiu on 2019/7/2.
//

#import "UCAREnviromentPlugin.h"
#import "UCAREnviromentListViewController.h"
#import "DoraemonUtil.h"

@implementation UCAREnviromentPlugin
    
    
- (void)pluginDidLoad{
    UCAREnviromentListViewController *vc = [[UCAREnviromentListViewController alloc] init];
    [DoraemonUtil openPlugin:vc];
}

@end
