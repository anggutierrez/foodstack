//
//  Utils.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/29/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "Utils.h"
#import "Parse/Parse.h"

@implementation Utils

+ (NSNumber *) stringToNumber:(NSString *)origString {
	NSNumberFormatter *calorieFormatter = [[NSNumberFormatter alloc] init];
	calorieFormatter.numberStyle = NSNumberFormatterDecimalStyle;

	return [calorieFormatter numberFromString:origString];
}

+ (NSString *) decimalAccuracy:(double)num {
	NSNumber *newNum = [NSNumber numberWithDouble:num];
	
	NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc] init];
	numberformatter.numberStyle = NSNumberFormatterDecimalStyle;
	numberformatter.minimumFractionDigits = 2;
	numberformatter.maximumFractionDigits = 2;
	
	return [numberformatter stringFromNumber:newNum];
}

+ (NSString *) stringFromDouble:(double)myDouble {
	NSNumber *myDoubleNumber = [NSNumber numberWithDouble:myDouble];
	
	return [myDoubleNumber stringValue];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

// Move geocoder function to util class

@end
