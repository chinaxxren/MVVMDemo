//
//  MVPViewController.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import "MVPViewController.h"
#import "MVPTableViewCell.h"
#import "DemoProtocal.h"
#import "Presenter.h"

@interface MVPViewController () <UITableViewDelegate, UITableViewDataSource, DemoProtocal>

@property(nonatomic, strong) UITableView *mainTabelView;
@property(nonatomic, strong) Presenter *presenter;

@end

@implementation MVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"MVP";

    [self iniData];
    [self makeTableView];
}

- (void)iniData {
    self.presenter = [[Presenter alloc] init];
    self.presenter.delegate = self;
    [self.presenter requestDataAndUpdateUI];
}

- (void)makeTableView {
    self.mainTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainTabelView.delegate = self;
    self.mainTabelView.dataSource = self;
    self.mainTabelView.estimatedRowHeight = 100;
    [self.view addSubview:self.mainTabelView];
}

#pragma mark - TabelView Delegate&DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MVPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_identifer"];
    if (cell == nil) {
        cell = [[MVPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell_identifer"];
    }
    //更新cell UI 数据
    [self.presenter updateCell:cell withIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - DemoProtocal

//Presenter 的代理回调 数据更新了通知View去更新视图
- (void)reloadUI {
    [self.mainTabelView reloadData];
}

@end
