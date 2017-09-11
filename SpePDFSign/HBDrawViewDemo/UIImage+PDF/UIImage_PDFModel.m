//
//  UIImage_PDF_exampleViewController.m
//  UIImage+PDF example
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix. All rights reserved.
//

#import "UIImage_PDFModel.h"

@interface UIImage_PDFModel ()

@property (nonatomic, strong) NSMutableArray *collection;

@end

@implementation UIImage_PDFModel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)refreshPDF:(NSURL *)url
{
    self.m_url = url;
    self.m_arrPDFImages = [NSMutableArray array];

    CFURLRef ref = (__bridge CFURLRef)(url);
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL( ref);

    size_t pageCount = CGPDFDocumentGetNumberOfPages( pdf );

    CGPDFDocumentRelease( pdf );


    for(int i = 0; i < pageCount; i++)
    {
        CGSize imageSize =  [[UIScreen mainScreen] bounds].size;

        UIImage *image = [ UIImage imageWithPDFURL:url fitSize:imageSize atPage:i+1];
        [self.m_arrPDFImages addObject:image];

    }

    //接受背景图片修改的通知
    [[NSNotificationCenter defaultCenter] addObserverForName:@"ImageBoardNotification" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        UIImage *img = [note.userInfo objectForKey:@"imageBoardName"];
        NSInteger index = [self.m_arrPDFImages indexOfObject:img];
        self.m_indexPage = index;
    }];

}


- (id)initWith:(NSURL *)url
{
    if(self = [super init])
    {
        self.m_url = url;
        self.m_arrPDFImages = [NSMutableArray array];
        
//        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"pdf"]];
        
        CFURLRef ref = (__bridge CFURLRef)(url);
        CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL( ref);
        
        size_t pageCount = CGPDFDocumentGetNumberOfPages( pdf );
        
        CGPDFDocumentRelease( pdf );
        
        
        for(int i = 0; i < pageCount; i++)
        {
            CGSize imageSize =  [[UIScreen mainScreen] bounds].size;
            
            UIImage *image = [ UIImage imageWithPDFURL:url fitSize:imageSize atPage:i+1];
            [self.m_arrPDFImages addObject:image];
 
        }
        
        
        //接受背景图片修改的通知
        [[NSNotificationCenter defaultCenter] addObserverForName:@"ImageBoardNotification" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            UIImage *img = [note.userInfo objectForKey:@"imageBoardName"];
            NSInteger index = [self.m_arrPDFImages indexOfObject:img];
            self.m_indexPage = index;
        }];
    

    }
    return self;
}




@end
