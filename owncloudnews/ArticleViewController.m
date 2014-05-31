//
//  ArticleViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "ArticleViewController.h"

@implementation ArticleViewController

- (id)init {
    return [[ArticleViewController alloc] initWithNibName:@"ArticleView" bundle:nil];
}

- (void)didLoadView {
    NSLog(@"loaded webview");
    NSString *stringToLoad = @"<h1>lololol</h1>";
    [[_webView mainFrame] loadHTMLString: stringToLoad baseURL: nil];
}

-(void) displayArticle: (NewsItem*) article{
    NSError* err;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArticleTemplate" ofType:@"html"];
    NSString *contents = [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error:&err];
    
    NSString* templatedArticle = [[[
                                    contents stringByReplacingOccurrencesOfString:@"%content%" withString:article.body] stringByReplacingOccurrencesOfString:@"%title%" withString: article.title] stringByReplacingOccurrencesOfString:@"%article_link%" withString:article.url];
    article.unread = NO;
    [[[self webView] mainFrame] loadHTMLString:templatedArticle baseURL:nil];
}
@end