//
//  OCNFeedOutlineViewDelegate.h
//  owncloudnews
//
//  Created by Lukas Köll on 04.06.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCNFeedOutlineViewController.h"

@interface OCNFeedOutlineViewDelegate : NSObject <NSOutlineViewDelegate>
@property (weak) IBOutlet NSTreeController *treeController;
@property (weak) IBOutlet OCNFeedOutlineViewController *outlineViewController;

//- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item;
- (void)outlineViewSelectionDidChange:(NSNotification *) aNotification;

@end
