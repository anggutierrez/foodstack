//
//  Entry.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "Entry.h"

@implementation Entry

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic calCount;
@dynamic entryTitle;
@dynamic entryDescription;
@dynamic entryLongitude;
@dynamic entryLatitude;

@dynamic image;

+ (nonnull NSString *)parseClassName {
    return @"Entry";
}

+ (void) postUserEntry: ( NSString * _Nullable )entryTitle
	   withDescription: ( NSString * _Nullable )entryDescription
		  withCalCount: ( NSNumber * _Nullable )calCount
		withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Entry *newEntry = [Entry new];
	newEntry.entryTitle = entryTitle;
	newEntry.entryDescription = entryDescription;
	newEntry.calCount = calCount;
    newEntry.author = [PFUser currentUser];
    
    [newEntry saveInBackgroundWithBlock: completion];
}

+ (void) postUserEntry: ( NSString * _Nullable )entryTitle
	   withDescription: ( NSString * _Nullable )entryDescription
		  withCalCount: ( NSNumber * _Nullable )calCount
		  withLatitude: (NSString * _Nullable )entryLatitude
		 withLongitude: (NSString * _Nullable)entryLongitude
		withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Entry *newEntry = [Entry new];
	newEntry.entryTitle = entryTitle;
	newEntry.entryDescription = entryDescription;
	newEntry.calCount = calCount;
	newEntry.entryLatitude = entryLatitude;
	newEntry.entryLongitude = entryLongitude;
    newEntry.author = [PFUser currentUser];
    
    [newEntry saveInBackgroundWithBlock: completion];
}

@end
