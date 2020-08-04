//
//  RecipeCell.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "RecipeCell.h"

@implementation RecipeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
}

- (void)setRecipe:(Recipe *)recipe {
	_recipe = recipe;
	_isAnimated = NO;
	
	self.recipeImageView.file = recipe.image;
	[self.recipeImageView loadInBackground];
	
	self.recipeTitle.text = recipe.recipeTitle;
	self.recipeDescription.text = recipe.recipeDescription;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
