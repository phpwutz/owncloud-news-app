//
//  PreferencesWindowController.h
//  owncloudnews
//
//  Created by Lukas Köll on 31.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralPreferencesViewController.h"

@interface PreferencesWindowController : NSWindowController <NSWindowDelegate>{
    GeneralPreferencesViewController* prefViewC;
}

- (id)init;
- (void) showPreferences;

@end
