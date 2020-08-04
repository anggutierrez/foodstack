//
//  RecipeDetailsViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 8/4/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "RecipeDetailsViewController.h"
#import "Utils.h"
@import Parse;

@interface RecipeDetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailRecipeName;
@property (weak, nonatomic) IBOutlet UILabel *detailRating;
@property (weak, nonatomic) IBOutlet UITextField *detailRatingField;

@end

@implementation RecipeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.detailImageView.file = _recipe.image;
	[self.detailImageView loadInBackground];
	
	self.detailRecipeName.text = _recipe.recipeTitle;
	self.detailRating.text = [_recipe.rating stringValue];
	
}

- (IBAction)didTapUpdate:(id)sender {
	
}

- (BOOL) _isValidInput {
	NSNumber *rating = [Utils stringToNumber:self.detailRatingField.text];
	if (self.detailRatingField.hasText && rating != nil) {
		
		
		return YES;
		} else {
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incomplete Form" message:@"Fill in the required fields." preferredStyle:(UIAlertControllerStyleAlert)];
			
			UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				// Handle response here
			}];
			
			[alert addAction:okAction];
			
			[self presentViewController:alert animated:YES completion:^{
			}];
			
			return NO;
		}
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
