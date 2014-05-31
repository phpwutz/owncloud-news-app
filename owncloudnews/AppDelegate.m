//
//  AppDelegate.m
//  owncloudnews
//
//  Created by Lukas Köll on 26.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsItem.h"
#import "NewsFeed.h"
#import "NewsAPI12.h"
#import "ArticleViewController.h"
#import "ItemListTableViewController.h"
#import "FeedOutlineViewController.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
 
    ArticleViewController* articleViewController = [[ArticleViewController alloc] init];
    ItemListTableViewController* itemlistTableViewController = [[ItemListTableViewController alloc] initWithArticleViewController: articleViewController];
    
    self.feedOutlineViewController = [[FeedOutlineViewController alloc] initWithItemListTableViewController: itemlistTableViewController];
    
    
    [_splitView addSubview: [self.feedOutlineViewController view]];
    [_splitView addSubview:[itemlistTableViewController view]];
    [_splitView addSubview:[articleViewController view]];
    



    _preferencesWindowController = [[PreferencesWindowController alloc] init];
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
@end
