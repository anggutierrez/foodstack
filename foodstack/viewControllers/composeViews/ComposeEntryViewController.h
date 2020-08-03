//
//  ComposeEntryViewController.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/17/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import MapKit;

NS_ASSUME_NONNULL_BEGIN

@interface ComposeEntryViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *location;

@end

NS_ASSUME_NONNULL_END
