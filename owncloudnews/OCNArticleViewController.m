//
//  ArticleViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNArticleViewController.h"
#import "DatabaseObserver.h"
#import "NSInvocation+Constructors.h"
#import "OCNServiceFactoryImpl.h"

@implementation OCNArticleViewController

- (id)init {
    return [[OCNArticleViewController alloc] initWithNibName:@"ArticleView" bundle:nil];
}

- (void)didLoadView {
    NSLog(@"loaded webview");
    NSString *stringToLoad = @"<h1>lololol</h1>";
    [[_webView mainFrame] loadHTMLString: stringToLoad baseURL: nil];
    
    [[self webView] setPolicyDelegate:self];
}

-(void) displayArticle: (OCNNewsItem*) article{
    NSError* err;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArticleTemplate" ofType:@"html"];
    NSString *contents = [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error:&err];
    
    NSString* templatedArticle = [[[
                                    contents stringByReplacingOccurrencesOfString:@"%content%" withString:article.body] stringByReplacingOccurrencesOfString:@"%title%" withString: article.title] stringByReplacingOccurrencesOfString:@"%article_link%" withString:article.url];
    //BOOL statusBefore = article.unread;
    //article.unread = NO;
    [[[self webView] mainFrame] loadHTMLString:templatedArticle baseURL:nil];
    
//    if(statusBefore != article.unread){
//        NSInvocation* inv = [NSInvocation
//                             invocationWithProtocol:@protocol(DatabaseObserver)
//                             selector:@selector(databaseChanged)];
//        [[[ServiceFactoryImpl getInstance]getDatabaseService] notifyObservers:inv];
//    }
}

- (void)webView:(WebView *)sender decidePolicyForNavigationAction:(NSDictionary *)actionInformation
        request:(NSURLRequest *)request
          frame:(WebFrame *)frame
decisionListener:(id <WebPolicyDecisionListener>)listener{
    if (WebNavigationTypeLinkClicked == [[actionInformation objectForKey:WebActionNavigationTypeKey] intValue]){
        NSString *scheme = [[request URL] scheme];
        if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]){
            [[NSWorkspace sharedWorkspace] openURL:[request URL]];
        }else {
            [listener use];
        }
    }else {
        [listener use];
    }
}
@end
