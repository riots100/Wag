//
//  WagTableViewCell.m
//  Wag
//
//  Created by Bruce Johnson on 11/20/17.
//  Copyright © 2017 Proviz. All rights reserved.
//

#import "WagTableViewCell.h"
#import "StackExManager.h"

NSString *WagCellIdentifier = @"WagCellIdentifier";

@interface WagTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;

@end


@implementation WagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateWithDictionary: (NSDictionary *)entryDict
{
    self.displayNameLabel.text = [entryDict displayName];
    
    NSInteger gold = [entryDict goldBadgeCounts];
    NSInteger silver = [entryDict silverBadgeCounts];
    NSInteger bronze = [entryDict bronzeBadgeCounts];
    
    NSMutableAttributedString *badgeString = [[NSMutableAttributedString alloc] init];
    [badgeString appendAttributedString: [self starColor: StarColorGold]];
    [badgeString appendAttributedString: [self stringForBadgeCount: gold]];
    [badgeString appendAttributedString: [self starColor: StarColorSilver]];
    [badgeString appendAttributedString: [self stringForBadgeCount: silver]];
    [badgeString appendAttributedString: [self starColor: StarColorBronze]];
    [badgeString appendAttributedString: [self stringForBadgeCount: bronze]];

    self.badgeLabel.attributedText = badgeString;
    
}

- (NSAttributedString *) starColor: (StarColor)color
{
    NSMutableAttributedString *attibutedString = [[NSMutableAttributedString alloc] initWithString: @"★"];
    UIColor *starColor = [UIColor blackColor];
    
    switch (color) {
        case StarColorGold:
            starColor = [UIColor colorWithRed: 1.0 green: 0.75 blue: 0.0 alpha: 1.0];
            break;
        case StarColorSilver:
            starColor = [UIColor colorWithRed: 0.7 green: 0.7 blue: 0.7 alpha: 1.0];
            break;
        case StarColorBronze:
            starColor = [UIColor colorWithRed: 0.75 green: 0.5 blue: 0.25 alpha: 1.0];
            break;
    }
    
    UIFont *font = [UIFont systemFontOfSize: 24.0];
    [attibutedString addAttribute: NSFontAttributeName value: font range: NSMakeRange(0, 1)];
    [attibutedString addAttribute: NSForegroundColorAttributeName value: starColor range: NSMakeRange(0, 1)];

    return attibutedString;
}

- (NSAttributedString *) stringForBadgeCount: (NSInteger)badgecount
{
    NSString *number = [NSString stringWithFormat: @"%ld   ", badgecount];
    NSMutableAttributedString *attibutedString = [[NSMutableAttributedString alloc] initWithString: number];
    UIColor *fontcolor = [UIColor blackColor];

    UIFont *font = [UIFont systemFontOfSize: 15.0];
    [attibutedString addAttribute: NSFontAttributeName value: font range: NSMakeRange(0, number.length)];
    [attibutedString addAttribute: NSForegroundColorAttributeName value: fontcolor range: NSMakeRange(0, number.length)];

    return attibutedString;
}
@end
