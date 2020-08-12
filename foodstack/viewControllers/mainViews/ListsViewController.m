//
//  ListsViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/15/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ListsViewController.h"
#import "RecipeDetailsViewController.h"
#import "Parse/Parse.h"
#import "RecipeCell.h"
#import "Recipe.h"
#import "Utils.h"
#import "ApplicationScheme.h"


@interface ListsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *recipes;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.rowHeight = 105;
	
	id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
	self.view.backgroundColor = colorScheme.surfaceColor;
	self.tableView.backgroundColor = colorScheme.surfaceColor;
	
    self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(fetchRecipes) forControlEvents:UIControlEventValueChanged];
	[self.tableView insertSubview:self.refreshControl atIndex:0];
	
	[self fetchRecipes];
}

- (void)fetchRecipes {
	PFQuery *query = [PFQuery queryWithClassName:@"Recipe"];
	[query orderByDescending: @"createdAt"];
	[query includeKey:@"author"];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *recipes, NSError *error) {
		if (recipes != nil) {
			self.recipes = (NSMutableArray *) recipes;
		} else {
			NSLog(@"%@", error.localizedDescription);
		}
		[self currentUserRecipes];
		[self.refreshControl endRefreshing];
	}];
}

- (void) currentUserRecipes {
	NSInteger count = [self.recipes count];
	for (NSInteger index = (count - 1); index >= 0; index--) {
		Recipe *recipe= self.recipes[index];
		if (recipe.author.username != [PFUser currentUser].username) {
			[self.recipes removeObjectAtIndex:index];
		}
	}
	[self.tableView reloadData];
}

- (IBAction)didSwipeRight:(id)sender {
	self.tabBarController.selectedIndex = 0;
}

- (IBAction)didTapAdd:(id)sender {
		[self performSegueWithIdentifier:@"AddSegue" sender:nil];
}

- (IBAction)didTapSearch:(id)sender {
	[self performSegueWithIdentifier:@"SearchSegue" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqual:@"RecipeDetailsSegue"]) {
		UITableViewCell *tappedCell = sender;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
		Recipe *recipe = self.recipes[indexPath.row];
		
		RecipeDetailsViewController *detailsvc = [segue destinationViewController];
		detailsvc.recipe = recipe;
	}
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
	
	Recipe *recipe = self.recipes[indexPath.row];
	cell.recipe = recipe;
	
	id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
	cell.backgroundColor = colorScheme.surfaceColor;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RecipeCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (cell.isAnimated) {return;}
	
	cell.alpha = 0.0;
	[UIView animateWithDuration:1.0 animations:^{
	   cell.alpha = 1.0;
	   cell.isAnimated = YES;
	}];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.recipes.count;
}

@end
