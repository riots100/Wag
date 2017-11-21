//
//  WagTableViewCell.h
//  Wag
//
//  Created by Bruce Johnson on 11/20/17.
//  Copyright © 2017 Proviz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, StarColor) {
    StarColorGold,
    StarColorSilver,
    StarColorBronze,
};

extern NSString *WagCellIdentifier;

@interface WagTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

- (void) updateWithDictionary: (NSDictionary *)entryDict;

@end
