//
//  StackExManager.m
//  Wag
//
//  Created by Bruce Johnson on 11/20/17.
//  Copyright © 2017 Proviz. All rights reserved.
//

#import "StackExManager.h"



NSString *stackExURL = @"https://api.stackexchange.com/2.2/users?site=stackoverflow&page=1&pagesize=%ld";



@interface StackExManager ()

@property (readwrite, strong) NSArray *entries;

@end


@implementation StackExManager

- (void) fetchEnties: (NSInteger)numberOfEntries completionHandler:(void (^)(BOOL success, NSError *error))completionHandler
{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: config];
    NSString *urlString = [NSString stringWithFormat: stackExURL, numberOfEntries];
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithURL: url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
        
        if (urlResponse.statusCode == 200) {
            
            if (data) {
                
                NSError *jsonError = nil;
                id responseObject = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingAllowFragments error: &jsonError];
                
                if (responseObject && [responseObject isKindOfClass: [NSDictionary class]]) {
                    NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                    self.entries = [responseDictionary entries];
                    completionHandler(YES, nil);
                    
                } else if (jsonError) {
                    completionHandler(NO, jsonError);
                } else {
                    completionHandler(NO, [NSError errorWithDomain: @"StackExManager" code: 1000 userInfo: @{NSLocalizedDescriptionKey : @"response object not valid"}]);
                }
                
            }
            
        } else if (error) {
            completionHandler(NO, error);
        } else {
            completionHandler(NO, [NSError errorWithDomain: @"StackExManager" code: 1001 userInfo: @{NSLocalizedDescriptionKey : @"No response object"}]);
        }
        

    }];
    
    [sessionDataTask resume];
    
}

@end



@implementation NSDictionary (StackExEntries)

- (NSArray *) entries
{
    return self[@"items"];
}

- (NSString *) displayName
{
    return self[@"display_name"];
}

- (NSURL *) avatarImageURL
{
    NSString *urlString = self[@"profile_image"];
    return [NSURL URLWithString: urlString];
}

- (NSInteger) goldBadgeCounts
{
    NSDictionary *badges = self[@"badge_counts"];
    NSNumber *count = badges[@"gold"];
    return count.integerValue;
}

- (NSInteger) silverBadgeCounts
{
    NSDictionary *badges = self[@"badge_counts"];
    NSNumber *count = badges[@"silver"];
    return count.integerValue;
}

- (NSInteger) bronzeBadgeCounts
{
    NSDictionary *badges = self[@"badge_counts"];
    NSNumber *count = badges[@"bronze"];
    return count.integerValue;
}


@end


