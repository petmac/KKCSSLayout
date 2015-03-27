//
//  KKFlexContainer.mm
//  KKCSSLayout
//
//  Created by Peter Mackay on 26/03/2015.
//  Copyright (c) 2014 Peter Mackay. All rights reserved.
//

#import "KKFlexContainer.h"

extern "C" {
#import "Layout.h"
}

#import <vector>

typedef std::vector<css_node_t> NodeList;

#pragma mark css_node_t callbacks

static bool isNodeDirty(void *) {
    return true;
}

static css_node_t *getChildNode(void *context, int i) {
    css_node_t *childNodes = static_cast<css_node_t *>(context);
    return &childNodes[i];
}

static css_dim_t measure(void *context, float width) {
    UIView *view = (__bridge UIView *)context;
    assert([view isKindOfClass:[UIView class]]);
    
    CGSize size = view.intrinsicContentSize;
    
    css_dim_t dim = {};
    dim.dimensions[CSS_WIDTH] = size.width;
    dim.dimensions[CSS_HEIGHT] = size.height;

    return dim;
}

@implementation KKFlexContainer

#pragma mark UIView

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.subviews.count == 0) {
        return;
    }

    NodeList subviewNodes(self.subviews.count);
    [self setSubviewNodes:&subviewNodes];
    
    css_node_t node = {};
    [self setSelfNode:&node];
    
    node.context = &subviewNodes[0];
    layoutNode(&node, self.bounds.size.width);
    node.context = NULL;

    [self setSubviewFramesFromNodes:subviewNodes];
}

#pragma mark Private

- (void)setSelfNode:(css_node_t *)node {
    init_css_node(node);
    node->is_dirty = &isNodeDirty;
    node->get_child = &getChildNode;
    node->children_count = static_cast<int>(self.subviews.count);
    
    css_style_t *style = &node->style;
    style->flex_direction = self.columnFlexDirection ? CSS_FLEX_DIRECTION_COLUMN : CSS_FLEX_DIRECTION_ROW;
    style->justify_content = [KKFlexContainer parseJustifyContent:self.justifyContent];
    style->align_items = [KKFlexContainer parseAlignItems:self.alignItems];
    style->align_self = CSS_ALIGN_AUTO;
    style->position_type = self.absolutePosition ? CSS_POSITION_ABSOLUTE : CSS_POSITION_RELATIVE;
    style->flex_wrap = self.flexWrap ? CSS_WRAP : CSS_NOWRAP;
    style->flex = 0;
    
    style->margin[CSS_LEFT] = self.leftMargin;
    style->margin[CSS_TOP] = self.topMargin;
    style->margin[CSS_RIGHT] = self.rightMargin;
    style->margin[CSS_BOTTOM] = self.bottomMargin;
    
    style->position[CSS_LEFT] = CGRectGetMinX(self.position);
    style->position[CSS_TOP] = CGRectGetMinY(self.position);
    style->position[CSS_RIGHT] = CGRectGetMaxX(self.position);
    style->position[CSS_BOTTOM] = CGRectGetMaxY(self.position);
    
    style->padding[CSS_LEFT] = self.leftPadding;
    style->padding[CSS_TOP] = self.topPadding;
    style->padding[CSS_RIGHT] = self.rightPadding;
    style->padding[CSS_BOTTOM] = self.bottomPadding;
    
    style->border[CSS_LEFT] = self.leftBorder;
    style->border[CSS_TOP] = self.topBorder;
    style->border[CSS_RIGHT] = self.rightBorder;
    style->border[CSS_BOTTOM] = self.bottomBorder;
    
    style->dimensions[CSS_WIDTH] = self.bounds.size.width;
    style->dimensions[CSS_HEIGHT] = self.bounds.size.height;
}

- (void)setSubviewNodes:(NodeList *)nodes {
    NSAssert(nodes->size() == self.subviews.count, @"Node list size doesn't match subview count.");
    
    for (NSUInteger i = 0; i < self.subviews.count; ++i) {
        UIView *view = self.subviews[i];
        
        css_node_t *node = &(*nodes)[i];
        init_css_node(node);
        node->is_dirty = &isNodeDirty;
        node->measure = &measure;
        node->context = (__bridge void *)view;
        
        css_style_t *style = &node->style;
        style->align_self = CSS_ALIGN_STRETCH; // TODO
        style->flex = 0; // TODO
    }
}

- (void)setSubviewFramesFromNodes:(const NodeList &)nodes {
    NSAssert(nodes.size() == self.subviews.count, @"Node list size doesn't match subview count.");

    for (NSUInteger i = 0; i < self.subviews.count; ++i) {
        UIView *subview = self.subviews[i];
        
        const css_node_t *subviewNode = &nodes[i];
        const css_layout_t *layout = &subviewNode->layout;
        const float *position = &layout->position[0];
        const float *dimensions = &layout->dimensions[0];
        
        subview.frame = CGRectMake(position[CSS_LEFT], position[CSS_TOP], dimensions[CSS_WIDTH], dimensions[CSS_HEIGHT]);
    }
}

+ (css_justify_t)parseJustifyContent:(NSString *)justifyContent {
    if ([justifyContent isEqualToString:@"flex-start"]) {
        return CSS_JUSTIFY_FLEX_START;
    } else if ([justifyContent isEqualToString:@"flex-end"]) {
        return CSS_JUSTIFY_FLEX_END;
    } else if ([justifyContent isEqualToString:@"center"]) {
        return CSS_JUSTIFY_CENTER;
    } else if ([justifyContent isEqualToString:@"space-between"]) {
        return CSS_JUSTIFY_SPACE_BETWEEN;
    } else if ([justifyContent isEqualToString:@"space-around"]) {
        return CSS_JUSTIFY_SPACE_AROUND;
    } else {
        return CSS_JUSTIFY_FLEX_START;
    }
}

+ (css_align_t)parseAlignItems:(NSString *)alignItems {
    if ([alignItems isEqualToString:@"flex-start"]) {
        return CSS_ALIGN_FLEX_START;
    } else if ([alignItems isEqualToString:@"flex-end"]) {
        return CSS_ALIGN_FLEX_END;
    } else if ([alignItems isEqualToString:@"center"]) {
        return CSS_ALIGN_CENTER;
    } else if ([alignItems isEqualToString:@"stretch"]) {
        return CSS_ALIGN_STRETCH;
    } else {
        return CSS_ALIGN_CENTER;
    }
}

@end
