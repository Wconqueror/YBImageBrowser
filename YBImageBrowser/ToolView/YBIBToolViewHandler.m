//
//  YBIBToolViewHandler.m
//  YBImageBrowserDemo
//
//  Created by 波儿菜 on 2019/7/7.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBIBToolViewHandler.h"
#import "YBIBCopywriter.h"
#import "YBIBUtilities.h"
#import "YBIBImageBottomBar.h"

@interface YBIBToolViewHandler ()
@property (nonatomic, strong) YBIBSheetView *sheetView;
@property (nonatomic, strong) YBIBSheetAction *saveAction;
@property (nonatomic, strong) YBIBTopView *topView;
@property (nonatomic, strong) YBIBImageBottomBar *bottomView;

@end

@implementation YBIBToolViewHandler

#pragma mark - <YBIBToolViewHandler>

@synthesize yb_containerView = _yb_containerView;
@synthesize yb_containerSize = _yb_containerSize;
@synthesize yb_currentPage = _yb_currentPage;
@synthesize yb_totalPage = _yb_totalPage;
@synthesize yb_currentOrientation = _yb_currentOrientation;
@synthesize yb_currentData = _yb_currentData;

- (void)yb_containerViewIsReadied {
    [self.yb_containerView addSubview:self.topView];
    [self.yb_containerView addSubview:self.bottomView];
    [self layoutWithExpectOrientation:self.yb_currentOrientation()];
}

- (void)yb_pageChanged {
    if (self.topView.operationType == YBIBTopViewOperationTypeSave) {
        self.topView.operationButton.hidden = [self currentDataShouldHideSaveButton];
    }
    [self.topView setPage:self.yb_currentPage() totalPage:self.yb_totalPage()];
}

- (void)yb_respondsToLongPress {
    [self showSheetView];
}

- (void)yb_hide:(BOOL)hide {
    self.topView.hidden = hide;
    [self.sheetView hideWithAnimation:NO];
}

- (void)yb_orientationWillChangeWithExpectOrientation:(UIDeviceOrientation)orientation {
    [self.sheetView hideWithAnimation:NO];
}

- (void)yb_orientationChangeAnimationWithExpectOrientation:(UIDeviceOrientation)orientation {
    [self layoutWithExpectOrientation:orientation];
}

#pragma mark - private

- (BOOL)currentDataShouldHideSaveButton {
    id<YBIBDataProtocol> data = self.yb_currentData();
    BOOL allow = [data respondsToSelector:@selector(yb_allowSaveToPhotoAlbum)] && [data yb_allowSaveToPhotoAlbum];
    BOOL can = [data respondsToSelector:@selector(yb_saveToPhotoAlbum)];
    return !(allow && can);
}

- (void)layoutWithExpectOrientation:(UIDeviceOrientation)orientation {
    CGSize containerSize = self.yb_containerSize(orientation);
    UIEdgeInsets padding = YBIBPaddingByBrowserOrientation(orientation);
    
    self.topView.frame = CGRectMake(padding.left, padding.top, containerSize.width - padding.left - padding.right, [YBIBTopView defaultHeight]);
    if (orientation == UIDeviceOrientationPortrait) {
        self.bottomView.frame = CGRectMake(0,containerSize.height - padding.bottom - [YBIBImageBottomBar defaultHeight], containerSize.width, [YBIBImageBottomBar defaultHeight]);
    }else{
        self.bottomView.frame = CGRectMake(containerSize.width - 2*padding.right - 150,padding.top, 150, [YBIBImageBottomBar defaultHeight]);
    }
    [self.bottomView backgroundColorByOrientation:orientation];
}

- (void)showSheetView {
    if ([self currentDataShouldHideSaveButton]) {
        [self.sheetView.actions removeObject:self.saveAction];
    } else {
        if (![self.sheetView.actions containsObject:self.saveAction]) {
            [self.sheetView.actions addObject:self.saveAction];
        }
    }
    [self.sheetView showToView:self.yb_containerView orientation:self.yb_currentOrientation()];
}

#pragma mark - getters

- (YBIBSheetView *)sheetView {
    if (!_sheetView) {
        _sheetView = [YBIBSheetView new];
        __weak typeof(self) wSelf = self;
        [_sheetView setCurrentdata:^id<YBIBDataProtocol>{
            __strong typeof(wSelf) self = wSelf;
            if (!self) return nil;
            return self.yb_currentData();
        }];
    }
    return _sheetView;
}

- (YBIBSheetAction *)saveAction {
    if (!_saveAction) {
        __weak typeof(self) wSelf = self;
        _saveAction = [YBIBSheetAction actionWithName:[YBIBCopywriter sharedCopywriter].saveToPhotoAlbum action:^(id<YBIBDataProtocol> data) {
            __strong typeof(wSelf) self = wSelf;
            if (!self) return;
            if ([data respondsToSelector:@selector(yb_saveToPhotoAlbum)]) {
                [data yb_saveToPhotoAlbum];
            }
            [self.sheetView hideWithAnimation:YES];
        }];
    }
    return _saveAction;
}

- (YBIBTopView *)topView {
    if (!_topView) {
        _topView = [YBIBTopView new];
        _topView.operationType = YBIBTopViewOperationTypeMore;
        __weak typeof(self) wSelf = self;
        [_topView setClickOperation:^(YBIBTopViewOperationType type) {
            __strong typeof(wSelf) self = wSelf;
            if (!self) return;
            switch (type) {
                case YBIBTopViewOperationTypeSave: {
                    id<YBIBDataProtocol> data = self.yb_currentData();
                    if ([data respondsToSelector:@selector(yb_saveToPhotoAlbum)]) {
                        [data yb_saveToPhotoAlbum];
                    }
                }
                    break;
                case YBIBTopViewOperationTypeMore: {
                    [self showSheetView];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    return _topView;
}


-(YBIBImageBottomBar *)bottomView{
    if (!_bottomView) {
        _bottomView = [YBIBImageBottomBar new];
        __weak typeof(self) wSelf = self;
        _bottomView.clickOperation = ^(YBIBBottomViewOperationType type) {
            __strong typeof(wSelf) self = wSelf;
            if (!self) return ;
            switch (type) {
                case YBIBBottomViewOperationTypeDownload:
                {
                    id<YBIBDataProtocol> data = self.yb_currentData();
                    if ([data respondsToSelector:@selector(yb_saveToPhotoAlbum)]) {
                        [data yb_saveToPhotoAlbum];
                    }
                }
                    break;
                case YBIBBottomViewOperationTypeShare:
                {
                    NSLog(@"分享");
                }
                    break;
                case YBIBBottomViewOperationTypeDelete:
                {
                    id<YBIBDataProtocol> data = self.yb_currentData();
                    if ([data respondsToSelector:@selector(yb_saveToPhotoAlbum)]) {
                        [data yb_saveToPhotoAlbum];
                    }
                }
                default:
                    break;
            }
        };
    }
    return _bottomView;
}



@end
