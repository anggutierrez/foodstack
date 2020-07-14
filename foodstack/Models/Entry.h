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
@property (nonatomic, strong) PFFileObject *image;

@end

NS_ASSUME_NONNULL_END
