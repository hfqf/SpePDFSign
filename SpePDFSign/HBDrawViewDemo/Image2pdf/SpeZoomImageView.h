//
//  SpeZoomImageView.h
//  VIPhotoViewDemo
//
//  Created by points on 2017/5/30.
//  Copyright © 2017年 vito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeZoomImageView : UIImageView<UIGestureRecognizerDelegate>
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程度
    UIPinchGestureRecognizer *m_pinchGestureRecognizer;
}

- (float)scale;

- (void)reset;
@end
