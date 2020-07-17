//
//  ProfileViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogout:(id)sender {
	NSLog(@"Logout getting called.");
	
	SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
	
	sceneDelegate.window.rootViewController = loginViewController;
	
	[PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {}];
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
