//
//  Presenter.h
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DemoProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Presenter : NSObject

@property(nonatomic, strong, readonly) NSMutableArray *dataArray;
@property(nonatomic, weak) id <DemoProtocal> delegate;//协议，去更新主视图UI

// 更新 TableView UI 根据需求
- (void)requestDataAndUpdateUI;

//更新 cell UI
- (void)updateCell:(UITableViewCell *)cell withIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
