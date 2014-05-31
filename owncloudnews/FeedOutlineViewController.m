//
//  FeedOutlineViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "FeedOutlineViewController.h"
#import "ImageAndTextCell.h"
#import "fmdb/FMDatabase.h"
#import "NewsFeed.h"
#import "Folder.h"
#import "ServiceFactoryImpl.h"

@implementation FeedOutlineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        newsFeedService = [[ServiceFactoryImpl getInstance] getNewsFeedService];
    }
    return self;
}

- (id)init {
    return [[FeedOutlineViewController alloc] initWithNibName:@"FeedOutlineView" bundle:nil];
}

- (id) initWithItemListTableViewController: (ItemListTableViewController*) aItemListTableViewController{
    self = [self init];
    if(self){
        _itemListTableViewController = aItemListTableViewController;
    }
    return self;
}

- (void) awakeFromNib{
    [_feedsOutline setDataSource: _treeController];
}

- (void)didLoadView {
    NSLog(@"loaded outlineview");
    [self initTreeController];
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
        NewsFeed* feed = selectedObjects[0];
        [_itemListTableViewController loadArticlesForFeed: feed];
    }

}

- (void) initTreeController{
    
    NSArray* data = [newsFeedService getAllFeeds];
    for (int i = 0; i < [data count]; i++) {
        [self.treeController addObject: [data objectAtIndex: i]];
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
