//
//  LaunchScreenVC.m
//  GeniusJamTracks
//
//  23/04/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "LaunchScreenVC.h"
#import "YIInnerShadowView.h"
#import "Constant.h"

@interface LaunchScreenVC ()

@property (nonatomic, strong) IBOutlet UIView *vwShadow;
@property (nonatomic, strong) IBOutlet UIView *vwPlaceShadow;

@end

@implementation LaunchScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    sleep(5);
    
  
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"AppTabbarController"];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)viewDidLayoutSubviews {
    
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
