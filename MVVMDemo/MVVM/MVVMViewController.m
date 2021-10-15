//
//  MVVMViewController.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import "MVVMViewController.h"
#import "MVVMTableVIewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "ViewModel.h"

@interface MVVMViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *mainTabelView;
@property(nonatomic, strong) ViewModel *viewModel;

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"MVVM";

    [self iniData];
    [self makeTableView];
}

- (void)iniData {
    self.viewModel = [[ViewModel alloc] init];
    // 发送请求
    RACSignal *signal = [self.viewModel.requestCommand execute:@{@"page": @"1"}];
    [signal subscribeNext:^(id success) {
        NSLog(@"x=======%@", success);
        if ([success boolValue] == 1) {//请求成功
            [self.mainTabelView reloadData];
        }
    }];
}

- (void)makeTableView {
    self.mainTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainTabelView.delegate = self;
    self.mainTabelView.dataSource = self;
    self.mainTabelView.estimatedRowHeight = 50;
    self.mainTabelView.rowHeight = 50;
    [self.view addSubview:self.mainTabelView];
}

#pragma mark - TabelView Delegate&DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MVVMTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_identifer"];
    if (cell == nil) {
        cell = [[MVVMTableVIewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell_identifer"];
    }

    //更新cell UI 数据
    cell.cellModel = [self.viewModel itemViewModelForIndex:indexPath.row];

    return cell;
}

@end
