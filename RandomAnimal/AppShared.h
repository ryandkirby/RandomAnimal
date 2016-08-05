//
//  AppShared.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// App strings
static NSString* const APP_NAME_STR = @"Who's in Bed?";
static NSString* const ANIMAL_ROSTER_PAGE_NAME = @"Animal Roster";
static NSString* const BACK_BUTTON_TEXT = @"Back";
static NSString* const CANCEL_BUTTON_TEXT = @"Cancel";
static NSString* const GOT_IT_BUTTON_TEXT = @"Got it!";
static NSString* const NO_ANIMALS_BUTTON_TEXT = @"No Animals available to select.  Add some by using this button";
static NSString* const NO_ANIMALS_BUTTON_TEXT_IPHONE = @"No Animals available to select.  Add some by using the icon in the top-right.";
static NSString* const SAVE_BUTTON_TEXT = @"Save";
static NSString* const DELETE_BUTTON_TEXT = @"Delete";
static NSString* const ANIMAL_APP_FONT = @"MarkerFelt-Thin";
static NSString* const RANDOM_BUTTON_PAW_IMAGE_NAME = @"RandomButton.png";
static NSString* const APP_SETTINGS_GEAR = @"SettingsGear.png";
static NSString* const EDIT_BUTTON_TEXT = @"Edit";
static NSString* const IMAGE_SELECTION_PHOTO_GALLARY = @"Photo Library";
static NSString* const IMAGE_SELECTION_TAKE_PHOTO = @"Take Photo";
static NSString* const ADD_PHOTO_TEXT = @"Add Photo";
static NSString* const EDIT_PHOTO_TEXT = @"Edit Photo";

// Numeric constants
static NSInteger const ANIMAL_AVAILABLE = 1;
static NSInteger const ANIMAL_NOT_AVAILABLE = 0;
static NSInteger const SETTING_BUTTON_SIZE = 32;
static CFTimeInterval const EDIT_TRANSITION_TIME = 0.3;
static NSTimeInterval const SELECTION_ANIMATION_SPEED = 0.2;

@interface AppShared : NSObject

@end
