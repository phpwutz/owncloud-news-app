//
//  OcnViewController.h
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OcnViewController : NSViewController
- (void)didLoadView;
- (NSResponder *)reconmendedFirstResponder;
/* Returns the associated window controller */
- (id)windowController;

- (void)updateResponderChain;
@end
