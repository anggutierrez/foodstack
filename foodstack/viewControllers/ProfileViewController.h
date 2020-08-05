//
//  ProfileViewController.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "Entry.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *profileUserLabel;

- (void) recommend;
@end

NS_ASSUME_NONNULL_END
