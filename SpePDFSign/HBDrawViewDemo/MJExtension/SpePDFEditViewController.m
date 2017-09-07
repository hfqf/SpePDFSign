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
    self.title = @"签批";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.drawView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"签批设置" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 80, 44)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    [btn addTarget:self action:@selector(drawSetting:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [backBtn setFrame:CGRectMake(0, 0, 80, 44)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [backBtn addTarget:self action:@selector(onQuitPDFEdit) forControlEvents:UIControlEventTouchUpInside];
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
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIImagePickerController *pickVc = [[UIImagePickerController alloc] init];
                
                pickVc.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickVc.delegate = self;
                [self presentViewController:pickVc animated:YES completion:nil];
                
            }else{
                
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
            }
        }
            break;
            
        default:
            break;
    }
    
}
- (void)drawBoard:(HBDrawingBoard *)drawView drawingStatus:(HBDrawingStatus)drawingStatus model:(HBDrawModel *)model{
    
    NSLog(@"%@",model.keyValues);
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


@end
