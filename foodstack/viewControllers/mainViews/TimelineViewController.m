//
//  TimelineViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/15/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "TimelineViewController.h"
#import "ProfileViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Parse/Parse.h"
#import "MapViewController.h"
#import "EntryCell.h"
#import "Entry.h"
#import "Recipe.h"
#import "Utils.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *entries;
@property (nonatomic, strong) NSMutableArray *recipes;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) GMSGeocoder *geoCoder;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.rowHeight = 105;
	
    self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(fetchEntries) forControlEvents:UIControlEventValueChanged];
	[self.tableView insertSubview:self.refreshControl atIndex:0];
	
	[self fetchEntries];
	[self fetchRecipes];
	
	self.geoCoder = [GMSGeocoder geocoder];
}

- (void)fetchEntries {
	PFQuery *query = [PFQuery queryWithClassName:@"Entry"];
	[query orderByDescending: @"createdAt"];
	query.limit = 20;
	[query includeKey:@"author"];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *entries, NSError *error) {
		if (entries != nil) {
			self.entries = (NSMutableArray *) entries;
		} else {
			NSLog(@"%@", error.localizedDescription);
		}
		[self currentUserEntries];
		[self.refreshControl endRefreshing];
	}];
}

- (void) currentUserEntries {
	NSInteger count = [self.entries count];
	for (NSInteger index = (count - 1); index >= 0; index--) {
		Entry *entry = self.entries[index];
		if (entry.author.username != [PFUser currentUser].username) {
			[self.entries removeObjectAtIndex:index];
		}
	}
	[self.tableView reloadData];
}

- (void)fetchRecipes {
	PFQuery *query = [PFQuery queryWithClassName:@"Recipe"];
	[query orderByDescending: @"createdAt"];
	query.limit = 20;
	[query includeKey:@"author"];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *recipes, NSError *error) {
		if (recipes != nil) {
			self.recipes = (NSMutableArray *) recipes;
		} else {
			NSLog(@"%@", error.localizedDescription);
		}
		[self currentUserRecipes];
	}];
}

- (void) currentUserRecipes {
	NSInteger count = [self.recipes count];
	for (NSInteger index = (count - 1); index >= 0; index--) {
		Recipe *recipe = self.recipes[index];
		if (recipe.author.username != [PFUser currentUser].username) {
			[self.recipes removeObjectAtIndex:index];
		}
	}
}

- (IBAction)didTapAdd:(id)sender {
	[self performSegueWithIdentifier:@"AddSegue" sender:nil];
}

- (IBAction)didTapSearch:(id)sender {
	[self performSegueWithIdentifier:@"SearchSegue" sender:nil];
}

- (IBAction)didTapProfile:(id)sender {
	[self performSegueWithIdentifier:@"ProfileSegue" sender:nil];
}

- (IBAction)didSwipeRight:(id)sender {
	[self performSegueWithIdentifier:@"ProfileSegue" sender:nil];
}

- (IBAction)didSwipeLeft:(id)sender {
	self.tabBarController.selectedIndex = 1;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqual:@"LocationSegue"]) {
		UITableViewCell *tappedCell = sender;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
		Entry *entry = self.entries[indexPath.row];
		
		UINavigationController *navVC = [segue destinationViewController];
		MapViewController *mapvc = navVC.topViewController;
		mapvc.entry = entry;
	} else if ([segue.identifier isEqual:@"ProfileSegue"]) {
		ProfileViewController *profilevc = [segue destinationViewController];
		profilevc.recipes = self.recipes;
		profilevc.entries = self.entries;
	} else {
		
	}
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	EntryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell" forIndexPath:indexPath];
	Entry *entry = self.entries[indexPath.row];
	cell.entry = entry;
	
	[self.geoCoder reverseGeocodeCoordinate:CLLocationCoordinate2DMake([entry.entryLatitude doubleValue], [entry.entryLongitude doubleValue]) completionHandler:^(GMSReverseGeocodeResponse * _Nullable response, NSError * _Nullable error) {
		if (!error) {
			cell.entryLocation.text = response.firstResult.locality;
		}
	}];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EntryCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (cell.isAnimated) {return;}
	
	cell.alpha = 0.0;
	[UIView animateWithDuration:1.0 animations:^{
	   cell.alpha = 1.0;
	   cell.isAnimated = YES;
	}];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.entries.count;
}

@end
