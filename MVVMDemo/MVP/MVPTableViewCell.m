//
//  MVPTableViewCell.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import "MVPTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation MVPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self makeMainUI];
    };
    return self;
}

- (void)makeMainUI {

    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(30);
    }];

    _numLabel = [UILabel new];
    _numLabel.font = [UIFont systemFontOfSize:14];
    _numLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_numLabel];

    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-130);
    }];

    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setTitle:@"➕" forState:UIControlStateNormal];
    _addBtn.titleLabel.textColor = [UIColor redColor];
    [_addBtn addTarget:self action:@selector(addBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];

    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-30);
        make.width.height.mas_equalTo(30);
    }];
}

- (void)addBtnDown:(UIButton *)btn {
    NSLog(@"%s", __func__);
    if ([self.delegate respondsToSelector:@selector(didClickCellAddBtnWithIndexPathRow:)]) {
        [self.delegate didClickCellAddBtnWithIndexPathRow:self.index];
    }
}

@end
