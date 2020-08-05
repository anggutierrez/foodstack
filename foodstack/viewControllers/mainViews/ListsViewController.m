//
//  ListsViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/15/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ListsViewController.h"
#import "LoginViewController.h"
#import "RecipeDetailsViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "RecipeCell.h"
#import "Recipe.h"
#import "Utils.h"

@interface ListsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *recipes;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.rowHeight = 105;
	
    self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(fetchRecipes) forControlEvents:UIControlEventValueChanged];
	[self.tableView insertSubview:self.refreshControl atIndex:0];
	
	[self fetchRecipes];
}

- (void)fetchRecipes {
	PFQuery *query = [PFQuery queryWithClassName:@"Recipe"];
	[query orderByDescending: @"createdAt"];
	query.limit = 20;
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *recipes, NSError *error) {
		if (recipes != nil) {
			self.recipes = (NSMutableArray *) recipes;
			
			[self.tableView reloadData];
		} else {
			NSLog(@"%@", error.localizedDescription);
		}
		[self.refreshControl endRefreshing];
	}];
}

- (IBAction)didSwipeLeft:(id)sender {
	[self performSegueWithIdentifier:@"ProfileSegue" sender:nil];
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
