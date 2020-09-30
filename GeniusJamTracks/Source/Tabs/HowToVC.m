//
//  HowToVC.m
//  GeniusJamTracks
//
//    24/04/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "HowToVC.h"

@interface HowToVC ()

@property (nonatomic, strong) IBOutlet UIButton *btnHowTo;
@property (nonatomic, strong) IBOutlet UIButton *btnAppGuide;

@property (nonatomic, strong) IBOutlet UIView *vwBorder;
@property(strong,nonatomic) IBOutlet WKWebView *webView;

@property NSString* strAppGuideLink;
@property NSString* strHowToLink;

@end


@implementation HowToVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView.navigationDelegate = self;
    _strAppGuideLink = @"http://geniusjamtracks.com/appguide/";
    _strHowToLink = @"http://geniusjamtracks.com/how-to/";
    
    [self changeUrlOnClick:_strAppGuideLink];
    [_btnAppGuide setSelected:YES];
    [_btnAppGuide setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnHowTo setTitleColor:[UIColor colorWithRed:235.0/255.0 green:135.0/255.0 blue:15.0/255.0 alpha:1.0] forState:UIControlStateNormal];
}

- (void)viewDidLayoutSubviews {
    _btnAppGuide.layer.masksToBounds = true;
    _btnAppGuide.layer.cornerRadius = 5.0;
    
    _btnHowTo.layer.masksToBounds = true;
    _btnHowTo.layer.cornerRadius = 5.0;
    
    _vwBorder.layer.masksToBounds = true;
    _vwBorder.layer.cornerRadius = 5.0;
    
    _vwBorder.layer.borderColor = [UIColor colorWithRed:235.0/255.0 green:135.0/255.0 blue:15.0/255.0 alpha:1.0].CGColor;
    _vwBorder.layer.borderWidth = 0.5;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleDefault;

}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - UIButton Actions

- (IBAction)btnChangeContentClicked:(UIButton*)sender {
    if (!sender.isSelected) {
        //hide webview when content is being changed
        [_webView setHidden:YES];
        
        //UIButtton appearance changes
        if (sender == _btnAppGuide) {
            [self changeUrlOnClick:_strAppGuideLink];
            
            [_btnAppGuide setSelected:YES];
            [_btnHowTo setSelected:NO];
            
            _btnAppGuide.backgroundColor = Primary_Color;
            [_btnAppGuide setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_btnHowTo setTitleColor:Primary_Color forState:UIControlStateNormal];
            _btnHowTo.backgroundColor = [UIColor clearColor];
       
        } else {
            
            [_btnAppGuide setSelected:NO];
            [_btnHowTo setSelected:YES];
            [self changeUrlOnClick:_strHowToLink];
            _btnHowTo.backgroundColor = Primary_Color;
            [_btnHowTo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_btnAppGuide setTitleColor:Primary_Color forState:UIControlStateNormal];
            _btnAppGuide.backgroundColor = [UIColor clearColor];
        }
    }
}


#pragma mark - Other Methods

//seprate method to load link according to selection
- (void)changeUrlOnClick:(NSString*)strLink {
   NSURL *url = [NSURL URLWithString:strLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark -  webview navigation delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"navigation done");
    
    //unhide webview when correct link is loaded
    if ([_webView.URL.absoluteString isEqualToString:_strAppGuideLink] && _btnAppGuide.isSelected) {
        [webView setHidden:NO];
    } else if ([_webView.URL.absoluteString isEqualToString:_strHowToLink] && _btnHowTo.isSelected) {
        [webView setHidden:NO];
    }
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"navigation failed");
}

@end
