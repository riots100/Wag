//
//  StackExManager.h
//  Wag
//
//  Created by Bruce Johnson on 11/20/17.
//  Copyright © 2017 Proviz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackExManager : NSObject

@property (readonly) NSArray *entries;

- (void) fetchEnties: (NSInteger)numberOfEntries completionHandler:(void (^)(BOOL success, NSError *error))completionHandler;


@end


@interface NSDictionary (StackExEntries)

- (NSArray *) entries;
- (NSString *) displayName;
- (NSURL *) avatarImageURL;
- (NSInteger) goldBadgeCounts;
- (NSInteger) silverBadgeCounts;
- (NSInteger) bronzeBadgeCounts;

@end
