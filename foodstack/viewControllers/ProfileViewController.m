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

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	PFUser *user = [PFUser currentUser];
	self.profileUserLabel.text = user.username;
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
	
	// Parse per user basis
	
	// Query recipes from Parse database
	
	// Query entries from Parse database
	// Put entries eaten wthin the week a different [set] - "hush"
	// Remove recipes at intersect with entries
	// Bubble sort
	
	// How does set work in objc
	
	// What is set
	// Basic logic / understanding for set
	// How to implement
	
	
	// Starting from highest rated - Loop down the array and crosscheck each recipe to every entry
		// If a recipe matches title / keywords from the past week: pop the recipe and move on to the next recipe
	
	// the top 3 recipes that weren't removed are placed in another array
	
	// STRETCH: Top 3 Recipes are checked to find repeating ingredients
		// Will then do search for most used ingredients and return top 3 results from spoonacular API
	
	// Recipes are recommended back to user in table view
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
