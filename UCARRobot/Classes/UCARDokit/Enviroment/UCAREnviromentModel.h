//
//  UCAREnviromentModel.h
//  UCARRobot
//
//  Created by suzhiqiu on 2019/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UCAREnviromentType) {
    UCAREnviromentTypeTest = 1,//外网测试环境
    UCAREnviromentTypePreissue = 2,//预发测试环境
    UCAREnviromentTypeProduction = 3,//正式环境
};

@interface UCAREnviromentModel : NSObject

@property (nonatomic, copy) NSString *name;//名称
@property (nonatomic, assign) BOOL isOpen;//是否当前环境
@property (nonatomic, assign) UCAREnviromentType envType;//环境类型
    
@end

NS_ASSUME_NONNULL_END
