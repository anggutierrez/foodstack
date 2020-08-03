//
//  EntryCell.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "EntryCell.h"
#import <GoogleMaps/GoogleMaps.h>
#import "DateTools.h"

@implementation EntryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setEntry:(Entry *)entry {
	_entry = entry;
	_isAnimated = NO;
	//	self.photoImageView.file = recipe[@"image"];
	//	[self.photoImageView loadInBackground];
	
	self.entryTitle.text = entry.entryTitle;
	self.entryDescription.text = entry.entryDescription;
	
	self.entryLatitude = entry.entryLatitude;
	self.entryLongitude = entry.entryLongitude;
	
	NSString *calories = [entry.calCount stringValue];
	self.entryCalories.text = calories;
	
	NSDate *createdAt = [entry createdAt];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	// Configure the input format to parse the date string
	formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
	self.entryTimestamp.text = [createdAt shortTimeAgoSinceNow];
//	[formatter setDateFormat:@"M/d"];
//	self.entryTimestamp.text = [formatter stringFromDate:createdAtOriginalString];
	
}

- (void) reverseGeoCode {
//	GMSGeocoder *geoCoder;
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
