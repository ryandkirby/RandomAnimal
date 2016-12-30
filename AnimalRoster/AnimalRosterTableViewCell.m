//
//  AnimalRosterTableViewCell.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/3/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "AnimalRosterTableViewCell.h"

@implementation AnimalRosterTableViewCell

@synthesize animalImageImage, animalName;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
