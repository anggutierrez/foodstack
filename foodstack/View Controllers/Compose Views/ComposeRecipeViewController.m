//
//  ComposeRecipeViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "ComposeRecipeViewController.h"
#import "Recipe.h"

@interface ComposeRecipeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *composeTitleField;
@property (weak, nonatomic) IBOutlet UITextField *composeCaloriesField;
@property (weak, nonatomic) IBOutlet UITextView *composeDescField;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;


@end

@implementation ComposeRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
	//  UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
	self.recipeImageView.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)onTapSave:(id)sender {
	NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
	f.numberStyle = NSNumberFormatterDecimalStyle;
	NSNumber *cal = [f numberFromString:self.composeCaloriesField.text];
	
	UIImage *resized = [self resizeImage:self.recipeImageView.image withSize:CGSizeMake(150, 150)];
	
	if (![self _isEmpty]) {
		[Recipe postUserRecipe:self.composeTitleField.text withCalCount:cal withRecipeDescription:self.composeDescField.text withImage:resized withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
			if (!error) {
				[self dismissViewControllerAnimated:true completion:nil];
			} else {
				NSLog(@"%@", error.localizedDescription);
			}
		}];
	}
}

- (bool) _isEmpty {
	if (!self.composeTitleField.hasText && !self.composeCaloriesField.hasText) {
		return YES;
	}
	
	return NO;
}

- (IBAction)onTapImage:(id)sender {
	UIImagePickerController *imagePickerVC = [UIImagePickerController new];
	imagePickerVC.delegate = self;
	imagePickerVC.allowsEditing = YES;

	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
	} else {
		NSLog(@"Camera unavailable");
		imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}
	
	[self presentViewController:imagePickerVC animated:YES completion:nil];
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
