//
//  HBDrawSettingBoard.h
//  DemoAntiAliasing
//
//  Created by 伍宏彬 on 15/11/4.
//  Copyright © 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBDrawCommon.h"
#import "UIImage_PDFModel.h"

typedef NS_ENUM(NSInteger,setType) {
    setTypePen,
    setTypeCamera,
    setTypeAlbum,
    setTypeSave,
    setTypeSaveAndQuit,
    setTypeEraser,
    setTypeBack,
    setTyperegeneration,
    setTypeClearAll,
    setTypeQuit,
};

typedef void(^boardSettingBlock)(setType type);

@interface HBDrawSettingBoard : UIView
- (void)getSettingType:(boardSettingBlock)type;
- (CGFloat)getLineWidth;
- (UIColor *)getLineColor;
@property (nonatomic,strong) UIImage_PDFModel *m_pdfModel;

@end


//画笔展示的球
@interface HBColorBall : UIView
@property (nonatomic, strong) UIColor *ballColor;

@property (nonatomic, assign) CGFloat ballSize;

@property (nonatomic, assign) CGFloat lineWidth;
@end
