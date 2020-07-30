//
//  Utils.h
//  foodstack
//
//  Created by Angel Gutierrez on 7/29/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"


NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject
+ (NSNumber *) stringToNumber:(NSString *)origString;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
