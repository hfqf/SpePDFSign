//
//  SpePDFEditViewController.m
//
//  Created by points on 2017/5/30.
//  Copyright © 2017年 points. All rights reserved.
//

#import "SpePDFEditViewController.h"
#import "UIView+WHB.h"
#import "HBDrawingBoard.h"
#import "MJExtension.h"

NSString * const PDFSavedNotification        = @"PDFSavedNotification";


@interface SpePDFEditViewController ()<HBDrawingBoardDelegate>
{
    UIView   *m_topMenuView;
    UIView   *m_bg;
    UISlider *m_slier;
    UILabel  *m_tipLab;
}
@property(nonatomic,strong)NSURL *m_pdfUrl;
@property (nonatomic, strong) HBDrawingBoard *drawView;
@end

@implementation SpePDFEditViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(id)initWith:(NSURL *)pdfUrl
{
    self.m_pdfUrl = pdfUrl;
    if(self = [super init])
    {
       [[NSNotificationCenter defaultCenter]addObserverForName:PDFSavedNotification
                                                        object:nil
                                                         queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                                                             NSString *path = note.object;
                                                             if(path.length > 0){
                                                                 [self.m_pdfDelegate onSavedNewPDF:path];
                                                                 [self onQuitPDFEdit];
                                                             }else{
                                                                 
                                                             }
           
       }];
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self drawSetting:nil];
}
- (IBAction)drawSetting:(id)sender {
    
    self.drawView.shapType = HBDrawingShapeCurve;
    
    [self.drawView showSettingBoard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.drawView];

    [self showMenuView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HBDrawingBoardDelegate

- (void)drawBoard:(HBDrawingBoard *)drawView action:(actionOpen)action{
    
    switch (action) {
        case actionOpenAlbum:
        {
            
        }
            
            break;
        case actionOpenCamera:
        {

        }
            break;
            
        default:
            break;
    }
    
}
- (void)drawBoard:(HBDrawingBoard *)drawView drawingStatus:(HBDrawingStatus)drawingStatus model:(HBDrawModel *)model{
    
    NSLog(@"%@",model.keyValues);
}

- (void)onShowOrHideMenuView
{
    [self showMenuView];
}


- (void)onZXCustomWindowState:(BOOL)isShow
{
    if(!isShow){
        self.drawView.shapType = HBDrawingShapeCurve;
    }
    [self.navigationController setNavigationBarHidden:isShow animated:YES];
}

- (void)onQuitPDFEdit
{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (HBDrawingBoard *)drawView
{
    if (!_drawView) {
        _drawView = [[HBDrawingBoard alloc] initWithFrame:CGRectMake(0, 50, self.view.width, self.view.height - 50) withPDFUrl:self.m_pdfUrl];
        _drawView.delegate = self;
        
    }
    return _drawView;
}

#pragma mark - 签批menu
- (void)showMenuView
{
    if(m_topMenuView == nil){
        m_topMenuView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
        [m_topMenuView setBackgroundColor:[UIColor colorWithRed:216.0/255.0 green:235.0/255.0 blue:234.0/255.0 alpha:0.5]];
        [self.view addSubview:m_topMenuView];

        for(int i=0;i<5;i++){
            int width = [UIScreen mainScreen].bounds.size.width/5;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setFrame:CGRectMake(width*i, 0, width, 50)];
            [btn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [m_topMenuView addSubview:btn];
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
    }else{

        m_topMenuView.hidden =! m_topMenuView.hidden;

        if(m_topMenuView.hidden){
            [self.drawView hideSettingBoard];
        }else{
            [self.drawView showSettingBoard];
        }
    }
}

- (void)hideMenuView
{

}

- (void)menuBtnClicked:(UIButton *)btn
{
    if(btn.tag == 0){

    }else if (btn.tag == 1){

    }else if (btn.tag == 1){

    }else if (btn.tag == 1){

    }else{
        
    }
}

@end
