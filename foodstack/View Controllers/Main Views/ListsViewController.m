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
#import "Recipe.h"

@interface ListsViewController ()

@end

@implementation ListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	NSNumber *myNum = [NSNumber numberWithInteger:800];
	[Recipe postUserRecipe:@"Lasagna" withCalCount:myNum withRecipeDescription:@"This recipe uses 3 cheeses and red tomato sauce." withImage:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
		if (succeeded) {
			NSLog(@"Succesfully posted user recipe!");
		}
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

@end
