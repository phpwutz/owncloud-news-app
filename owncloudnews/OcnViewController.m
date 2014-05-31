//
//  OcnViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OcnViewController.h"

@implementation OcnViewController

- (void)loadView {
    [super loadView];
    [self updateResponderChain];
    [self didLoadView];
}

- (void)didLoadView {
    // override
}

- (id)windowController {
    return [[[self view] window] windowController];
}

#pragma mark Responder Chain
- (NSResponder *)reconmendedFirstResponder {
    return nil; // override
}

- (void)updateResponderChain {
    if(self.view && [self.view nextResponder] != self) {
        NSResponder *nextResponder = [[self view] nextResponder];
        [[self view] setNextResponder:self];
        [self setNextResponder:nextResponder];
    }
}

@end
