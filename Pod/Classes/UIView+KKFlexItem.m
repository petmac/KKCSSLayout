//
//  UIView+KKFlexItem.m
//  KKCSSLayout
//
//  Created by Peter Mackay on 26/03/2015.
//  Copyright (c) 2014 Peter Mackay. All rights reserved.
//

#import "UIView+KKFlexItem.h"

#import <objc/runtime.h>

static const void *const alignSelfKey = &alignSelfKey;
static const void *const flexKey = &flexKey;
static const void *const marginKey = &marginKey;

@implementation UIView (KKFlexItem)

- (void)setAlignSelf:(NSString *)alignSelf {
    objc_setAssociatedObject(self, alignSelfKey, alignSelf, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)alignSelf {
    return objc_getAssociatedObject(self, alignSelfKey);
}

- (void)setFlex:(CGFloat)flex {
    objc_setAssociatedObject(self, flexKey, @(flex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)flex {
    NSNumber *flex = objc_getAssociatedObject(self, flexKey);
    return [flex floatValue];
}

- (void)setMargin:(CGFloat)margin {
    objc_setAssociatedObject(self, marginKey, @(margin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)margin {
    NSNumber *margin = objc_getAssociatedObject(self, marginKey);
    return [margin floatValue];
}

@end
