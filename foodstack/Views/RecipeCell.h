//
//  RecipeCell.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface RecipeCell : UITableViewCell
- (void)setRecipe:(Recipe *)recipe;
@property (strong, nonatomic) Recipe *recipe;
@property (weak, nonatomic) IBOutlet UILabel *recipeTitle;
@property (weak, nonatomic) IBOutlet UILabel *recipeDescription;
@property (weak, nonatomic) IBOutlet UILabel *recipeType;


@end

NS_ASSUME_NONNULL_END
