//
//  OutlineNode.h
//  owncloudnews
//
//  Created by Lukas Köll on 04.02.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCNOutlineNode : NSObject

-(NSArray *)children;
-(BOOL)isLeaf;
- (NSInteger) unreadCount;
-(NSImage *)image;
@end
