//
//  AppDelegate.m
//  owncloudnews
//
//  Created by Lukas Köll on 26.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNAppDelegate.h"
#import "OCNNewsItem.h"
#import "OCNNewsFeed.h"
#import "OCNNewsAPI12.h"
#import "OCNServiceFactoryImpl.h"
#import "OCNArticleViewController.h"
#import "OCNItemListTableViewController.h"
#import "OCNFeedOutlineViewController.h"


@implementation OCNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //[self resetUserDefaults];
    _preferencesWindowController = [[OCNPreferencesWindowController alloc] init];
    
    if(![[[OCNServiceFactoryImpl getInstance ]getOwncloudSyncService] syncDatabaseWithApi] == YES){
        [self showPreferences:self];
    }
    
    OCNArticleViewController* articleViewController = [[OCNArticleViewController alloc] init];
    OCNItemListTableViewController* itemlistTableViewController = [[OCNItemListTableViewController alloc] initWithArticleViewController: articleViewController];
    
    self.feedOutlineViewController = [[OCNFeedOutlineViewController alloc] initWithItemListTableViewController: itemlistTableViewController];
    
    [_splitView addSubview: [self.feedOutlineViewController view]];
    [_splitView addSubview:[itemlistTableViewController view]];
    [_splitView addSubview:[articleViewController view]];
    
//
//	self.api = [[NewsAPI12 alloc] initWithProtocol:protocol andDomain:domain andUsername:username andPassword:password];
//	
//	[self setupDatabase];
//    
//    // no conf for domain? show the preference window!
//    if(domain == nil){
//        [[self preferenceWindow] setIsVisible:true];
//    }else{
//        	[self updateFeeds];
//    }
}
- (IBAction) showPreferences:(id)sender{
    [_preferencesWindowController showPreferences];
}

- (IBAction)reloadFeeds:(id) sender{
    [[[OCNServiceFactoryImpl getInstance ]getOwncloudSyncService] syncDatabaseWithApi];
}

- (void) resetUserDefaults{
    NSUserDefaultsController* userDefaults = [NSUserDefaultsController sharedUserDefaultsController];
    [[userDefaults defaults] setValue:@"" forKey:@"owncloudProtocol"];
    [[userDefaults defaults] setValue:@"" forKey:@"owncloudBaseUrl"];
    [[userDefaults defaults] setValue:@"" forKey:@"owncloudUsername"];
    [[userDefaults defaults] setValue:@"" forKey:@"owncloudPassword"];
    [[userDefaults defaults] setValue: [NSNumber numberWithInteger: 0] forKey:@"lastUpdateSync"];
    
}
@end
