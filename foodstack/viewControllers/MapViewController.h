//
//  MapViewController.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/28/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, strong) Entry *entry;
@end

NS_ASSUME_NONNULL_END
