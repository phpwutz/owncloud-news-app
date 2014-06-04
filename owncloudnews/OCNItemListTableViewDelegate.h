//
//  OCNItemListTableViewDelegate.h
//  owncloudnews
//
//  Created by Lukas Köll on 04.06.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCNItemListTableViewController.h"

@interface OCNItemListTableViewDelegate : NSObject <NSTableViewDelegate>
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSArrayController *itemArrayController;
@property (unsafe_unretained) IBOutlet OCNItemListTableViewController *itemListTableViewController;

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification;
- (NSView *)tableView:(NSTableView *)aTableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

@end
