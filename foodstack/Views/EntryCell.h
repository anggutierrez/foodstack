//
//  EntryCell.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface EntryCell : UITableViewCell
@property (strong, nonatomic) Entry *entry;
@property (weak, nonatomic) IBOutlet UILabel *entryCalories;
@property (weak, nonatomic) IBOutlet UILabel *entryTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *entryDescription;
@property (weak, nonatomic) IBOutlet UILabel *entryTitle;

@property (assign, nonatomic) BOOL isAnimated;
@property (strong, nonatomic) NSString *entryLatitude;
@property (strong, nonatomic) NSString *entryLongitude;
@property (weak, nonatomic) IBOutlet UILabel *entryLocation;



- (void)setEntry:(Entry *)entry;

@end

NS_ASSUME_NONNULL_END
