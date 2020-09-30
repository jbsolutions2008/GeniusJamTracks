//
//  ForumsVC.m
//  GeniusJamTracks
//
//    24/04/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "ForumsVC.h"


@interface ForumsVC ()

@property(strong,nonatomic) IBOutlet WKWebView *webView;

@end


@implementation ForumsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _webView.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString:@"http://geniusjamtracks.com/forums/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}



#pragma mark -  webview navigation delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"navigation done");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"navigation failed");
}



@end
