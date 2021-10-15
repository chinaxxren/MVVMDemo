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
    RACSignal *loadSignal = [self.viewModel.loadCommand execute:@{@"page": @"1"}];
    [loadSignal subscribeNext:^(id success) {
        NSLog(@"load result=======>%@", success);
        if ([success boolValue] == 1) {//请求成功
            [self.mainTabelView reloadData];
        }
    }];

    /**
     *  RACCommand使用注意
     *  1、RACCommand内部必须返回RACSignal
     *  2、executionSignals信号中的信号，一开始获取不到内部信号
     *      2.1 使用switchToLatest:获取内部信号
     *      2.2 使用execute:获取内部信号
     *  3、executing判断是否正在执行
     *      3.1 第一次不准确，需要skip:跳过
     *      3.2 一定要记得sendCompleted，否则永远不会执行完成
     *  4、通过执行execute，执行command的block
     */
    [[self.viewModel.deleteCommand.executing skip:1] subscribeNext:^(NSNumber *_Nullable x) {
        if (x.boolValue) {
            NSLog(@"x = %@ 正在执行", x);
        } else {
            NSLog(@"x = %@ 执行完成", x);
        }
    }];

    //错误信号
    [self.viewModel.deleteCommand.errors subscribeNext:^(NSError *_Nullable x) {
        NSLog(@"delete errors == %@", x);
    }];

//    [self.viewModel.deleteCommand.executionSignals subscribeNext:^(RACSignal *signal) {;
//        [signal subscribeNext:^(id success) {
//            NSLog(@"delete result=======>%@", success);
//            if ([success integerValue] == 3) {//请求成功
//                NSLog(@"delete result success");
//                [self.mainTabelView reloadData];
//            }
//        }];
//    }];

    //获取最新信号的值
    [self.viewModel.deleteCommand.executionSignals.switchToLatest subscribeNext:^(id success) {
        //4，打印信号中的值
        NSLog(@"delete result=======>%@", success);
        if ([success integerValue] == 3) {//请求成功
            NSLog(@"delete result success");
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
    [cell bind:self.viewModel indexPath:indexPath];

    return cell;
}

@end
