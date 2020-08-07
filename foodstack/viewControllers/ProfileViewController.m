//
//  ProfileViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "Recipe.h"
#import "Entry.h"
#import "RecommendationCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *topRecipes;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
		self.tableView.rowHeight = 120;
	
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
	
	// Recipes turn into NSSet
	NSSet *recipes = [NSSet setWithArray:(NSArray *)self.recipes];
	
	// Filter out entries older than 1 week
	// [self newestEntries];
	
	// Entries turn into NSSet
	NSSet *entries = [NSSet setWithArray:(NSArray *)self.entries];
	
	// Remove recipes that share a name with entries name
	NSSet *filteredSet = recipes; // - entries;
	
	// Bubble sort
	[self bubbleSort:filteredSet];
	
	// STRETCH: Top 3 Recipes are checked to find repeating ingredients
		// Will then do search for most used ingredients and return top 3 results from spoonacular API
	
	// Recipes are recommended back to user in table view
	[self.tableView reloadData];
}

- (void) bubbleSort:(NSSet *)set {
	NSMutableArray *arr = [NSMutableArray arrayWithArray:[set allObjects]];
	
	for (int index = 0; index < arr.count - 1; index++) {
		for (int j = 0; j < (arr.count - 1 - index); j++) {
			Recipe *recipe1 = arr[j];
			Recipe *recipe2 = arr[j + 1];
			if (recipe1.rating > recipe2.rating) {
				// Check if this is passing by reference
				[self swapRecipe:arr[j] withSecondRecipe:arr[j + 1]];
			}
		}
	}
	
	// Get the top 3 objects from the first array
	id objects[] = {arr[arr.count - 1], arr[arr.count - 2], arr[arr.count - 3]};
	NSUInteger count = sizeof(objects) / sizeof(id);
	_topRecipes = [NSArray arrayWithObjects:objects count:count];
}

- (void) swapRecipe:(Recipe *)recipe1 withSecondRecipe:(Recipe *)recipe2 {
	Recipe *tempRecipe = recipe1;
	
	recipe1 = recipe2;
	
	recipe2 = tempRecipe;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	RecommendationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendationCell" forIndexPath:indexPath];
	
	NSDictionary *recipe = self.topRecipes[indexPath.row];
	
	cell.recommendationTitle.text = recipe[@"recipeTitle"];
	cell.recommendationDescription.text = recipe[@"recipeDescription"];
	cell.recommendationImage.file = recipe[@"image"];
	[cell.recommendationImage loadInBackground];
	 
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RecommendationCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (cell.isAnimated) {return;}
	
	cell.alpha = 0.0;
	[UIView animateWithDuration:1.0 animations:^{
	   cell.alpha = 1.5;
	   cell.isAnimated = YES;
	}];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

@end
