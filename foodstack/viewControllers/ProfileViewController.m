//
//  ProfileViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "Recipe.h"
#import "Entry.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	PFUser *user = [PFUser currentUser];
	self.profileUserLabel.text = user.username;
	
	[self recommend];
}

- (IBAction)didTapLogout:(id)sender {
	SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
	
	sceneDelegate.window.rootViewController = loginViewController;
	
	[PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {}];
}

- (void) recommend {
	//	Recipe *recommendedRecipe;
	
	// Query recipes from Parse database
	NSSet *recipes = [NSSet setWithArray:[self queryEntries]];
	
	// Query entries from Parse database
//	NSSet *entries = [NSSet setWithArray:_entries];
	
	// Remove recipes at intersect with entries
	//	NSSet *filteredSet =
	
	// Bubble sort
	
	// Starting from highest rated - Loop down the array and crosscheck each recipe to every entry
		// If a recipe matches title / keywords from the past week: pop the recipe and move on to the next recipe
	
	// the top 3 recipes that weren't removed are placed in another array
	
	// STRETCH: Top 3 Recipes are checked to find repeating ingredients
		// Will then do search for most used ingredients and return top 3 results from spoonacular API
	
	// Recipes are recommended back to user in table view
}

- (NSMutableArray *)queryEntries {
	__block NSMutableArray *myEntries;
	PFQuery *query = [PFQuery queryWithClassName:@"Entry"];
	[query includeKey:@"author"];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *entries, NSError *error) {
		if (entries != nil) {
			myEntries = (NSMutableArray *)entries;
		} else {
			NSLog(@"%@", error.localizedDescription);
		}
	}];
	NSInteger count = [myEntries count];
	for (NSInteger index = (count - 1); index >= 0; index--) {
		Entry *entry = myEntries[index];
		if (entry.author.username != [PFUser currentUser].username) {
			[myEntries removeObjectAtIndex:index];
		}
	}
	
	return myEntries;
}

/*
- (void)queryRecipes {
	PFQuery *query = [PFQuery queryWithClassName:@"Recipe"];
	[query includeKey:@"author"];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *recipes, NSError *error) {
		if (recipes != nil) {
			self.recipes = (NSMutableArray *) recipes;
		} else {
			NSLog(@"%@", error.localizedDescription);
		}
		
		NSInteger count = [self.recipes count];
		for (NSInteger index = (count - 1); index >= 0; index--) {
			Recipe *recipe = self.recipes[index];
			if (recipe.author.username != [PFUser currentUser].username) {
				[self.recipes removeObjectAtIndex:index];
			}
		}
	}];
}
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
