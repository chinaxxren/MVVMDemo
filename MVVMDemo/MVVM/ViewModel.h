//
//  ViewModel.h
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/13.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

//发送数据请求的Rac，可以去订阅获取 请求结果
@property(nonatomic, strong, readonly) RACCommand *requestCommand;
@property(nonatomic, strong) NSArray *dataArr;//这里不能用NSMutableArray，因为NSMutableArray不支持KVO，不能被RACObserve

//返回子级对象的ViewModel
- (CellModel *)itemViewModelForIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
