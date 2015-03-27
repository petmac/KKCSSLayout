//
//  KKFlexContainer.h
//  KKCSSLayout
//
//  Created by Peter Mackay on 26/03/2015.
//  Copyright (c) 2014 Peter Mackay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKFlexContainer : UIView

@property (nonatomic) IBInspectable BOOL columnFlexDirection;
@property (nonatomic) IBInspectable NSString *justifyContent;
@property (nonatomic) IBInspectable NSString *alignItems;
// @property (nonatomic) IBInspectable NSString *alignSelf;
@property (nonatomic) IBInspectable BOOL absolutePosition;
@property (nonatomic) IBInspectable BOOL flexWrap;
// @property (nonatomic) IBInspectable CGFloat flex;

@property (nonatomic) IBInspectable CGFloat leftMargin;
@property (nonatomic) IBInspectable CGFloat topMargin;
@property (nonatomic) IBInspectable CGFloat rightMargin;
@property (nonatomic) IBInspectable CGFloat bottomMargin;

@property (nonatomic) IBInspectable CGRect position;

// TODO Padding may be redundant.
@property (nonatomic) IBInspectable CGFloat leftPadding;
@property (nonatomic) IBInspectable CGFloat topPadding;
@property (nonatomic) IBInspectable CGFloat rightPadding;
@property (nonatomic) IBInspectable CGFloat bottomPadding;

// TODO Border may be redundant.
@property (nonatomic) IBInspectable CGFloat leftBorder;
@property (nonatomic) IBInspectable CGFloat topBorder;
@property (nonatomic) IBInspectable CGFloat rightBorder;
@property (nonatomic) IBInspectable CGFloat bottomBorder;

@end
