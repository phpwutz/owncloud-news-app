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


@interface ItemListTableViewController : OcnViewController <NSTableViewDelegate>{
    NewsArticleServiceImpl *newsArticleService;
    IBOutlet NSTableView *tableView;
}

@property IBOutlet NSArrayController *itemArrayController;
@property (strong) ArticleViewController *articleViewController;

- (id) initWithArticleViewController: (ArticleViewController*) controller;

- (void) loadArticlesForFeed: (NewsFeed*) feed;

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification;
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

@end
