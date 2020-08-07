//
//  RecommendationCell.m
//  foodstack
//
//  Created by Angel Gutierrez on 8/6/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "RecommendationCell.h"

@implementation RecommendationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	_isAnimated = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
