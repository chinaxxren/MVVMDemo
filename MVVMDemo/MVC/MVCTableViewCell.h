//
//  MVCTableViewCell.h
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import <UIKit/UIKit.h>
#import "DemoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickBtnBlcok)(void);

@interface MVCTableViewCell : UITableViewCell

- (void)loadDataWithModel:(DemoModel*)model;

@property (nonatomic,copy) ClickBtnBlcok clickBtn;

@end

NS_ASSUME_NONNULL_END
