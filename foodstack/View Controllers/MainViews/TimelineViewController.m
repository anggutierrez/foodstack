//
//  TimelineViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/15/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "EntryCell.h"
#import "Entry.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *entries;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

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
	
}

- (void)fetchEntries {
	PFQuery *query = [PFQuery queryWithClassName:@"Entry"];
	[query orderByDescending: @"createdAt"];
	query.limit = 20;
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *entries, NSError *error) {
		if (entries != nil) {
			NSLog(@"😎😎😎 Successfully loaded entries");
			self.entries = (NSMutableArray *) entries;
			
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

- (IBAction)didTapAdd:(id)sender {
	[self performSegueWithIdentifier:@"AddSegue" sender:nil];
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
	EntryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell" forIndexPath:indexPath];
	
	Entry *entry = self.entries[indexPath.row];
	cell.entry = entry;
	
	return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.entries.count;
}

@end
