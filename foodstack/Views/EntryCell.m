//
//  EntryCell.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "EntryCell.h"
#import "DateTools.h"

@implementation EntryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setEntry:(Entry *)entry {
	_entry = entry;
	//	self.photoImageView.file = recipe[@"image"];
	//	[self.photoImageView loadInBackground];
	
	self.entryTitle.text = entry[@"entryTitle"];
	self.entryDescription.text = entry[@"entryDescription"];
	
	NSString *calories = [NSString stringWithFormat:@"%@", entry[@"calCount"]];
	self.entryCalories.text = calories;
	
	NSDate *createdAtOriginalString = [self.entry createdAt];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	// Configure the input format to parse the date string
	formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
	self.entryTimestamp.text = [createdAtOriginalString shortTimeAgoSinceNow];
//	[formatter setDateFormat:@"M/d"];
//	self.entryTimestamp.text = [formatter stringFromDate:createdAtOriginalString];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
