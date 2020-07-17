//
//  Recipe.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <Parse/Parse.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recipe : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *recipeTitle;
@property (nonatomic, strong) NSNumber *calCount;
@property (nonatomic, strong) NSString *recipeDescription;
@property (nonatomic, strong) PFFileObject *image;

+ (void) postUserRecipe: ( NSString * _Nullable )recipeTitle withCalCount: ( NSNumber * _Nullable )calCount withRecipeDescription: (NSString * _Nullable )recipeDescription withImage:( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
