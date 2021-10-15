//
//  ViewModel.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/13.
//

#import "ViewModel.h"
#import "DemoModel.h"

@interface ViewModel ()

@property(nonatomic, strong, readwrite) RACCommand *loadCommand;
@property(nonatomic, strong, readwrite) RACCommand *deleteCommand;
@property(nonatomic, strong, readwrite) NSMutableArray *mulArr;//请求获取到的数据源

@end

@implementation ViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mulArr = [[NSMutableArray alloc] initWithCapacity:0];
        [self loadRequestData];
        [self deleteRequestData];
    }
    return self;
}

- (void)loadRequestData {
    self.loadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        /**获取传递过来的参数，可以用于请求数据*/
        NSLog(@"load==>%@", input);
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
                    
                    // 方便监听数据变化
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

- (void)deleteRequestData {

    self.deleteCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        /**获取传递过来的参数，可以用于请求数据*/
        NSLog(@"delete==>%@", input);
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

            /**模拟网络请求*/
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
                dispatch_async(queue, ^{
                    NSNumber *index = (NSNumber *) input;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([index integerValue] == 3) {
                            [self.mulArr removeObjectAtIndex:[index integerValue]];
                            self.dataArr = [self.mulArr copy];
                            //发送信号 发送请求成功标识，当然也可发送数据self.dataArr, 如果请求失败也可发送失败标识
                            [subscriber sendNext:index];
                            //发送完成标识,一定要sendCompleted  不然command.executing无法接收到信号停止的动作
                            [subscriber sendCompleted];
                        } else {
                            NSError *error = [NSError errorWithDomain:@"mvvm" code:0 userInfo:@{@"msg":@"error index"}];
                            [subscriber sendError:error];
                        }
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
