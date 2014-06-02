//
//  OutlineNode.m
//  owncloudnews
//
//  Created by Lukas Köll on 04.02.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNOutlineNode.h"

@implementation OCNOutlineNode

-(NSArray *)children {
    return nil;
}

-(BOOL)isLeaf {
    return [[self children] count] < 1;
}
- (NSInteger) unreadCount{
    return 0;
}
-(NSImage *)image {
    return nil;
}

@end
