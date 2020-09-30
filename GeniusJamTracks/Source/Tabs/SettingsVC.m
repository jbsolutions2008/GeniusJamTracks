//
//  SettingsVC.m
//  GeniusJamTracks
//
//    24/04/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "SettingsVC.h"
#import "TitleHeaderView.h"
#import "SettingsTableCell.h"

@interface SettingsVC ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *arrSection;

@end

// Variables
NSArray *arrSocial;
NSArray *arrWeb;

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arrSection = [NSArray arrayWithObjects: @"INSTRUMENT TRANSPOSE",@"SOCIAL",@"WEBSITE, HELP & GUIDES",@"RATE", nil];
    arrWeb = [NSArray arrayWithObjects: @"Official Website",@"App Guide",@"FAQ",@"Contact",@"Subscribe", nil];
    
    arrSocial = [NSArray arrayWithObjects: @"Facebook",@"Instagram",@"Youtube", nil];
    
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"TitleHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerView"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self setNeedsStatusBarAppearanceUpdate];
    [_tableView reloadData];
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - UITableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section)
    {
        case 0:  return 1;  // section 0 has 1 row
        case 1:  return 3;  // section 1 has 4 rows
        case 2:  return 5;  // section 1 has 4 rows
        case 3:  return 1;  // section 1 has 1 row
        default: return 0;
    };
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

       SettingsTableCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.lblTitle.text = @"Transpose";
        cell.lblValue.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"transpose"];
        [cell.lblValue setHidden:NO];
    } else if (indexPath.section == 1) {
        cell.lblTitle.text = arrSocial[indexPath.row];
        [cell.lblValue setHidden:YES];
    } else if (indexPath.section == 2) {
        cell.lblTitle.text = arrWeb[indexPath.row];
        [cell.lblValue setHidden:YES];
    } else {
        cell.lblTitle.text = @"Rate App in AppStore";
        [cell.lblValue setHidden:YES];
    }
     // cell.lblName.text = arrSongs[0];
     // cell.lblDesc.text = arrDesc[0];
     return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  _arrSection.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TitleHeaderView* header = (TitleHeaderView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    header.contentView.backgroundColor = [UIColor lightGrayColor];
    
    header.lblName.text = _arrSection[section];
    header.lblName.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20.0f];
    [header.lblLine setHidden:YES];
    return header;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    // Transpose Section
    if(indexPath.section==0){
        if(indexPath.row==0){
            UIViewController* controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"InstrumentTransposeVC"];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
    }
    
    //Social Section
    if(indexPath.section==1){
        
        if(indexPath.row==0){
            // open the Facebook App
            if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/1113101425447433"]]) {
                // opening the app didn't work - let's open Safari
                if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/geniusjamtracks"]]) {
                }
            }
        }
        if(indexPath.row==1){
            // open the Instagram App
            if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"instagram://user?username=geniusjamtracks"]]) {
                // opening the app didn't work - let's open Safari
                if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/geniusjamtracks/"]]) {
                }
            }
        }
        
        if(indexPath.row==2){
            // open the Youtube App
            if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"youtube://www.youtube.com/channel/UCNm5jGjG5X-GEWyosh3aDNw"]]) {
                // opening the app didn't work - let's open Safari
                if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/channel/UCNm5jGjG5X-GEWyosh3aDNw"]]) {
                }
            }
        }
        
    }
    
    //Website Section
    if(indexPath.section==2){
        if(indexPath.row==0){
            NSString *url = @"http://geniusjamtracks.com/";
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        }
        if(indexPath.row==1){
            NSString *url = @"http://geniusjamtracks.com/appguide/";
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        }
        if(indexPath.row==2){
            NSString *url = @"http://geniusjamtracks.com/faq/";
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        }
        if(indexPath.row==3){
            NSString *url = @"http://geniusjamtracks.com/contact/";
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        }
        if(indexPath.row==4){
            NSString *url = @"http://geniusjamtracks.com/subscribe";
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        }
    }
    
    //Rate Section
    if(indexPath.section==3){
        if(indexPath.row==0){
            // open the Youtube App
            if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/apple-store/id1131210331?mt=8"]]) {
                // opening the app didn't work - let's open Safari
                if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/apple-store/id1131210331?mt=8"]]) {
                }
            }
        }
    }
     [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
