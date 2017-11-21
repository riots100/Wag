//
//  UIView+ActivityIndicator.m
//  Wag
//
//  Created by Bruce Johnson on 11/20/17.
//  Copyright © 2017 Proviz. All rights reserved.
//

#import "UIView+ActivityIndicator.h"

@implementation UIView (ActivityIndicator)

- (UIActivityIndicatorView *) addActivityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    
    [self addSubview: activityIndicator];
    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *horizontalConstrant = [NSLayoutConstraint constraintWithItem: activityIndicator
                                                                           attribute: NSLayoutAttributeCenterX
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: self
                                                                           attribute: NSLayoutAttributeCenterX
                                                                          multiplier: 1 constant: 0];
    [self addConstraint: horizontalConstrant];
    
    NSLayoutConstraint *verticalConstrant = [NSLayoutConstraint constraintWithItem: activityIndicator
                                                                           attribute: NSLayoutAttributeCenterY
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: self
                                                                           attribute: NSLayoutAttributeCenterY
                                                                          multiplier: 1 constant: 0];
    [self addConstraint: verticalConstrant];
    
    return activityIndicator;
}

@end
