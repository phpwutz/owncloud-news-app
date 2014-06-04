//
//  ItemListTableViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNItemListTableViewController.h"
#import "OCNServiceFactoryImpl.h"
#import "OCNNewsItem.h"


@implementation OCNItemListTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        newsArticleService = [[OCNServiceFactoryImpl getInstance]getNewsArticleService];
        [[[OCNServiceFactoryImpl getInstance] getDatabaseService] addObserver:self];
    }
    return self;
}

- (id)init {
    return [[OCNItemListTableViewController alloc] initWithNibName:@"ItemListTableView" bundle:nil];
}

- (id) initWithArticleViewController: (OCNArticleViewController*) controller{
    self = [self init];
    if(self){
        _articleViewController = controller;
    }
    return self;
}

- (void) databaseChanged{
    if(lastLoadedFeed != nil){
        [self loadArticlesForFeed: lastLoadedFeed];
    }
}

-(void) displayArticle: (OCNNewsItem*) article{
    [_articleViewController displayArticle:article];
}

- (void) loadArticlesForFeed: (OCNNewsFeed*) feed{
    //NSLog(@"loading feed with id %u ", [feed identity]);
    [_itemArrayController setContent: [newsArticleService getArticlesForFeed:feed]];
    lastLoadedFeed = feed;
//    if([[_itemArrayController arrangedObjects] count] > 0){
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
//        [tableView selectRowIndexes:indexSet byExtendingSelection:NO];
//        [self tableViewSelectionDidChange:nil];
//    }
}

@end
