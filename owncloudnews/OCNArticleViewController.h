//
//  ArticleViewController.h
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OcnViewController.h"
#import <WebKit/WebKit.h>
#import "OCNNewsItem.h"

@interface OCNArticleViewController : OcnViewController

@property IBOutlet WebView *webView;

-(void) displayArticle: (OCNNewsItem*) article;

@end
