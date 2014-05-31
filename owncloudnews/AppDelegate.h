//
//  AppDelegate.h
//  owncloudnews
//
//  Created by Lukas Köll on 26.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "NewsAPI12.h"
#import "fmdb/FMDatabase.h"
#import "FeedOutlineViewController.h"
#import "PreferencesWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) FeedOutlineViewController* feedOutlineViewController;
@property (strong) PreferencesWindowController* preferencesWindowController;

@property IBOutlet NSView *splitView;

@property (assign) IBOutlet NSWindow *window;

- (IBAction) showPreferences:(id)sender;
//- (IBAction)reloadFeeds:(id) sender;
//- (IBAction)increaseFontSize:(NSMenuItem *)sender;
//- (IBAction)decreaseFontSize:(NSMenuItem *)sender;

@end
