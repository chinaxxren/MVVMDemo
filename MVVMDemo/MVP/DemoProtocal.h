//
//  DemoProtocal.h
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import <Foundation/Foundation.h>

@protocol DemoProtocal <NSObject>

@optional
//用户点击按钮 触发事件： UI改变传值到model数据改变  UI --- > Model 点击cell 按钮
- (void)didClickCellAddBtnWithIndexPathRow:(NSInteger)index;

//model数据改变传值到UI界面刷新 Model --- > UI
- (void)reloadUI;

@end
