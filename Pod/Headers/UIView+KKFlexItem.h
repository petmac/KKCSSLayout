//
//  UIView+KKFlexItem.h
//  KKCSSLayout
//
//  Created by Peter Mackay on 26/03/2015.
//  Copyright (c) 2014 Peter Mackay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KKFlexItem)

@property (nonatomic) IBInspectable NSString *alignSelf;
@property (nonatomic) IBInspectable CGFloat flex;
@property (nonatomic) IBInspectable CGFloat margin;

@end
