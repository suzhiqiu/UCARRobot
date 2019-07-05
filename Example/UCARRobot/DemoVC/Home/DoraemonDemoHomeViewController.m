//
//  DoraemonDemoHomeViewController.m
//  DoraemonKitDemo
//
//  Created by yixiang on 2018/5/15.
//  Copyright © 2018年 yixiang. All rights reserved.
//

#import "DoraemonDemoHomeViewController.h"
#import "DoraemonDemoLoggerViewController.h"
#import "DoraemonDemoPerformanceViewController.h"
#import "DoraemonDemoSanboxViewController.h"
#import "DoraemonDemoUIViewController.h"
#import "DoraemonDemoNetViewController.h"
#import "DoraemonDemoMockGPSViewController.h"
#import "DoraemonDemoCrashViewController.h"
#import "DoraemonDemoCommonViewController.h"
#import <objc/runtime.h>
#import "Doraemoni18NUtil.h"
#import "UCAREnvironmentManager.h"
#import "UCAREnviromentModel.h"

NSString * const EnvDevelop = @"develop";
NSString * const EnvPrePoduct = @"preproduct";
NSString * const EnvProduct= @"product";

@interface DoraemonDemoHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DoraemonDemoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = DoraemonLocalizedString(@"DoraemonKit");
    self.navigationItem.leftBarButtonItems = nil;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [self initEnvironment];
}
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSString *txt = nil;
    NSInteger row = indexPath.row;
    if (row==0) {
        txt = DoraemonLocalizedString(@"沙盒测试Demo");
    }else if(row==1){
        txt = DoraemonLocalizedString(@"日记测试Demo");
    }else if(row==2){
        txt = DoraemonLocalizedString(@"性能测试Demo");
    }else if(row==3){
        txt = DoraemonLocalizedString(@"视觉测试Demo");
    }else if(row==4){
        txt = DoraemonLocalizedString(@"网络测试Demo");
    }else if(row==5){
        txt = DoraemonLocalizedString(@"模拟位置Demo");
    }else if(row==6){
        txt = DoraemonLocalizedString(@"crash触发Demo");
    }else if(row==7){
        txt = DoraemonLocalizedString(@"通用测试Demo");
    }
    cell.textLabel.text = txt;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    UIViewController *vc = nil;
    if (row == 0) {
        vc = [[DoraemonDemoSanboxViewController alloc] init];
    }else if(row == 1){
        vc = [[DoraemonDemoLoggerViewController alloc] init];
    }else if(row == 2){
        vc = [[DoraemonDemoPerformanceViewController alloc] init];
    }else if(row == 3){
        vc = [[DoraemonDemoUIViewController alloc] init];
    }else if(row == 4){
        vc = [[DoraemonDemoNetViewController alloc] init];
    }else if(row == 5){
        vc = [[DoraemonDemoMockGPSViewController alloc] init];
    }else if(row == 6){
        vc = [[DoraemonDemoCrashViewController alloc] init];
    }else{
        vc = [[DoraemonDemoCommonViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
 
    //产生crash
//    NSArray *dataArray = @[@"1",@"2"];
//    NSString *num = dataArray[2];
//    NSLog(@"num == %@",num);
}

@end
