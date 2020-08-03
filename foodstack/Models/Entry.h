//
//  Entry.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/14/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <Parse/Parse.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entry : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *entryTitle;
@property (nonatomic, strong) NSString *entryLongitude;
@property (nonatomic, strong) NSString *entryLatitude;
@property (nonatomic, strong) NSString *entryDescription;

@property (nonatomic, strong) NSNumber *calCount;
@property (nonatomic, strong) PFFileObject *image;

+ (void) postUserEntry: ( NSString * _Nullable )entryTitle
	   withDescription: ( NSString * _Nullable )entryDescription
		  withCalCount: ( NSNumber * _Nullable )calCount
		withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (void) postUserEntry: ( NSString * _Nullable )entryTitle
withDescription: ( NSString * _Nullable )entryDescription
   withCalCount: ( NSNumber * _Nullable )calCount withLatitude: (NSString * _Nullable )latitude withLongitude: (NSString * _Nullable)longitude
 withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
