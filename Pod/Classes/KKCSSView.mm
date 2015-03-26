//
//  KKCSSView.m
//  KKCSSLayout
//
//  Created by Peter Mackay on 26/03/2015.
//  Copyright (c) 2014 Peter Mackay. All rights reserved.
//

#import "KKCSSView.h"

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

@implementation KKCSSView

#pragma mark UIView

- (CGSize)sizeThatFits:(CGSize)size {
    return self.bounds.size;
}

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
    style->flex_direction = self.rowFlexDirection ? CSS_FLEX_DIRECTION_ROW : CSS_FLEX_DIRECTION_COLUMN;
    style->justify_content = static_cast<css_justify_t>(self.justifyContent);
    style->align_items = static_cast<css_align_t>(self.alignItems);
    style->align_self = static_cast<css_align_t>(self.alignSelf);
    style->position_type = self.absolutePosition ? CSS_POSITION_ABSOLUTE : CSS_POSITION_RELATIVE;
    style->flex_wrap = self.flexWrap ? CSS_WRAP : CSS_NOWRAP;
    style->flex = self.flex;
    
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
        CGSize size = view.intrinsicContentSize;
        
        css_node_t *node = &(*nodes)[i];
        init_css_node(node);
        node->is_dirty = &isNodeDirty;
        node->style.dimensions[CSS_WIDTH] = size.width;
        node->style.dimensions[CSS_HEIGHT] = size.height;
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
        
        subview.frame = CGRectMake(position[0], position[1], dimensions[0], dimensions[1]);
    }
}

@end
