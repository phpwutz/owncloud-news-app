//
//  OCNItemListTableViewDelegate.m
//  owncloudnews
//
//  Created by Lukas Köll on 04.06.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNItemListTableViewDelegate.h"
#import "OCNNewsItem.h"

@implementation OCNItemListTableViewDelegate
- (NSView *)tableView:(NSTableView *)aTableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    OCNNewsItem* drawnItem = [[[self itemArrayController] arrangedObjects] objectAtIndex:row];
    NSTableCellView *result = [aTableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    NSString* v1 = [[[result subviews] objectAtIndex:0] identifier];
    NSString* v2 = [[[result subviews] objectAtIndex:1] identifier];
    NSString* v3 = [[[result subviews] objectAtIndex:2] identifier];
    NSString* v4 = [[[result subviews] objectAtIndex:3] identifier];
    
    // first object is the headline
    if(drawnItem.unread == YES){
        [[[result subviews] objectAtIndex:0] setFont:[NSFont boldSystemFontOfSize:14]];
    }else{
        [[[result subviews] objectAtIndex:0] setFont:[NSFont systemFontOfSize:12]];
    }
    return result;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification{
    //NSLog(@"table view selection did change");
    NSInteger rowIndex = [_tableView selectedRow];
    
    if(rowIndex == -1){
        return;
    }
    
    OCNNewsItem* selectedItem = [[_itemArrayController arrangedObjects] objectAtIndex:rowIndex];
    [_itemListTableViewController displayArticle: selectedItem];
    if(selectedItem.unread == true){
        selectedItem.unread = false;
        [_tableView reloadData];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:rowIndex];
        [_tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    }
}
@end
