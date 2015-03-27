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
@property (nonatomic) IBInspectable BOOL flexWrap;
@property (nonatomic) IBInspectable NSString *justifyContent;
@property (nonatomic) IBInspectable NSString *alignItems;

@end
