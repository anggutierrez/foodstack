//
//  SearchCell.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/15/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;
@property (weak, nonatomic) IBOutlet UILabel *searchRecipeLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchIngredientsLabel;


@end

NS_ASSUME_NONNULL_END
