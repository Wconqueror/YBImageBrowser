//
//  YBIBVideoBottomBar.h
//  newVsee
//
//  Created by xiaoyang on 2022/1/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,YBIBBottomViewOperationType){
    YBIBBottomViewOperationTypeDownload,                //下载
    YBIBBottomViewOperationTypeShare,                   //分享
    YBIBBottomViewOperationTypeDelete,                  //删除
};

@interface YBIBImageBottomBar : UIView

/// 按钮类型
@property (nonatomic, assign) YBIBBottomViewOperationType operationType;

/// 点击操作按钮的回调
@property (nonatomic, copy) void(^clickOperation)(YBIBBottomViewOperationType type);


+(CGFloat)defaultHeight;


-(void)backgroundColorByOrientation:(UIDeviceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
