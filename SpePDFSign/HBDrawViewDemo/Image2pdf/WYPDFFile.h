//
//  WYPDFFile.h
//  WYPDFDemo
//
//  Created by Apple on 2017/5/25.
//  Copyright © 2017年 White-Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WYPDFFile : NSObject

/**
 图片转PDF

 @param fileName 文件名
 @param images 图片数组
 */
+ (BOOL)createPDFWithImages:(NSArray<UIImage *>*)images fileName:(NSString *)fileName;

+ (BOOL)creatPDFWithWebView:(UIWebView *)webView fileName:(NSString *)fileName;

+ (NSString *)saveDirectory:(NSString *)fileName;

@end
