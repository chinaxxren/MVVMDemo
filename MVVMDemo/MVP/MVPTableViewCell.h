//
//  MVPTableViewCell.h
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import <UIKit/UIKit.h>
#import "DemoProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVPTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic, weak) id <DemoProtocal> delegate;//声明协议，去实现点击事件

@end

NS_ASSUME_NONNULL_END
