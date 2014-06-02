//
//  FeedOutlineViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNFeedOutlineViewController.h"
#import "ImageAndTextCell.h"
#import "fmdb/FMDatabase.h"
#import "OCNNewsFeed.h"
#import "OCNFolder.h"
#import "OCNServiceFactoryImpl.h"

@implementation OCNFeedOutlineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        newsFeedService = [[OCNServiceFactoryImpl getInstance] getNewsFeedService];
        [[[OCNServiceFactoryImpl getInstance] getDatabaseService] addObserver:self];
    }
    return self;
}

- (id)init {
    return [[OCNFeedOutlineViewController alloc] initWithNibName:@"FeedOutlineView" bundle:nil];
}

- (id) initWithItemListTableViewController: (OCNItemListTableViewController*) aItemListTableViewController{
    self = [self init];
    if(self){
        _itemListTableViewController = aItemListTableViewController;
    }
    return self;
}

- (void) awakeFromNib{
    [_feedsOutline setDataSource: _treeController];
    [self databaseChanged];
}

- (void) databaseChanged{
    NSArray* data = [newsFeedService getAllFeeds];
    [self.treeController setContent:nil];
    for (int i = 0; i < [data count]; i++) {
        [self.treeController addObject: [data objectAtIndex: i]];
    }
}

- (void)didLoadView {
    
}


- (void) outlineViewSelectionDidChange: (NSNotification* )aNotification{
    NSArray* selectedObjects = [_treeController selectedObjects];
    
    if([selectedObjects count] == 0){
        return;
    }
    // if it is a folder: do nothing right now
    if([selectedObjects[0] respondsToSelector: @selector(feeds)]){

    }
    // if its a feed, load its articles
    if([selectedObjects[0] respondsToSelector: @selector(items)]){
        OCNNewsFeed* feed = selectedObjects[0];
        [_itemListTableViewController loadArticlesForFeed: feed];
    }

}

- (void)outlineView:(NSOutlineView *)outlineView
    willDisplayCell:(id)cell
     forTableColumn:(NSTableColumn *)tableColumn
               item:(id)item {
    // draw images for first column only
    if ([@"feedTitle" compare:[[tableColumn headerCell] title]] == NSOrderedSame) {
        
        NSImage *image = nil;
        if ([item respondsToSelector:@selector(image)])
            image = [item image];
        else
            if ([item isKindOfClass:[NSTreeNode class]])
                image = [[item representedObject] image];
        
        ImageAndTextCell *c = (ImageAndTextCell *)cell;
        [c setImage:image];
    }
}

@end