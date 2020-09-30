//
//  CreateSongVC.m
//  GeniusJamTracks
//
//    11/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "CreateSongVC.h"
#import "Constant.h"

@interface CreateSongVC ()
//All Outlets
@property (nonatomic, strong) IBOutlet UIButton *btnDone;
@property (nonatomic, strong) IBOutlet UIButton *btnHire;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tableHeight;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrlView;

@property (nonatomic, strong) IBOutlet UILabel *lblSongForm;
@property (nonatomic, strong) IBOutlet UILabel *lblKey;
@property (nonatomic, strong) IBOutlet UILabel *lblTimeSign;

@property (nonatomic, strong) IBOutlet UIView *vwPlaceholderShadow;
@property (nonatomic, strong) IBOutlet UIView *vwShadow;

@property (nonatomic, strong) IBOutlet UIView *vwTitlePlaceShadow;
@property (nonatomic, strong) IBOutlet UIView *vwTitleShadow;

@property (nonatomic, strong) IBOutlet UIView *vwActive;
@property (nonatomic, strong) IBOutlet UIView *vwTrioActive;

@property (nonatomic, strong) IBOutlet UIButton *btnIncrease;
@property (nonatomic, strong) IBOutlet UIButton *btnDecrease;
@property (nonatomic, strong) IBOutlet UIButton *btnTrioIncrease;
@property (nonatomic, strong) IBOutlet UIButton *btnTrioDecrease;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *activeTop;

@end

// Variables
NSMutableArray *arrName;
NSMutableArray *arrDesc;


@implementation CreateSongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialize array with demo values
    arrName = [[NSMutableArray alloc]initWithObjects:@"Modern Jazz trio", nil];
    arrDesc = [[NSMutableArray alloc]initWithObjects:@"Piano centric trio is one of my favorite jazz settings a more modern sound always strikes a chord", nil];
   // [_vwActive setBackgroundColor:[[Constant createColorWithCode:93 green:92 blue:92] colorWithAlphaComponent:0.04]];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setNeedsStatusBarAppearanceUpdate];

}

- (void)viewDidLayoutSubviews {
    
   // [Constant addGradient:_btnDone];
  //  [Constant addGradient:_btnHire];
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwPlaceholderShadow withRadius:5.0];
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwShadow withRadius:5.0];
    [Constant addInnerShadow:_vwPlaceholderShadow blackShadow:_vwShadow];
    [Constant addInnerShadow:_vwTitlePlaceShadow blackShadow:_vwTitleShadow];
   // [Constant setBorderWithColor:[Constant createColorWithCode:151 green:151 blue:151] width:1.0 toView:_vwActive withRadius:0.0];
    
    _vwActive.layer.masksToBounds = true;
    _vwActive.layer.cornerRadius = 5.0;
    _vwActive.layer.borderColor = [Constant createColorWithCode:151 green:151 blue:151].CGColor;
    _vwActive.layer.borderWidth = 1.0;
    _vwActive.layer.opacity = 0.04;
    
    _vwTrioActive.layer.masksToBounds = true;
    _vwTrioActive.layer.cornerRadius = 5.0;
    _vwTrioActive.layer.borderColor = [Constant createColorWithCode:151 green:151 blue:151].CGColor;
    _vwTrioActive.layer.borderWidth = 1.0;
    _vwTrioActive.layer.opacity = 0.04;
    
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

//#pragma mark - UITableView Methods
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 11;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    CraeteSongTableCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.lblTrioName.text = arrName[0];
//    cell.lblDesc.text = arrDesc[0];
//    [Constant addGradient:cell.vwShadow];
//    cell.vwShadow.layer.cornerRadius = 5.0;
//    cell.vwShadow.layer.masksToBounds = YES;
//    [cell layoutIfNeeded];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//     return cell;
//}



- (IBAction)changeActiveArea:(UIButton *)sender {
    
    [self hideInactiveArea:YES];
    _activeTop.constant = sender.frame.origin.y;
    [self.vwShadow layoutIfNeeded];
    if (sender.tag == 0) {
        NSLog(@"Song Form");
    } else if (sender.tag == 1) {
        NSLog(@"Time Signature");
    } else if (sender.tag == 2) {
        NSLog(@"Key");
    }

}

- (IBAction)btnHireTrioPressed:(UIButton *)sender {
    [self hideInactiveArea:NO];
}

- (void)hideInactiveArea:(BOOL)isSongSettings {
    
    [_vwActive setHidden:!isSongSettings];
    [_btnIncrease setHidden:!isSongSettings];
    [_btnDecrease setHidden:!isSongSettings];
    
    [_vwTrioActive setHidden:isSongSettings];
    [_btnTrioDecrease setHidden:isSongSettings];
    [_btnTrioIncrease setHidden:isSongSettings];
}

#pragma mark - UIButton Actions
- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnIncreaseClicked:(id)sender {
    NSLog(@"Increase Clicked");
}

- (IBAction)btnDecreaseClicked:(id)sender {
    NSLog(@"Decrease Clicked");
}



@end
