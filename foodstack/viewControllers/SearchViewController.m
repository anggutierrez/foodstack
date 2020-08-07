//
//  SearchViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "ApplicationScheme.h"
#import "UIImageView+AFNetworking.h"
#import "Utils.h"
#import <StripHTML/NSString+StripHTML.h>

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) NSArray *recipes;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.rowHeight = 120;
	
	id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
	self.view.backgroundColor = colorScheme.surfaceColor;
	self.tableView.backgroundColor = colorScheme.surfaceColor;
	
}
- (IBAction)didTapSearch:(id)sender {
	if (![self.searchTextField.text isEqual:@""]) {
		[self searchRecipe:self.searchTextField.text];
		[self.tableView reloadData];
	}
}

- (void) searchRecipe:(NSString * _Nullable)searchQuery {
	NSString *baseURL = @"https://api.spoonacular.com/recipes/complexSearch?apiKey=0d90464651d5440fb07b64ea0f0d6185";
	
	searchQuery = [@"&query=" stringByAppendingString:searchQuery];
	
	NSString *numberResults = [@"&number=" stringByAppendingString:@"15"];
	
	NSString *includeRecipeInformation = [@"&addRecipeInformation=" stringByAppendingString:@"false"];
	NSString *includeRecipeNutrition = [@"&addRecipeNutrition=" stringByAppendingString:@"true"];
	
	NSString *includeExtendedInformation = [includeRecipeInformation stringByAppendingString:includeRecipeNutrition];
	
	NSString *fullURL = [NSString stringWithFormat:@"%@%@%@", searchQuery, numberResults, includeExtendedInformation];
	
	NSString *newURL = [baseURL stringByAppendingString:fullURL];
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
	
	NSDictionary *recipe = self.recipes[indexPath.row];
	cell.recipe = self.recipes[indexPath.row];
	
	cell.searchRecipeLabel.text = recipe[@"title"];
	NSString *taglessString = [recipe[@"summary"] removeTags];
	cell.searchIngredientsLabel.text = taglessString;
	cell.searchCalories.text = [recipe[@"nutrition"][@"nutrients"][0][@"amount"] stringValue];
	
    NSString *imageURLString = recipe[@"image"];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
	
	[cell.searchImageView setImageWithURL:imageURL];
	
	id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
	cell.backgroundColor = colorScheme.surfaceColor;

	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SearchCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
