//
//  RecommendationCell.h
//  foodstack
//
//  Created by Angel Gutierrez on 8/6/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface RecommendationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *recommendationImage;
@property (weak, nonatomic) IBOutlet UILabel *recommendationTitle;
@property (weak, nonatomic) IBOutlet UILabel *recommendationDescription;


@end

NS_ASSUME_NONNULL_END
