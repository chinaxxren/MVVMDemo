//
//  MVCViewController.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import "MVCViewController.h"
#import "DemoModel.h"
#import "MVCTableViewCell.h"

@interface MVCViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *mainTabelView;

@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"MVC";
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self makeRequestData];
    [self makeTableView];
}

- (void)makeRequestData {
    /**模拟网络请求*/
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSInteger i = 0; i < 10; i++) {
                DemoModel *model = [[DemoModel alloc] init];
                model.title = [NSString stringWithFormat:@"title_%ld", (long) i];
                model.num = i;
                model.Id = i;
                [self.dataArray addObject:model];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.mainTabelView reloadData];
            });
        });
    });

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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    __weak typeof(self) wealSelf = self;
    MVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_identifer"];
    if (cell == nil) {
        cell = [[MVCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell_identifer"];
    }
    DemoModel *model = self.dataArray[indexPath.row];
    [cell loadDataWithModel:model];
    cell.clickBtn = ^{
        NSLog(@"id===%ld", model.num);
        [wealSelf changeNumWithModel:model];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)changeNumWithModel:(DemoModel *)model {

    model.num++;
    NSIndexPath *path = [NSIndexPath indexPathForRow:model.Id inSection:0];
    [self.mainTabelView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
}


@end
