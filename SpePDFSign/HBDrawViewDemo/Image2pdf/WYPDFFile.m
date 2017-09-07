//
//  WYPDFFile.m
//  WYPDFDemo
//
//  Created by Apple on 2017/5/25.
//  Copyright © 2017年 White-Young. All rights reserved.
//

#import "WYPDFFile.h"
#import "UIWebView+WYFile.h"
@implementation WYPDFFile

+ (BOOL)createPDFWithImages:(NSArray<UIImage *>*)images fileName:(NSString *)fileName{
    
    if (!images || images.count == 0) return NO;
    
    // pdf文件存储路径
    NSString *pdfPath = [self saveDirectory:fileName];
    NSLog(@"/****************文件路径*******************/\n\n%@\n\n",pdfPath);
    NSLog(@"/*****************************************/");
    
    
    CGFloat pdfFileWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat pdfFileHeight = [UIScreen mainScreen].bounds.size.height;
    
//    // 计算图片拼接的长度
//    [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        // 获取每张图片的长宽
//        CGFloat imageW = CGImageGetWidth(obj.CGImage);
//        CGFloat imageH = CGImageGetHeight(obj.CGImage);
//        
//        // 计算每张图片按屏宽比得到实际高度
//        CGFloat h = imageH * pdfFileWidth / imageW;
//        
//        pdfFileHeight += h;
//        
//    }];
    
    UIGraphicsBeginPDFContextToFile(pdfPath, CGRectMake(0, 0, pdfFileWidth, pdfFileHeight), NULL);
    __block CGFloat imageHeight = 0;
    [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIGraphicsBeginPDFPage();

        // 获取每张图片的长宽
        CGFloat imageW = CGImageGetWidth(obj.CGImage);
        CGFloat imageH = CGImageGetHeight(obj.CGImage);
        
        // 计算每张图片按屏宽比得到实际高度
        CGFloat h = imageH * pdfFileWidth / imageW;
        
        [obj drawInRect:CGRectMake(0, 0, pdfFileWidth, h)];
                
        
    }];
    
    UIGraphicsEndPDFContext();
    
    return YES;
}

+ (BOOL)creatPDFWithWebView:(UIWebView *)webView fileName:(NSString *)fileName{
    
    NSString *pdfPath = [self saveDirectory:fileName];
    NSData *pdfData = [webView convert2PDFData];
    BOOL result = [pdfData writeToFile:pdfPath atomically:YES];

    return result;
}


/**
 文件保存路径
 */
+ (NSString *)saveDirectory:(NSString *)fileName{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
}

@end
