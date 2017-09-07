//
//  ZXCustomWindow.h
//  MosterColock
//
//  Created by wuhongbin on 15/6/25.
//  Copyright (c) 2015年 wuhongbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZXCustomWindowDelegate <NSObject>

@required
- (void)onZXCustomWindowState:(BOOL)isShow;

@end

@interface ZXCustomWindow : UIWindow

- (instancetype)initWithAnimationView:(UIView *)animationView;

@property (nonatomic, assign) NSTimeInterval animationTime;
@property (nonatomic, assign) BOOL m_state;
@property (nonatomic,weak)id<ZXCustomWindowDelegate>m_delegate;

- (void)showWithAnimationTime:(NSTimeInterval)second;

- (void)hideWithAnimationTime:(NSTimeInterval)second;



@end
