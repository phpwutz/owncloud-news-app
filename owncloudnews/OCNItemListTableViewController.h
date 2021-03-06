//
//  ItemListTableViewController.h
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OcnViewController.h"
#import "OCNNewsArticleServiceImpl.h"
#import "OCNArticleViewController.h"
#import "DatabaseObserver.h"


@interface OCNItemListTableViewController : OcnViewController <NSTableViewDelegate, OCNDatabaseObserver>{
    OCNNewsArticleServiceImpl *newsArticleService;
    IBOutlet NSTableView *tableView;
    OCNNewsFeed* lastLoadedFeed;
}

@property IBOutlet NSArrayController *itemArrayController;
@property (strong) OCNArticleViewController *articleViewController;

- (id) initWithArticleViewController: (OCNArticleViewController*) controller;
@property (weak) IBOutlet NSTextFieldCell *titleCell;

- (void) loadArticlesForFeed: (OCNNewsFeed*) feed;
-(void) displayArticle: (OCNNewsItem*) article;

- (void) databaseChanged;
@end
