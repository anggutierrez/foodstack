//
//  SearchViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *recipes;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self searchRecipe:@"lasagna"];
	
}

- (void) searchRecipe:(NSString * _Nullable)searchQuery {
	
	NSString *baseURL = @"https://api.spoonacular.com/recipes/complexSearch?apiKey=0d90464651d5440fb07b64ea0f0d6185";
	searchQuery = [@"&query=" stringByAppendingString:searchQuery];
	NSLog(@"%@", searchQuery);
	NSString *newURL = [baseURL stringByAppendingString:searchQuery];
	NSLog(@"%@", newURL);
	NSURL *url = [NSURL URLWithString:newURL];
	
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error == nil) {
			   NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

						  self.recipes = dataDictionary[@"results"];
			   
						  // Used to make sure I was properly calling
						  NSLog(@"%@", dataDictionary);
						  [self.tableView reloadData];
           }
       }];
    [task resume];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
	
	return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
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
