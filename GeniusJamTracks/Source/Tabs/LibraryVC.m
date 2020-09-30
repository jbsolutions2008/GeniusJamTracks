//
//  LibraryVC.m
//  GeniusJamTracks
//
//   24/04/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "LibraryVC.h"
#import "LibraryTableCell.h"
#import "TitleHeaderView.h"
#import "Constant.h"
#import "SongChordsVC.h"

@interface LibraryVC  ()

//All Outlets
@property (nonatomic, strong) IBOutlet UIButton *btnMySongs;
@property (nonatomic, strong) IBOutlet UIButton *btnLibrary;

@property (nonatomic, strong) IBOutlet UIView *vwBorder;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UITextField *txtSearch;

@end

// Variables
NSMutableArray *arrSongs;
NSMutableArray *arrSections;
NSMutableArray *arrMySongSections;
NSMutableArray *arrMySongs;
NSUserDefaults *userDefaults;


@implementation LibraryVC

#pragma mark -  View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //Initializing arrays
    arrMySongSections = [[NSMutableArray alloc]init];
    arrMySongs = [[NSMutableArray alloc]init];
    arrSongs = [[NSMutableArray alloc]init];
    arrSections = [[NSMutableArray alloc]init];
    userDefaults = [NSUserDefaults standardUserDefaults];
  
    //[self getMySongs];
    //[self getLibrarySongs];
    
    [self checkSongsInCache];
    [_btnLibrary setSelected:YES];
    [_btnLibrary setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnMySongs setTitleColor:[UIColor colorWithRed:235.0/255.0 green:135.0/255.0 blue:15.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TitleHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerView"];
    _txtSearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1.0]}];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 20)];
    
    UIImageView* imgSearch = [[UIImageView alloc]initWithFrame:CGRectMake(12, 0, 20, 20)];
    imgSearch.image = [UIImage imageNamed:@"search"];
    imgSearch.contentMode = UIViewContentModeScaleAspectFill;
    imgSearch.tintColor = [UIColor colorWithRed:48.0/255.0 green:53.0/255.0 blue:54.0/255.0 alpha:1.0];
    [leftView addSubview:imgSearch];
    _txtSearch.leftView = leftView;
    _txtSearch.leftViewMode = UITextFieldViewModeAlways;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLayoutSubviews {
    
    //implement corner radius and border color
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_btnMySongs withRadius:5.0];
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_btnLibrary withRadius:5.0];
    [Constant setBorderWithColor:Primary_Color width:0.5 toView:_vwBorder withRadius:5.0];
    [Constant setBorderWithColor:[Constant createColorWithCode:48 green:53 blue:54] width:0.5 toView:_txtSearch withRadius:5.0];
    
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




#pragma mark - UIButton Actions
- (IBAction)btnAddSongClicked:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"CreateSongVC"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btnChangeSongListClicked:(UIButton*)sender {
    // changing appearance of UIButton according to selection
    
    if (!sender.isSelected) {
        if (sender == _btnLibrary) {
            [_btnLibrary setSelected:YES];
            [_btnMySongs setSelected:NO];
            _btnLibrary.backgroundColor = Primary_Color;
            [_btnLibrary setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_btnMySongs setTitleColor:Primary_Color forState:UIControlStateNormal];
            _btnMySongs.backgroundColor = [UIColor clearColor];
        } else {
            
            [_btnMySongs setSelected:YES];
            [_btnLibrary setSelected:NO];
            _btnMySongs.backgroundColor = Primary_Color;
            [_btnMySongs setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_btnLibrary setTitleColor:Primary_Color forState:UIControlStateNormal];
            _btnLibrary.backgroundColor = [UIColor clearColor];
        }
        
        [_tableView reloadData];
        [_tableView setContentOffset:CGPointZero animated:YES];
    }
}

#pragma mark - UITableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_btnLibrary.isSelected) {
       return [arrSongs[section] count];
    }
    return [arrMySongs[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      LibraryTableCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (_btnLibrary.isSelected) {
        NSDictionary* dict = arrSongs[indexPath.section][indexPath.row];
        cell.lblName.text = [[dict.allKeys[0] stringByReplacingOccurrencesOfString:@"_" withString:@" "] stringByDeletingPathExtension];
    } else {
        NSDictionary* dict = arrMySongs[indexPath.section][indexPath.row];
        cell.lblName.text = [[dict.allKeys[0] stringByReplacingOccurrencesOfString:@"_" withString:@" "] stringByDeletingPathExtension];
    }
     return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_btnLibrary.isSelected) {
        return  arrSections.count;
    } else {
        return arrMySongSections.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TitleHeaderView* header = (TitleHeaderView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    header.contentView.backgroundColor = MainBg_Color;
    if (_btnLibrary.isSelected) {
        header.lblName.text = arrSections[section];
    } else {
        header.lblName.text = arrMySongSections[section];
    }
    
    return header;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewRowAction *modifyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
         [self openEditOptions:indexPath];
     }];
     modifyAction.backgroundColor = Primary_Color;
     return @[modifyAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SongChordsVC* controller = [storyboard instantiateViewControllerWithIdentifier:@"SongChordsVC"];
    if (_btnLibrary.isSelected) {
        controller.dictSelectedSong = arrSongs[indexPath.section][indexPath.row];
    } else {
        controller.dictSelectedSong = arrMySongs[indexPath.section][indexPath.row];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Other Methods

- (void)getMySongs {
    NSDictionary *dict = [self JSONFromFile:@"MySongs"];
    
    NSArray *sortedKeys = [dict.allKeys sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
    // As we using same keys from dictionary, we can put any non-nil value for the notFoundMarker, because it will never used
    NSMutableArray *sortedValues = [[NSMutableArray alloc]initWithArray:[dict objectsForKeys:sortedKeys notFoundMarker:@""]];
    
    for (char a = 'A'; a <= 'Z'; a++) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@",[NSString stringWithFormat:@"%c", a]];
        NSArray* arr = [sortedKeys filteredArrayUsingPredicate:predicate];
        
        if (arr.count > 0) {
            NSMutableArray* arrAlphaSong = [[NSMutableArray alloc]init];
            [arrMySongSections addObject:[NSString stringWithFormat:@"%c", a]];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary* dict1 = [NSDictionary dictionaryWithObject:sortedValues[i] forKey:arr[i]];
                [arrAlphaSong addObject:dict1];
            }
            [arrMySongs addObject:arrAlphaSong];
        }
        [sortedValues removeObjectsInRange:NSMakeRange(0, arr.count)];
    }
    [self setSongsInCache];
}

- (void)getLibrarySongs {
   NSDictionary *dict = [self JSONFromFile:@"Library"];
    
    NSArray *sortedKeys = [dict.allKeys sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
    // As we using same keys from dictionary, we can put any non-nil value for the notFoundMarker, because it will never used
    NSMutableArray *sortedValues = [[NSMutableArray alloc]initWithArray:[dict objectsForKeys:sortedKeys notFoundMarker:@""]];
    
    for (char a = 'A'; a <= 'Z'; a++) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@",[NSString stringWithFormat:@"%c", a]];
        NSArray* arr = [sortedKeys filteredArrayUsingPredicate:predicate];
        
        if (arr.count > 0) {
            NSMutableArray* arrAlphaSong = [[NSMutableArray alloc]init];
            [arrSections addObject:[NSString stringWithFormat:@"%c", a]];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary* dict1 = [NSDictionary dictionaryWithObject:sortedValues[i] forKey:arr[i]];
                [arrAlphaSong addObject:dict1];
            }
            [arrSongs addObject:arrAlphaSong];
        }
        [sortedValues removeObjectsInRange:NSMakeRange(0, arr.count)];
    }
    [_tableView reloadData];
    [self setSongsInCache];
}


//- (void)doSomethingWithTheJson {
//    NSDictionary *dict = [self JSONFromFile];
//
//
//
//    NSArray *colours = [dict objectForKey:@"colors"];
//
//    for (NSDictionary *colour in colours) {
//        NSString *name = [colour objectForKey:@"name"];
//        NSLog(@"Colour name: %@", name);
//
//        if ([name isEqualToString:@"green"]) {
//            NSArray *pictures = [colour objectForKey:@"pictures"];
//            for (NSDictionary *picture in pictures) {
//                NSString *pictureName = [picture objectForKey:@"name"];
//                NSLog(@"Picture name: %@", pictureName);
//            }
//        }
//    }
//}


- (NSDictionary *)JSONFromFile:(NSString*)strFileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:strFileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)openEditOptions:(NSIndexPath*)indexPath {
UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{}];
    }]];

[actionSheet addAction:[UIAlertAction actionWithTitle:@"Rename" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    // OK button tapped.
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    [self presentRenameAlert:indexPath];
}]];

    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

        if (self->_btnLibrary.isSelected) {
            [arrSongs[indexPath.section] removeObjectAtIndex:indexPath.row];
            if ([arrSongs[indexPath.section]count] == 0) {
                [arrSongs removeObjectAtIndex:indexPath.section];
                [arrSections removeObjectAtIndex:indexPath.section];
            }
        } else {
            [arrMySongs[indexPath.section] removeObjectAtIndex:indexPath.row];
            if ([arrMySongs[indexPath.section]count] == 0) {
                [arrMySongs removeObjectAtIndex:indexPath.section];
                [arrMySongSections removeObjectAtIndex:indexPath.section];
            }
        }
        [self setSongsInCache];
        // Distructive button tapped.
        [self dismissViewControllerAnimated:YES completion:^{}];
        [self.tableView reloadData];
    }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)presentRenameAlert:(NSIndexPath*)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Rename Song" message:@"Enter track title" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter new track title";
        textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self sortAfterRename:indexPath withName:[[alertController textFields][0] text]];

    }];
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)sortAfterRename:(NSIndexPath*)index withName:(NSString*)name {
    if (_btnLibrary.isSelected) {
        NSDictionary* dict = arrSongs[index.section][index.row];
        NSString* strName = [[name stringByReplacingOccurrencesOfString:@"" withString:@"_"] stringByAppendingPathExtension:@"mxl"];
        NSDictionary *dict1 = [NSDictionary dictionaryWithObject:dict.allValues[0] forKey:strName];
        //  arrSongs[index.section][index.row] = dict1;
        
        NSString *firstLetter = [strName substringToIndex:1];
        
        [arrSongs[index.section] removeObjectAtIndex:index.row];
        if ([arrSongs[index.section]count] == 0) {
            [arrSongs removeObjectAtIndex:index.section];
            [arrSections removeObjectAtIndex:index.section];
        }
        if ([arrSections containsObject:[firstLetter uppercaseString]]) {
            NSMutableArray* arrSectionSong = arrSongs[[arrSections indexOfObject:[firstLetter uppercaseString]]];
            [arrSectionSong addObject:dict1];
            arrSongs[[arrSections indexOfObject:[firstLetter uppercaseString]]] = arrSectionSong;
        } else {
            [arrSections addObject:[firstLetter uppercaseString]];
            NSArray* arr =  [arrSections sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
            arrSections = [[NSMutableArray alloc]initWithArray:arr];
            
            NSMutableArray* arrAlphaSongs = [[NSMutableArray alloc] init];
            [arrAlphaSongs addObject:dict1];
            
            [arrSongs insertObject:arrAlphaSongs atIndex:[arrSections indexOfObject:[firstLetter uppercaseString]]];
            
        }
    } else {
        NSDictionary* dict = arrMySongs[index.section][index.row];
        NSString* strName = [[name stringByReplacingOccurrencesOfString:@"" withString:@"_"] stringByAppendingPathExtension:@"mxl"];
        NSDictionary *dict1 = [NSDictionary dictionaryWithObject:dict.allValues[0] forKey:strName];
        //  arrSongs[index.section][index.row] = dict1;
        
        NSString *firstLetter = [strName substringToIndex:1];
        
        [arrMySongs[index.section] removeObjectAtIndex:index.row];
        if ([arrMySongs[index.section]count] == 0) {
            [arrMySongs removeObjectAtIndex:index.section];
            [arrMySongSections removeObjectAtIndex:index.section];
        }
        if ([arrMySongSections containsObject:[firstLetter uppercaseString]]) {
            NSMutableArray* arrSectionSong = arrMySongs[[arrMySongSections indexOfObject:[firstLetter uppercaseString]]];
            [arrSectionSong addObject:dict1];
            arrMySongs[[arrMySongSections indexOfObject:[firstLetter uppercaseString]]] = arrSectionSong;
        } else {
            [arrMySongSections addObject:[firstLetter uppercaseString]];
            NSArray* arr =  [arrMySongSections sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
            arrMySongSections = [[NSMutableArray alloc]initWithArray:arr];
            
            NSMutableArray* arrAlphaSongs = [[NSMutableArray alloc] init];
            [arrAlphaSongs addObject:dict1];
            NSLog(@"%lu", (unsigned long)[arrMySongSections indexOfObject:[firstLetter uppercaseString]]);
            [arrMySongs insertObject:arrAlphaSongs atIndex:[arrMySongSections indexOfObject:[firstLetter uppercaseString]]];
        }
    }
    [self setSongsInCache];
    [_tableView reloadData];
}


- (void)checkSongsInCache {
    
    if ([userDefaults objectForKey:@"librarySongs"] == nil) {
        [self getMySongs];
        [self getLibrarySongs];
    } else {
        [self getSongsFromCache];
    }
}

- (void) setSongsInCache {
    [userDefaults setObject:arrMySongs forKey:@"mySongs"];
    [userDefaults setObject:arrSongs forKey:@"librarySongs"];
    [userDefaults setObject:arrSections forKey:@"sections"];
    [userDefaults setObject:arrMySongSections forKey:@"mySections"];
    [userDefaults synchronize];
}

- (void)getSongsFromCache {
    arrMySongs = [[NSMutableArray alloc] initWithArray:[userDefaults mutableArrayValueForKey:@"mySongs"]];
   
    for (int i = 0 ; i < arrMySongs.count; i++) {
        arrMySongs[i] = [[NSMutableArray alloc]initWithArray:arrMySongs[i]];
    }
    arrSongs = [[NSMutableArray alloc] initWithArray:[userDefaults mutableArrayValueForKey:@"librarySongs"]];
    for (int i = 0 ; i < arrSongs.count; i++) {
        arrSongs[i] = [[NSMutableArray alloc]initWithArray:arrSongs[i]];
    }
    arrSections = [[NSMutableArray alloc] initWithArray:[userDefaults mutableArrayValueForKey:@"sections"]];
    arrMySongSections = [[NSMutableArray alloc] initWithArray:[userDefaults mutableArrayValueForKey:@"mySections"]];
}


@end
