//
//  Presenter.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import "Presenter.h"
#import "DemoModel.h"
#import "MVPTableViewCell.h"

@interface Presenter () <DemoProtocal>

@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Presenter

- (void)requestDataAndUpdateUI {
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
                if ([self.delegate respondsToSelector:@selector(reloadUI)]) {
                    [self.delegate reloadUI];
                }
            });
        });
    });

}

- (void)updateCell:(UITableViewCell *)cell withIndex:(NSInteger)index {

    if ([cell isKindOfClass:[MVPTableViewCell class]]) {
        DemoModel *model = self.dataArray[index];
        MVPTableViewCell *mvpCell = (MVPTableViewCell *) cell;
        mvpCell.titleLabel.text = model.title;
        mvpCell.numLabel.text = [NSString stringWithFormat:@"%ld", model.num];
        mvpCell.delegate = self;
        mvpCell.index = index;
    }
}

#pragma mark - DemoProtocal

- (void)didClickCellAddBtnWithIndexPathRow:(NSInteger)index {
    DemoModel *model = self.dataArray[index];
    model.num++;
    if ([self.delegate respondsToSelector:@selector(reloadUI)]) {
        [self.delegate reloadUI];
    }
}


@end
