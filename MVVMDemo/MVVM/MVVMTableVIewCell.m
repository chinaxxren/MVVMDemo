//
//  MMMMTableVIewCell.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/13.
//

#import "MVVMTableVIewCell.h"

#import <Masonry/Masonry.h>

#import "ViewModel.h"

@interface MVVMTableVIewCell ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *numLabel;
@property(nonatomic, strong) UIButton *addBtn;
@property(nonatomic, strong) UIButton *delBtn;
@property(nonatomic, strong) CellModel *cellModel;
@property(nonatomic, strong) ViewModel *viewModel;
@property(nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation MVVMTableVIewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

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

    _delBtn = [UIButton new];
    [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_delBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_delBtn];

    [_delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];

    _addBtn = [UIButton new];
    [_addBtn setTitle:@"增加" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];

    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];

    //直接绑定  这边有个注意Racobserve 左边只有self  右边才有viewModel.titleStr  这样就避CELL 重用的问题
    RAC(self.titleLabel, text) = RACObserve(self, cellModel.titleStr);
    RAC(self.numLabel, text) = RACObserve(self, cellModel.numStr);

    [[self.delBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"delete >>>>>");
        [self.viewModel.deleteCommand execute:@(self.indexPath.row)];
    }];

    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"add >>>>>");
        [self.cellModel.addCommand execute:nil];
    }];
}

- (void)bind:(ViewModel *)viewModel indexPath:(NSIndexPath *)indexPath {
    self.viewModel = viewModel;
    self.indexPath = indexPath;
    self.cellModel = [viewModel itemViewModelForIndex:indexPath.row];
}

@end
