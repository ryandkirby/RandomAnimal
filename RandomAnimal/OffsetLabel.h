//
//  OffsetLabel.h
//  Book Awards
//
//  Created by Ryan Kirby on 3/28/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const BOOK_DETAIL_TEXT_OFFSET = 10;

@interface OffsetLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

-(void)setRightOffset:(CGFloat) rightOffset;
-(void)setTopOffset:(CGFloat) topOffset;
-(void)setBottomOffset:(CGFloat) bottomOffset;

@end