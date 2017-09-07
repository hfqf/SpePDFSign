//
//  UIImage_PDF_exampleViewController.h
//  UIImage+PDF example
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage+PDF.h"


@interface UIImage_PDFModel : NSObject {

}
@property (nonatomic,strong) NSMutableArray *m_arrPDFImages;
@property (assign) NSInteger m_indexPage;
- (id)initWith:(NSURL *)url;
@end

