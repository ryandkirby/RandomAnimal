//
//  OffsetLabel.m
//  Book Awards
//
//  Created by Ryan Kirby on 3/28/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OffsetLabel.h"

@implementation OffsetLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

-(void)setRightOffset:(CGFloat) rightOffset
{
    self.edgeInsets = UIEdgeInsetsMake(0, rightOffset, 0, 0);
}

-(void)setTopOffset:(CGFloat) topOffset
{
    self.edgeInsets = UIEdgeInsetsMake(topOffset, 0, 0, 0);
}

-(void)setBottomOffset:(CGFloat) bottomOffset
{
    self.edgeInsets = UIEdgeInsetsMake(0, 0, bottomOffset, 0);
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.width  += self.edgeInsets.left + self.edgeInsets.right;
    size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return size;
}

@end