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

- (void) loadArticlesForFeed: (OCNNewsFeed*) feed{
    //NSLog(@"loading feed with id %u ", [feed identity]);
    [_itemArrayController setContent: [newsArticleService getArticlesForFeed:feed]];
    lastLoadedFeed = feed;
    if([[_itemArrayController arrangedObjects] count] > 0){
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        [self tableViewSelectionDidChange:nil];
    }
}

-(void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    // this isnt used currently because we use a view-cell
    /*
    //[cell setDrawsBackground:YES];
    NewsItem* selectedItem = [[[self itemArrayController] arrangedObjects] objectAtIndex:row];
    if(selectedItem.unread == YES){
        [cell setFont:[NSFont boldSystemFontOfSize:12]];
    }else{
        [cell setFont:[NSFont systemFontOfSize:12]];
    }
     */
}

- (NSView *)tableView:(NSTableView *)aTableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    OCNNewsItem* drawnItem = [[[self itemArrayController] arrangedObjects] objectAtIndex:row];
    NSTableCellView *result = [aTableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
//    NSString* v1 = [[[result subviews] objectAtIndex:0] identifier];
//    NSString* v2 = [[[result subviews] objectAtIndex:1] identifier];
//    NSString* v3 = [[[result subviews] objectAtIndex:2] identifier];
//    NSString* v4 = [[[result subviews] objectAtIndex:3] identifier];

    for (NSView *view in [result subviews]) {
        if ([view.identifier isEqualToString:@"_NS:39"]) { // 39 is the headline
            NSTextField* tmp = (NSTextField* ) view;
            if(drawnItem.unread == YES){
                [tmp setFont: [NSFont boldSystemFontOfSize:14]];
            }else{
                [tmp setFont: [NSFont systemFontOfSize: 12]];
            }
        }
    }
    return result;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification{
    //NSLog(@"table view selection did change");
    NSInteger rowIndex = [tableView selectedRow];
    
    if(rowIndex == -1){
        return;
    }
    
    OCNNewsItem* selectedItem = [[_itemArrayController arrangedObjects] objectAtIndex:rowIndex];
    [_articleViewController displayArticle: selectedItem];
    if(selectedItem.unread == true){
        selectedItem.unread = false;
        [tableView reloadData];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:rowIndex];
        [tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    }
}

@end
