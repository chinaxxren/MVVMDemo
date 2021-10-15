//
//  MMMMTableVIewCell.h
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMTableVIewCell : UITableViewCell

@property(nonatomic, strong) CellModel *cellModel;

@end

NS_ASSUME_NONNULL_END
