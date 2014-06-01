//
//  ItemListTableViewController.h
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OcnViewController.h"
#import "NewsArticleServiceImpl.h"
#import "ArticleViewController.h"
#import "DatabaseObserver.h"


@interface ItemListTableViewController : OcnViewController <NSTableViewDelegate, DatabaseObserver>{
    NewsArticleServiceImpl *newsArticleService;
    IBOutlet NSTableView *tableView;
    NewsFeed* lastLoadedFeed;
}

@property IBOutlet NSArrayController *itemArrayController;
@property (strong) ArticleViewController *articleViewController;

- (id) initWithArticleViewController: (ArticleViewController*) controller;
@property (weak) IBOutlet NSTextFieldCell *titleCell;

- (void) loadArticlesForFeed: (NewsFeed*) feed;

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification;
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
- (NSView *)tableView:(NSTableView *)aTableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

- (void) databaseChanged;
@end
