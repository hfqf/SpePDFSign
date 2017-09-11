//
//  MenuView.h
//  SpePDFSign
//
//  Created by points on 2017/9/11.
//  Copyright © 2017年 伍宏彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate <NSObject>

@required
- (void)onMenuItemSelected:(NSInteger)tag;

@end

@interface MenuView : UIView
@property(nonatomic,weak)id<MenuViewDelegate>m_delegate;

@end
