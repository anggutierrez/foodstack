//
//  Recipe.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic recipeTitle;
@dynamic calCount;
@dynamic recipeDescription;

@dynamic image;

+ (nonnull NSString *)parseClassName {
    return @"Recipe";
}

+ (void) postUserRecipe: ( NSString * _Nullable )recipeTitle withCalCount: ( NSNumber * _Nullable )calCount withRecipeDescription: (NSString * _Nullable )recipeDescription withImage:( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Recipe *newRecipe = [Recipe new];
	newRecipe.recipeTitle = recipeTitle;
	newRecipe.calCount = calCount;
	newRecipe.recipeDescription = recipeDescription;
	newRecipe.image = [self getPFFileFromImage:image];
    newRecipe.author = [PFUser currentUser];
    
    [newRecipe saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

/* -- Put this in the viewDidLoad() to test funcionality
NSNumber *myNum = [NSNumber numberWithInteger:800];
[Recipe postUserRecipe:@"Lasagna" withCalCount:myNum withRecipeDescription:@"This recipe uses 3 cheeses and red tomato sauce." withImage:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
	if (succeeded) {
		NSLog(@"Succesfully posted user recipe!");
	}
}];
 */

@end
