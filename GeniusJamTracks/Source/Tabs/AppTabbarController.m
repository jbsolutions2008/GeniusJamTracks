//
//  AppTabbarController.m
//  GeniusJamTracks
//
//  24/04/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "AppTabbarController.h"

@interface AppTabbarController ()

@end

@implementation AppTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor colorWithRed:235.0/255.0 green:135.0/255.0 blue:15.0/255.0 alpha:1.0];
    self.tabBar.unselectedItemTintColor = [UIColor whiteColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
    NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-Regular" size:12.0f]
    } forState:UIControlStateNormal];

    
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    
    // best call super just in case
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // will execute before rotatio
    [UIView setAnimationsEnabled:NO];
    
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
        // will execute during rotation
    } completion:^(id  _Nonnull context) {
        // will execute after rotation
        [UIView setAnimationsEnabled:YES];
    }];
}



@end
