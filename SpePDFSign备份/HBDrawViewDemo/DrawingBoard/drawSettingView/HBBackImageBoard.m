//
//  HBBackImageBoard.m
//  DemoAntiAliasing
//
//  Created by 伍宏彬 on 15/11/6.
//  Copyright © 2015年 HB. All rights reserved.
//

#import "HBBackImageBoard.h"
#import "BackImageBoardCollectionViewCell.h"


@interface HBBackImageBoard()
{
    NSIndexPath *_lastIndexPath;
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation HBBackImageBoard

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BackImageBoardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionImageBoardViewID forIndexPath:indexPath];
    
    cell.pdfImage = self.array[indexPath.item];
    cell.indexLbel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item+1];
    if (indexPath.item == 0 && !_lastIndexPath) {
        
         _lastIndexPath = indexPath;
        cell.selectImage.hidden = NO;
        cell.layer.borderColor = [UIColor purpleColor].CGColor;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageBoardNotification object:nil userInfo:[NSDictionary dictionaryWithObject:cell.pdfImage forKey:@"imageBoardName"]];

    }else{
        cell.selectImage.hidden = YES;
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_lastIndexPath) {
        
        BackImageBoardCollectionViewCell *cell = (BackImageBoardCollectionViewCell *)[collectionView cellForItemAtIndexPath:_lastIndexPath];
        cell.selectImage.hidden = YES;
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    _lastIndexPath = indexPath;
    
    BackImageBoardCollectionViewCell *cell = (BackImageBoardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectImage.hidden = NO;
    cell.layer.borderColor = [UIColor purpleColor].CGColor;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ImageBoardNotification object:nil userInfo:[NSDictionary dictionaryWithObject:cell.pdfImage forKey:@"imageBoardName"]];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}


- (void)setPDFImages:(NSArray *)arrPDFImages
{
    self.array = arrPDFImages;
    [self.collectionView reloadData];
    
}
@end
