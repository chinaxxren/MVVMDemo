//
//  MMMMTableVIewCell.h
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CellModel.h"

@class ViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface MVVMTableVIewCell : UITableViewCell

- (void)bind:(ViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
