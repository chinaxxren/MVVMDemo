//
//  MVCTableViewCell.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import "MVCTableViewCell.h"
#import <Masonry/Masonry.h>

@interface MVCTableViewCell () {
    UILabel *titleLabel;
    UILabel *numLabel;
    UIButton *addBtn;
}
@end

@implementation MVCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self makeMainUI];
    };
    return self;
}

- (void)makeMainUI {

    titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(30);
    }];

    numLabel = [UILabel new];
    numLabel.font = [UIFont systemFontOfSize:14];
    numLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:numLabel];

    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-130);
    }];

    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"➕" forState:UIControlStateNormal];
    addBtn.titleLabel.textColor = [UIColor redColor];
    [addBtn addTarget:self action:@selector(addBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];

    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-30);
        make.width.height.mas_equalTo(30);
    }];
}

- (void)loadDataWithModel:(DemoModel *)model {
    titleLabel.text = model.title;
    numLabel.text = [NSString stringWithFormat:@"%ld", model.num];
}

- (void)addBtnDown:(UIButton *)btn {
    NSLog(@"%s", __func__);
    if (self.clickBtn) {
        self.clickBtn();
    }
}

@end
