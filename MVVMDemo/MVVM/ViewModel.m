//
//  ViewModel.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/13.
//

#import "ViewModel.h"
#import "DemoModel.h"

@interface ViewModel ()

@property(nonatomic, strong, readwrite) RACCommand *requestCommand;
@property(nonatomic, strong, readwrite) NSMutableArray *mulArr;//请求获取到的数据源

@end

@implementation ViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mulArr = [[NSMutableArray alloc] initWithCapacity:0];
        [self loadRequestData];
    }
    return self;
}

- (void)loadRequestData {
    self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        /**获取传递过来的参数，可以用于请求数据*/
        NSLog(@"input==%@", input);
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

            /**模拟网络请求*/
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
                dispatch_async(queue, ^{
                    self.mulArr = [[NSMutableArray alloc] initWithCapacity:0];
                    for (NSInteger i = 0; i < 50; i++) {
                        DemoModel *model = [[DemoModel alloc] init];
                        model.title = [NSString stringWithFormat:@"title_%ld", (long) i];
                        model.num = i;
                        model.Id = i;
                        [self.mulArr addObject:model];
                    }
                    self.dataArr = [self.mulArr copy];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [subscriber sendNext:@(YES)];//发送请求成功标识，当然也可发送数据self.dataArr, 如果请求失败也可发送失败标识
                        [subscriber sendCompleted];//发送完成标识
                    });
                });
            });
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
    }];
}

//返回子级对象的ViewModel
- (CellModel *)itemViewModelForIndex:(NSInteger)index {
    return [[CellModel alloc] initWithModel:self.dataArr[index]];
}

@end
