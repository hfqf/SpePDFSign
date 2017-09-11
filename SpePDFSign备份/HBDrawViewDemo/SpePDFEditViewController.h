//
//  SpePDFEditViewController.h
//
//  Created by points on 2017/5/30.
//  Copyright © 2017年 points. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpePDFEditViewControllerDelegate <NSObject>

@required



/**
 保存签批pdf成功后,返回本地路径

 @param localFilePath 沙盒路径
 */
- (void)onSavedNewPDF:(NSString *)localFilePath;

@end

@interface SpePDFEditViewController : UIViewController

@property(nonatomic,weak)id<SpePDFEditViewControllerDelegate>m_pdfDelegate;


/**
 初始化

 @param pdfUrl pdf本地路径
 @return 
 */
-(id)initWith:(NSURL *)pdfUrl;
@end
