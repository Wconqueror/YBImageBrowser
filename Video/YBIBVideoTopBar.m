//
//  YBIBVideoTopBar.m
//  YBImageBrowserDemo
//
//  Created by 波儿菜 on 2019/7/11.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBIBVideoTopBar.h"
#import "YBIBIconManager.h"

@interface YBIBVideoTopBar ()
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation YBIBVideoTopBar

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cancelButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.downloadButton];
        [self addSubview:self.deleteButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonWidth = 44;
    self.cancelButton.frame = CGRectMake(20, 0, buttonWidth, self.bounds.size.height);
    self.titleLabel.frame = CGRectMake(80, 0, self.bounds.size.width - 160, self.bounds.size.height);
    self.deleteButton.frame = CGRectMake(self.bounds.size.width - 130, 0, 44, 44);
    self.downloadButton.frame = CGRectMake(self.deleteButton.frame.origin.x - 64, 0, 44, 44);
}

#pragma mark - public

+ (CGFloat)defaultHeight {
    return 50;
}

#pragma mark - getter

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:YBIBIconManager.sharedManager.videoCancelImage() forState:UIControlStateNormal];
        _cancelButton.layer.shadowColor = UIColor.darkGrayColor.CGColor;
        _cancelButton.layer.shadowOffset = CGSizeMake(0, 1);
        _cancelButton.layer.shadowOpacity = 1;
        _cancelButton.layer.shadowRadius = 4;
        _cancelButton.hidden = YES;
    }
    return _cancelButton;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"2020-07-22 12:20:00";
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:YBIBIconManager.sharedManager.videoDeleteImage() forState:UIControlStateNormal];
        _deleteButton.hidden = YES;
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteButton;
}

- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setImage:YBIBIconManager.sharedManager.videoDownloadImage() forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadAction) forControlEvents:(UIControlEventTouchUpInside)];
        _downloadButton.hidden = YES;
    }
    return _downloadButton;
}

-(void)setContent:(NSString *)content{
    self.titleLabel.text = content;
}

-(void)hideDownloadBtn:(BOOL)isHide{
    self.deleteButton.hidden = isHide;
    self.downloadButton.hidden = isHide;
}


//删除
-(void)deleteAction{
//    [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteVideoNotification object:nil];
}

//下载
-(void)downloadAction{
//    [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadVideoNotification object:nil];
}



@end
