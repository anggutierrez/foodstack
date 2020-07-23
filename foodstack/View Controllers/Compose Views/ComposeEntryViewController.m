//
//  ComposeEntryViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ComposeEntryViewController.h"
#import "Entry.h"

@interface ComposeEntryViewController ()
@property (weak, nonatomic) IBOutlet UITextField *composeTitleField;
@property (weak, nonatomic) IBOutlet UITextField *composeCalField;
@property (weak, nonatomic) IBOutlet UITextView *composeDescField;


@end

@implementation ComposeEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (bool) _isEmpty {
	if (!self.composeTitleField.hasText && !self.composeCalField.hasText && !self.composeDescField.hasText) {
		return YES;
	}
	
	return NO;
}

- (IBAction)onTapSave:(id)sender {
	NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
	f.numberStyle = NSNumberFormatterDecimalStyle;
	NSNumber *cal = [f numberFromString:self.composeCalField.text];
	
	if (![self _isEmpty]) {
		[Entry postUserEntry:self.composeTitleField.text withDescription:self.composeDescField.text withCalCount:cal withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
