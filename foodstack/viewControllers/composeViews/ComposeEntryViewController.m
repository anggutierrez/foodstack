//
//  ComposeEntryViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ComposeEntryViewController.h"
#import "Entry.h"
#import "ApplicationScheme.h"
#import "Utils.h"

@interface ComposeEntryViewController ()
@property (weak, nonatomic) IBOutlet UITextField *composeTitleField;
@property (weak, nonatomic) IBOutlet UITextField *composeCalField;
@property (weak, nonatomic) IBOutlet UITextView *composeDescField;
@property (weak, nonatomic) IBOutlet UILabel *myLatitude;
@property (weak, nonatomic) IBOutlet UILabel *myLongitude;


@end

@implementation ComposeEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
	self.view.backgroundColor = colorScheme.surfaceColor;
	
	_location = [[CLLocationManager alloc] init];
	_location.delegate = self;
	_location.desiredAccuracy = kCLLocationAccuracyBest;
	_location.distanceFilter = kCLDistanceFilterNone;
	[_location startUpdatingLocation];
}

- (bool) _isEmpty {
	if (self.composeTitleField.hasText && self.composeCalField.hasText && self.composeDescField.hasText) {
		return NO;
	}
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Title, Calories, or Description!" message:@"Fill in the required fields." preferredStyle:(UIAlertControllerStyleAlert)];
	
	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
	
	[alert addAction:okAction];
	
	[self presentViewController:alert animated:YES completion:^{
	}];
	
	return YES;
}

- (bool) _hasLocation {
	if ([self.myLatitude.text isEqual:@"nil"] && [self.myLongitude.text isEqual:@"nil"]) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Title, Calories, or Description!" message:@"Fill in the required fields." preferredStyle:(UIAlertControllerStyleAlert)];
		
		UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
		
		[alert addAction:okAction];
		
		[self presentViewController:alert animated:YES completion:^{
		}];
		
		return NO;
	}
	
	return YES;
}

- (IBAction)onTapSave:(id)sender {
	NSNumber *cal = [Utils stringToNumber:self.composeCalField.text];
	
	if (![self _isEmpty] && ![self _hasLocation]) {
		[Entry postUserEntry:self.composeTitleField.text
			 withDescription:self.composeDescField.text
				withCalCount:cal withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
		if (!error) {
			[self dismissViewControllerAnimated:true completion:nil];
		} else {
			NSLog(@"%@", error.localizedDescription);
		}
			}];
	} else {
		[Entry postUserEntry:self.composeTitleField.text withDescription:self.composeDescField.text withCalCount:cal withLatitude:self.myLatitude.text withLongitude:self.myLongitude.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
			if (!error) {
				[self dismissViewControllerAnimated:true completion:nil];
			} else {
				NSLog(@"%@", error.localizedDescription);
			}
		}];
	}
}

- (IBAction)onTapCancel:(id)sender {
	[self dismissViewControllerAnimated:true completion:nil];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	self.myLatitude.text = [Utils stringFromDouble:locations.lastObject.coordinate.latitude];
	self.myLongitude.text = [Utils stringFromDouble:locations.lastObject.coordinate.longitude];
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
