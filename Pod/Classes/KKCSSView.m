//
//  KKCSSView.m
//  KKCSSLayout
//
//  Created by Peter Mackay on 26/03/2015.
//  Copyright (c) 2014 Peter Mackay. All rights reserved.
//

#import "KKCSSView.h"

@implementation KKCSSView

#pragma mark UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSArray *subviews = self.subviews;
    if (subviews.count == 0) {
        return;
    }
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat scale = height / subviews.count;
    
    for (NSUInteger i = 0; i < subviews.count; ++i) {
        CGFloat top = i * scale;
        CGFloat bottom = (i + 1) * scale;
        UIView *subview = subviews[i];
        subview.frame = CGRectMake(0, top, width, bottom - top);
    }
}

@end
