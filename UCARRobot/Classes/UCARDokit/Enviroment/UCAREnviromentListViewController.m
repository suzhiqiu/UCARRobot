//
//  UCAREnviromentListViewController.m
//  UCARRobot
//
//  Created by suzhiqiu on 2019/7/2.
//

#import "UCAREnviromentListViewController.h"
#import "UCAREnvironmentManager.h"
#import "UCAREnviromentModel.h"

@interface UCAREnviromentListViewController ()<UITableViewDelegate,UITableViewDataSource>
    
    
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation UCAREnviromentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
    [self prepareData];
    
    
}

- (BOOL)needBigTitleView{
    return YES;
}

- (void)prepareUI{
    self.title = DoraemonLocalizedString(@"切换环境");
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bigTitleView.doraemon_bottom, self.view.doraemon_width, self.view.doraemon_height-self.bigTitleView.doraemon_bottom) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0.;
    self.tableView.estimatedSectionFooterHeight = 0.;
    self.tableView.estimatedSectionHeaderHeight = 0.;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.doraemon_width, 0.1)];
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateEnviroment) name:UCAREnvironmentEndChangeNotification object:nil];
}
    
- (void)prepareData{
    self.dataArray  =   [[NSMutableArray alloc] init];
    
    UCAREnviromentModel *testModel = [[UCAREnviromentModel alloc] init];
    testModel.name = @"测试环境";
    testModel.envType = UCAREnviromentTypeTest;
    testModel.isOpen = NO;
    
    UCAREnviromentModel *preissueModel = [[UCAREnviromentModel alloc] init];
    preissueModel.name = @"预发环境";
    preissueModel.envType = UCAREnviromentTypePreissue;
    preissueModel.isOpen = NO;
    
    UCAREnviromentModel *productModel = [[UCAREnviromentModel alloc] init];
    productModel.name = @"正式环境";
    productModel.envType = UCAREnviromentTypeProduction;
    productModel.isOpen = NO;
    
    [self.dataArray addObject:testModel];
    [self.dataArray addObject:preissueModel];
    [self.dataArray addObject:productModel];
    
    [self updateEnviroment];
}
    

-(void)updateEnviroment{
    
    UCAREnviromentType type = [UCAREnvironmentManager currentType];
    for (UCAREnviromentModel *model in self.dataArray) {
        model.isOpen =  (model.envType == type)? YES : NO;
    }
    
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
/*高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
   UCAREnviromentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.isOpen){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.textLabel.text = model.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UCAREnviromentType type = indexPath.row + 1;
    NSDictionary *userInfo = @{@"envType":@(type)};
    [[NSNotificationCenter defaultCenter] postNotificationName:UCAREnvironmentDidChangeNotification object:nil userInfo:userInfo];
}


@end
