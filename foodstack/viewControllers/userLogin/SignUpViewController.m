//
//  SignUpViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/15/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapRegister:(id)sender {
	if ([self _isValidInput ]) {
		// initialize a user object
		PFUser *newUser = [PFUser user];
		
		// set user properties
		newUser.username = self.usernameField.text;
		newUser.password = self.passwordField.text;
		newUser.email = self.emailField.text;
		
		// call sign up function on the object
		[newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
			if (error != nil) {
				NSLog(@"Error: %@", error.localizedDescription);
			} else {
				NSLog(@"User registered successfully");
				[self performSegueWithIdentifier:@"LoginSegue" sender:nil];
			}
		}];
	}
	
}

- (BOOL) _isValidInput {
	if (!self.usernameField.hasText || !self.passwordField.hasText || !self.emailField.hasText) {
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incomplete Form" message:@"Fill in the required fields." preferredStyle:(UIAlertControllerStyleAlert)];
			
			UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				// Handle response here
			}];
			
			[alert addAction:okAction];
			
			[self presentViewController:alert animated:YES completion:^{
			}];
		
		return NO;
			
		} else {
			return YES;
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
