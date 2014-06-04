//
//  OCNFeedOutlineViewDelegate.m
//  owncloudnews
//
//  Created by Lukas Köll on 04.06.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNFeedOutlineViewDelegate.h"

@implementation OCNFeedOutlineViewDelegate

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
        [_outlineViewController loadArticlesForFeed: feed];
    }
    
}
//
//- (void)outlineView:(NSOutlineView *)outlineView
//    willDisplayCell:(id)cell
//     forTableColumn:(NSTableColumn *)tableColumn
//               item:(id)item {
//    // draw images for first column only
//    if ([@"feedTitle" compare:[[tableColumn headerCell] title]] == NSOrderedSame) {
//
//        NSImage *image = nil;
//        if ([item respondsToSelector:@selector(image)])
//            image = [item image];
//        else
//            if ([item isKindOfClass:[NSTreeNode class]])
//                image = [[item representedObject] image];
//
//        ImageAndTextCell *c = (ImageAndTextCell *)cell;
//        [c setImage:image];
//    }
//}

@end
