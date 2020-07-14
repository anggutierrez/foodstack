//
//  LoginViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (IBAction)didTapLogin:(id)sender {
	if ([self _isValidInput]) {
		NSString *username = self.usernameField.text;
		NSString *password = self.passwordField.text;
		
		[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError * error) {
			if (error != nil) {
				NSLog(@"User log in failed: %@", error.localizedDescription);
			} else {
				NSLog(@"User logged in successfully");
				[self performSegueWithIdentifier:@"LoginSegue" sender:nil];
				// display view controller
			}
		}];
	}
}

- (IBAction)didTapSignUp:(id)sender {
	[self performSegueWithIdentifier:@"SignUpSegue" sender:nil];
}

- (BOOL) _isValidInput {
	if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Username or Passowrd" message:@"Fill in the required fields." preferredStyle:(UIAlertControllerStyleAlert)];
			
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
