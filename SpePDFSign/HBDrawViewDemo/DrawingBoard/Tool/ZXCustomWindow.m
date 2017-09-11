//
//  ZXCustomWindow.m
//  MosterColock
//
//  Created by wuhongbin on 15/6/25.
//  Copyright (c) 2015年 wuhongbin. All rights reserved.
//

#import "ZXCustomWindow.h"


@interface ZXCustomWindow()

@property (nonatomic, weak) UIView *animationView;
@property (nonatomic,strong)MenuView *m_menuView;
@end

@implementation ZXCustomWindow

- (instancetype)initWithAnimationView:(UIView *)animationView
{
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        
        self.windowLevel = UIWindowLevelAlert;
        
        self.animationView = animationView;

        
        [self addSubview:self.animationView];


        self.m_menuView = [[MenuView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 70)];
        self.m_menuView.m_delegate = self;
        [self addSubview:self.m_menuView];

        [[NSNotificationCenter defaultCenter] addObserverForName:@"hideTopWindow" object:nil queue:nil usingBlock:^(NSNotification *note) {
            
            [self hideWithAnimationTime:self.animationTime];
            
        }];
        
    }
    return self;

}


#pragma mark - MenuViewDelegate

- (void)onMenuItemSelected:(NSInteger)tag
{
    [self.m_delegate onMenuItem:tag];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];

    if(self.m_delegate && [self.m_delegate respondsToSelector:@selector(onHideMenuView)]){
        [self.m_delegate onHideMenuView];
    }
    if (!CGRectContainsPoint(self.animationView.frame, touchPoint))
        [self hideWithAnimationTime:self.animationTime];

}

- (void)showWithAnimationTime:(NSTimeInterval)second
{
    self.animationTime  = second;
    [self makeKeyAndVisible];
    
//    if (!self.hidden) return;
    [UIView animateWithDuration:self.animationTime delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.animationView.transform = CGAffineTransformMakeTranslation(0, -self.animationView.bounds.size.height+64);
            
        }];
       
        
    } completion:^(BOOL finished) {
        
        
        self.hidden = NO;
        
    }];
    
}

- (void)hideWithAnimationTime:(NSTimeInterval)second
{
    self.animationTime  = second;
//    if (self.hidden) return;
    
    [UIView animateWithDuration:self.animationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.animationView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            self.hidden = YES;
            //        whblog(@"隐藏");
            
        }];
        
    } completion:^(BOOL finished) {
        
     
//        self.hidden = YES;
////        whblog(@"隐藏");
        
    }];
    
}
#pragma mark - delloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideTopWindow" object:nil];
}

@end
