//
//  PreferencesWindowController.m
//  owncloudnews
//
//  Created by Lukas Köll on 31.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "PreferencesWindowController.h"
#import <AppKit/AppKit.h>
#import "ServiceFactoryImpl.h"

@implementation PreferencesWindowController

- (id)init {
    self = [super initWithWindowNibName: @"PreferencesWindow"];
    if(self){
        prefViewC = [[GeneralPreferencesViewController alloc] init];
        NSView* contentView = [[self window] contentView];
        NSView* prefView = [prefViewC view];
        [[[self window] contentView] addSubview: [prefViewC view]];
        
        NSDictionary *viewBindings = NSDictionaryOfVariableBindings(prefView);
        
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[prefView]-|" options:0 metrics:nil views:viewBindings]];
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[prefView]-|" options:0 metrics:nil views:viewBindings]];
    }
    return self;
}

- (void) windowWillClose: (NSNotification*)notification{
    //;
}


- (void) showPreferences{

    [[self window] makeKeyAndOrderFront:self];
    
}
@end
