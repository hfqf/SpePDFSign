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
#import "MenuView.h"
NSString * const PDFSavedNotification        = @"PDFSavedNotification";


@interface SpePDFEditViewController ()<HBDrawingBoardDelegate,MenuViewDelegate>
{

}
@property(nonatomic,strong)NSURL *m_pdfUrl;
@property (nonatomic, strong) HBDrawingBoard *drawView;
@property (nonatomic,strong) MenuView *m_menuView;
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
                                                                 if(self.m_pdfDelegate && [self.m_pdfDelegate respondsToSelector:@selector(onSavedNewPDF:)]){
                                                                     [self.m_pdfDelegate onSavedNewPDF:path];
                                                                 }

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
     [self drawSetting:nil];
     [self.drawView.settingBoard showSelectView];
}

- (void)onMenuItem:(NSInteger)tag
{
    if(self.m_menuView){
        [self.m_menuView removeFromSuperview];
        self.m_menuView = nil;
    }

    if(tag == 0){

        [self.drawView.settingBoard eraserBtnClicked];

    }else if (tag == 1){

        self.m_menuView = [[MenuView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
        self.m_menuView.m_delegate = self;
        [self.view addSubview:self.m_menuView];

        [self.drawView.settingBoard startSignBtnClicked];

    }else if (tag == 2){

        self.m_menuView = [[MenuView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
        self.m_menuView.m_delegate = self;
        [self.view addSubview:self.m_menuView];
        [self.drawView.settingBoard signEditBtnClicked];
    }else if (tag == 3){
        [self.drawView hideSettingBoard];
        [self.drawView.settingBoard saveBtnClicked];
    }else{
        [self.drawView hideSettingBoard];
        [self.drawView.settingBoard saveAndQutiBtnClicked];
    }
}

- (void)onQuitPDFEdit:(NSString *)pdfPath
{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)onSaveWith:(NSString *)pdfPath
{
    self.m_pdfUrl = [NSURL fileURLWithPath:pdfPath];
    [self.drawView hideSettingBoard];
    [self.drawView resetPdfDatasources:self.m_pdfUrl];

}


- (void)onZXCustomWindowState:(BOOL)isShow
{
    if(!isShow){
        self.drawView.shapType = HBDrawingShapeCurve;
    }
    [self.navigationController setNavigationBarHidden:isShow animated:YES];
}

- (void)onMenuItemSelected:(NSInteger)tag
{
    [self onMenuItem:tag];
}


- (HBDrawingBoard *)drawView
{
    if (!_drawView) {
        _drawView = [[HBDrawingBoard alloc] initWithFrame:CGRectMake(0, 50, self.view.width, self.view.height - 50) withPDFUrl:self.m_pdfUrl];
        _drawView.delegate = self;
        
    }
    return _drawView;
}


@end
