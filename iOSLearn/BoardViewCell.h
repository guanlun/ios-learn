//
//  BoardViewCell.h
//  iOSLearn
//
//  Created by Guanlun Zhao on 12/9/13.
//  Copyright (c) 2013 Guanlun Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *boardNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *boardImage;

@end
