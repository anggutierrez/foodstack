//
//  ListsViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/15/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ListsViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "RecipeCell.h"
#import "Recipe.h"

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
			NSLog(@"😎😎😎 Successfully loaded recipe list");
			self.recipes = (NSMutableArray *) recipes;
			
			[self.tableView reloadData];
		} else {
			NSLog(@"%@", error.localizedDescription);
		}
		[self.refreshControl endRefreshing];
	}];
}

- (IBAction)didTapProfile:(id)sender {
	[self performSegueWithIdentifier:@"ProfileSegue" sender:nil];
}

- (IBAction)didTapSearch:(id)sender {
	[self performSegueWithIdentifier:@"SearchSegue" sender:nil];
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
	RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
	
	Recipe *recipe = self.recipes[indexPath.row];
	cell.recipe = recipe;
	
	return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.recipes.count;
}

@end
