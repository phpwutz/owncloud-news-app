//
//  DatabaseObserver.h
//  owncloudnews
//
//  Created by Lukas Köll on 01.06.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DatabaseObserver <NSObject>

- (void) databaseChanged;

@end
