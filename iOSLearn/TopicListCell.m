//
//  TopicListCell.m
//  iOSLearn
//
//  Created by Guanlun Zhao on 12/7/13.
//  Copyright (c) 2013 Guanlun Zhao. All rights reserved.
//

#import "TopicListCell.h"

@implementation TopicListCell

@synthesize titleLabel;
@synthesize descriptionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
