//
//  InstrumentTransposeVC.m
//  GeniusJamTracks
//
//  05/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "InstrumentTransposeVC.h"
#import "LibraryTableCell.h"

@interface InstrumentTransposeVC ()

@property (nonatomic, strong) IBOutlet UILabel *lblSelectedValue;
@property (nonatomic, strong) IBOutlet UIButton *btnC;
@property (nonatomic, strong) IBOutlet UIButton *btnBb;
@property (nonatomic, strong) IBOutlet UIButton *btnEb;
@property (nonatomic, strong) IBOutlet UIButton *btnF;

@property (nonatomic, strong) IBOutlet UIView *vwSelection;
@property (nonatomic, strong) IBOutlet UIView *vwContainer;
@property (nonatomic, strong) IBOutlet UITableView *tableView;


@end

NSArray *arrList;
NSUserDefaults *defaults;

@implementation InstrumentTransposeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    arrList = [NSArray arrayWithObjects: @"C (Default)", @"Bb", @"Eb", @"F", nil];
    defaults = [NSUserDefaults standardUserDefaults];
   // _lblSelectedValue.text = [defaults valueForKey:@"transpose"];
    [self setNeedsStatusBarAppearanceUpdate];
    _tableView.tintColor = [UIColor whiteColor];
    
    /*
    if ([[defaults valueForKey:@"transpose"] isEqualToString:arrList[0]]) {
        [_btnC setSelected:YES];
    } else if ([[defaults valueForKey:@"transpose"] isEqualToString:arrList[1]]) {
        [_btnBb setSelected:YES];
    }
    else if ([[defaults valueForKey:@"transpose"] isEqualToString:arrList[2]]) {
        [_btnEb setSelected:YES];
    } else {
        [_btnF setSelected:YES];
    }*/
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


- (IBAction)btnSelectionClicked:(UIButton*)sender {
    [_vwSelection setHidden:YES];
    [_vwContainer setHidden:YES];
        [defaults setValue:arrList[sender.tag] forKey:@"transpose"];
    _lblSelectedValue.text = [defaults valueForKey:@"transpose"];
    
    if (sender.tag == 0) {
        [_btnC setSelected:YES];
        [_btnF setSelected:NO];
        [_btnEb setSelected:NO];
        [_btnBb setSelected:NO];
    } else if (sender.tag == 1) {
        [_btnC setSelected:NO];
        [_btnF setSelected:NO];
        [_btnEb setSelected:NO];
        [_btnBb setSelected:YES];
    } else if (sender.tag == 2) {
        [_btnC setSelected:NO];
        [_btnF setSelected:NO];
        [_btnBb setSelected:NO];
        [_btnEb setSelected:YES];
    } else {
        [_btnC setSelected:NO];
        [_btnBb setSelected:NO];
        [_btnEb setSelected:NO];
        [_btnF setSelected:YES];
    }
}

- (IBAction)btnShowSelectionClicked:(UIButton*)sender {
    [_vwSelection setHidden:NO];
    [_vwContainer setHidden:NO];
}

- (IBAction)btnCancelClicked:(UIButton*)sender {
    [_vwSelection setHidden:YES];
    [_vwContainer setHidden:YES];
}

- (IBAction)btnBackClicked:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

      LibraryTableCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
      
      cell.lblName.text = arrList[indexPath.row];
    if ([arrList[indexPath.row] isEqualToString:[defaults valueForKey:@"transpose"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [defaults setValue:arrList[indexPath.row] forKey:@"transpose"];
    [tableView reloadData];
}

@end
