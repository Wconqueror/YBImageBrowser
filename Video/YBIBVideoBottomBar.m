//
//  YBIBVideoBottomBar.m
//  newVsee
//
//  Created by xiaoyang on 2022/1/18.
//

#import "YBIBVideoBottomBar.h"
#import "YBIBIconManager.h"

@interface YBIBVideoBottomBar ()

@property (nonatomic,strong) UIButton *downloadBtn;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *deleteBtn;

@end

@implementation YBIBVideoBottomBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.blackColor;
        [self addSubview:self.downloadBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.deleteBtn];
    }
    return self;
}

-(UIButton *)downloadBtn{
    if (!_downloadBtn) {
        _downloadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_downloadBtn setImage:YBIBIconManager.sharedManager.videoDownloadImage() forState:(UIControlStateNormal)];
        [_downloadBtn setTitle:NSLocalizedString(@"下载", nil) forState:(UIControlStateNormal)];
        _downloadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_downloadBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        [_downloadBtn addTarget:self action:@selector(downloadAction) forControlEvents:(UIControlEventTouchUpInside)];
        _downloadBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 15, 0);
        _downloadBtn.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0,25);
    }
    return _downloadBtn;
}

-(UIButton *)shareBtn{
    if (!_shareBtn){
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_shareBtn setImage:YBIBIconManager.sharedManager.videoDownloadImage() forState:(UIControlStateNormal)];
        [_shareBtn setTitle:NSLocalizedString(@"分享", nil) forState:(UIControlStateNormal)];
        [_shareBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 15, 0);
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0,25);
        _shareBtn.hidden = YES;
    }
    return _shareBtn;
}

-(UIButton *)deleteBtn{
    if (!_deleteBtn){
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn setImage:YBIBIconManager.sharedManager.videoDeleteImage() forState:(UIControlStateNormal)];
        [_deleteBtn setTitle:NSLocalizedString(@"删除", nil) forState:(UIControlStateNormal)];
        [_deleteBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:(UIControlEventTouchUpInside)];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 15, 0);
        _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0,25);
    }
    return _deleteBtn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = 80;
    CGFloat space = (self.bounds.size.width - width * 2) / 3.0;
    self.downloadBtn.frame = CGRectMake(space, 0, width, self.bounds.size.height);
    self.shareBtn.frame = CGRectMake(self.bounds.size.width / 2.0 - width / 2.0, 0, width, self.bounds.size.height);
    self.deleteBtn.frame = CGRectMake(self.bounds.size.width - width - space, 0, width, self.bounds.size.height);
}

//删除
-(void)deleteAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteVideoNotification object:nil];
}

//下载
-(void)downloadAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadVideoNotification object:nil];
}



+(CGFloat)defaultHeight{
    return 70;
}


@end
