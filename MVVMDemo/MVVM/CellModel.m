//
//  CellModel.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/13.
//

#import "CellModel.h"

@interface CellModel ()

@property(nonatomic, strong) DemoModel *model;
@property(nonatomic, copy, readwrite) NSString *numStr;

@end

@implementation CellModel

- (instancetype)initWithModel:(DemoModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (NSString *)titleStr {
    return self.model.title;
}

- (NSString *)numStr {
    return [NSString stringWithFormat:@"%ld", (long) self.model.num];
}

- (RACCommand *)addCommand {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            self.model.num++;
            self.numStr = [NSString stringWithFormat:@"%ld", (long) self.model.num];//这里要对新的numStr 进行赋值处理，否则UI不会改变
            return nil;
        }];
    }];
}

@end
