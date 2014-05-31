//
//  ItemListTableViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "ItemListTableViewController.h"
#import "ServiceFactoryImpl.h"
#import "NewsItem.h"


@implementation ItemListTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        newsArticleService = [[ServiceFactoryImpl getInstance]getNewsArticleService];
        
    }
    return self;
}

- (id)init {
    return [[ItemListTableViewController alloc] initWithNibName:@"ItemListTableView" bundle:nil];
}

- (id) initWithArticleViewController: (ArticleViewController*) controller{
    self = [self init];
    if(self){
        _articleViewController = controller;
    }
    return self;
}

- (void) loadArticlesForFeed: (NewsFeed*) feed{
    NSLog(@"loading feed with id %u ", [feed identity]);
    [_itemArrayController setContent: [newsArticleService getArticlesForFeed:feed]];
    
    if([[_itemArrayController arrangedObjects] count] > 0){
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        [self tableViewSelectionDidChange:nil];
    }
}

-(void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    //[cell setDrawsBackground:YES];
    NewsItem* selectedItem = [[[self itemArrayController] arrangedObjects] objectAtIndex:row];
    if(selectedItem.unread == YES){
        [cell setFont:[NSFont boldSystemFontOfSize:12]];
    }else{
        [cell setFont:[NSFont systemFontOfSize:12]];
    }
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification{
    NSLog(@"table view selection did change");
    NSInteger rowIndex = [tableView selectedRow];
    
    if(rowIndex == -1){
        return;
    }
    
    NewsItem* selectedItem = [[_itemArrayController arrangedObjects] objectAtIndex:rowIndex];
    
    [_articleViewController displayArticle: selectedItem];
}

@end
