//
//  MenuView.m
//  SpePDFSign
//
//  Created by points on 2017/9/11.
//  Copyright © 2017年 伍宏彬. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){

        [self setBackgroundColor:[UIColor colorWithRed:216.0/255.0 green:235.0/255.0 blue:234.0/255.0 alpha:0.5]];

        for(int i=0;i<5;i++){
            int width = [UIScreen mainScreen].bounds.size.width/5;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setFrame:CGRectMake(width*i, 20, width, 50)];
            [btn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.tag = i;
            if(i==0){
                [btn setImage:[UIImage imageNamed:@"es_erase"] forState:UIControlStateNormal];
            }else if (i==1){
                [btn setImage:[UIImage imageNamed:@"es_remark"] forState:UIControlStateNormal];
            }else if (i==2){
                [btn setImage:[UIImage imageNamed:@"es_instal"] forState:UIControlStateNormal];
            }else if (i==3){
                [btn setImage:[UIImage imageNamed:@"es_save"] forState:UIControlStateNormal];
            }else{
                [btn setImage:[UIImage imageNamed:@"es_saveout"] forState:UIControlStateNormal];
            }
        }

    }
    return self;
}

- (void)menuBtnClicked:(UIButton *)btn
{
    [self.m_delegate onMenuItemSelected:btn.tag];
}
@end
