//
//  SpeZoomImageView.m
//  VIPhotoViewDemo
//
//  Created by points on 2017/5/30.
//  Copyright © 2017年 vito. All rights reserved.
//

#import "SpeZoomImageView.h"

@implementation SpeZoomImageView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setMultipleTouchEnabled:YES];
        [self setUserInteractionEnabled:YES];
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds = YES;
        oldFrame = self.frame;
        largeFrame = CGRectMake(0 - [UIScreen mainScreen].bounds.size.width, 0 - [UIScreen mainScreen].bounds.size.height, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
        [self addGestureRecognizerToView:self];
        
        [[NSNotificationCenter defaultCenter]addObserverForName:@"SpeZoomImageView"
                                                         object:nil
                                                          queue:nil
                                                     usingBlock:^(NSNotification * _Nonnull note) {
                                                         NSString *flag = note.object;
                                                         if([flag integerValue] == 1)
                                                         {
                                                             [self setUserInteractionEnabled:NO];
                                                         }else
                                                         {
                                                             [self setUserInteractionEnabled:YES];
                                                         }
        }];
        
    }
    return self;
}
// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
// 旋转手势
//UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
//[view addGestureRecognizer:rotationGestureRecognizer];

    // 缩放手势
    m_pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:m_pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}
//
//// 处理缩放手势
//- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
//{
//    UIView *view = pinchGestureRecognizer.view;
//    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//        pinchGestureRecognizer.scale = 1;
//    }
//}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    if (self.frame.size.width < oldFrame.size.width) {
    self.frame = oldFrame;
    //让图片无法缩得比原图小
    }
    if (self.frame.size.width > 3 * oldFrame.size.width) {
    self.frame = largeFrame;
    }
    pinchGestureRecognizer.scale = 1;
    }
}

- (void)reset
{
    self.frame = oldFrame;
    m_pinchGestureRecognizer.scale = 1;
    self.transform = CGAffineTransformScale(self.transform, m_pinchGestureRecognizer.scale, m_pinchGestureRecognizer.scale);
}
@end
