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
- (void)setEntry:(Entry *)entry;
@property (strong, nonatomic) Entry *entry;
@property (weak, nonatomic) IBOutlet UILabel *entryCalories;
@property (weak, nonatomic) IBOutlet UILabel *entryTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *entryDescription;

@end

NS_ASSUME_NONNULL_END
