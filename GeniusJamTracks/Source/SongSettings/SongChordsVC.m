//
//  SongChordsVC.m
//  GeniusJamTracks
//
//  13/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "SongChordsVC.h"
#import "Constant.h"
#import "YIInnerShadowView.h"
#import "ChordCollectionCell.h"
#import "AMXFontAutoScale.h"
#import "CustomVC.h"
@import VerticalSlider;


@interface SongChordsVC () 

@property (nonatomic, strong) IBOutlet UIView *vwRhythm;
@property (nonatomic, strong) IBOutlet UIView *vwQuickSetup;
@property (nonatomic, strong) IBOutlet UIView *vwTabs;
@property (nonatomic, strong) IBOutlet UIView *vwShadow;

//inner subviews in Quicksetup
@property (nonatomic, strong) IBOutlet UIView *vwGrouping;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerRatios;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerImage;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerNumbers;

@property (nonatomic, strong) IBOutlet UIButton *btnRatio;
@property (nonatomic, strong) IBOutlet UIView *vwRatioSelected;
@property (nonatomic, strong) IBOutlet UIView *vwRatioDeselected;

@property (nonatomic, strong) IBOutlet UIButton *btnGrouping;

@property (nonatomic, strong) IBOutlet UIButton *btnOther;
@property (nonatomic, strong) IBOutlet UIView *vwOtherSelected;
@property (nonatomic, strong) IBOutlet UIView *vwOtherDeselected;

@property (nonatomic, strong) IBOutlet UIButton *btnRandom;
@property (nonatomic, strong) IBOutlet UIButton *btnQuick;
@property (nonatomic, strong) IBOutlet UIButton *btnCustom;

@property (nonatomic, strong) IBOutlet UIButton *btnPiano;
@property (nonatomic, strong) IBOutlet UIView *vwPianoSelected;
@property (nonatomic, strong) IBOutlet UIView *vwPianoDeselected;

@property (nonatomic, strong) IBOutlet UIButton *btnBass;

@property (nonatomic, strong) IBOutlet UIButton *btnDrum;
@property (nonatomic, strong) IBOutlet UIView *vwDrumSelected;
@property (nonatomic, strong) IBOutlet UIView *vwDrumDeselected;

@property (nonatomic, strong) IBOutlet UIView *vwBottom;
@property (nonatomic, strong) IBOutlet UIView *vwPlaceShadow;

@property (nonatomic, strong) IBOutlet UICollectionView *chordsCollView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *leadingLabel;

@property (nonatomic, strong) IBOutlet UILabel *lblTitleSong;
@property (nonatomic, strong) IBOutlet UISlider *sliderHarmony;
@property (nonatomic, strong) IBOutlet UISlider *sliderRhythm;
@property (nonatomic, strong) IBOutlet UIImageView *imgShadow;

@property (nonatomic, strong) IBOutlet UIStackView *vwSongSettings;
@property (nonatomic, strong) IBOutlet UIButton *btnHead;
@property (nonatomic, strong) IBOutlet UIButton *btnTempo; //(“metronome icon_130”);
@property (nonatomic, strong) IBOutlet UIButton *btnTranspose; //"C"
@property (nonatomic, strong) IBOutlet UIButton *btnRepeats; // "x4"
@property (nonatomic, strong) IBOutlet UIButton *btnMixer; //"mixer"

//Mixer
@property (nonatomic, strong) IBOutlet VerticalSlider *sliderPiano;
@property (nonatomic, strong) IBOutlet VerticalSlider *sliderDrum;
@property (nonatomic, strong) IBOutlet VerticalSlider *sliderBass;
@property (nonatomic, strong) IBOutlet VerticalSlider *sliderMixerTempo;
@property (nonatomic, strong) IBOutlet UIView *vwMixer;

//Repeats
@property (nonatomic, strong) IBOutlet UIView *vwRepeats;
@property (nonatomic, strong) IBOutlet UISlider *sliderRepeats;
@property (nonatomic, strong) IBOutlet UIView *vwRepeatsBg;

//Tempo
@property (nonatomic, strong) IBOutlet UIView *vwTempo;
@property (nonatomic, strong) IBOutlet UISlider *sliderTempo;
@property (nonatomic, strong) IBOutlet UIView *vwTempoBg;

//Transpose
@property (nonatomic, strong) IBOutlet UIView *vwTranspose;
@property (nonatomic, strong) IBOutlet UIView *vwTransposeBtns;

//Head
@property (nonatomic, strong) IBOutlet UIView *vwHead;
@property (nonatomic, strong) IBOutlet UIButton *btnYes;
@property (nonatomic, strong) IBOutlet UIButton *btnNo;



//constraint outlets to change priority according to selected tab
         //   show/hide rhythm option by changing constraint priority
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *rhythmTopSpace;
        //    show/hide Quick set-up options by changing constraint priority
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *quickTopSpace;

//show/hide song settings by priority
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *settingsTopSpace;


@end

NSMutableArray *arrRatios;
NSMutableArray *arrImages;
NSMutableArray *arrNumbers;
NSMutableArray *arrOther;
NSMutableArray *arrChords;

NSMutableCharacterSet *charTypeA;
NSMutableArray *arrTypeB;
NSMutableCharacterSet *charRoot;
NSMutableCharacterSet *charAccid;
NSMutableArray *arrExtended;

NSInteger selectedIndex;


@implementation SongChordsVC

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(receiveSelectNotification:)
    name:@"TestNotification"
    object:nil];
    
    //- is accidental b
    _lblTitleSong.text = [[_dictSelectedSong.allKeys[0] stringByReplacingOccurrencesOfString:@"_" withString:@" "] stringByDeletingPathExtension];
  
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:[_dictSelectedSong.allValues[0] componentsSeparatedByString:@"bar"]];
    [arr removeObjectAtIndex:0];
    arrChords = arr;
    
    arrRatios = [[NSMutableArray alloc]initWithObjects:@"5:3",@"3:4",@"2:3", nil];
    arrNumbers = [[NSMutableArray alloc]initWithObjects:@"4",@"3",@"2", nil];
    arrOther = [[NSMutableArray alloc]initWithObjects:@"anticipation",@"double time",@"triple time", nil];
    arrImages = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"4"],[UIImage imageNamed:@"8"],[UIImage imageNamed:@"16"], nil];
    
    charRoot = [[NSMutableCharacterSet alloc]init];
    [charRoot addCharactersInString:@"ABCDEFG"];
    
    charAccid = [[NSMutableCharacterSet alloc]init];
    [charAccid addCharactersInString:@"#b"];
    
    charTypeA = [[NSMutableCharacterSet alloc]init];
    [charTypeA addCharactersInString:@"moø"];
    
    arrTypeB = [[NSMutableArray alloc]initWithObjects:@"6", @"7", @"9", @"6/9", @"b6", @"11", @"13", @"add9", @"7alt", @"Δ7", @"Δ9", @"Δ13", nil];
    
    arrExtended = [[NSMutableArray alloc]initWithObjects:@"b5", @"#5", @"b9", @"#9", @"#11", @"b13", @"sus2", @"sus4", @"#9#5", @"#9b5", @"#9#11", @"b9#11", @"b9b5", @"b9#5", @"b9#9", @"b9b13", @"add3sus4", @"b13sus4", @"13sus4", @"#9b13", nil];
    
    [self setSliders];
    
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    recognizer.delegate = self;
    [_chordsCollView addGestureRecognizer:recognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIDevice currentDevice] setValue:
    [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                               forKey:@"orientation"];
    [self.view layoutIfNeeded];
}

-(void)viewDidLayoutSubviews {
    [self setBorders];
    
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwPlaceShadow withRadius:5.0];
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwShadow withRadius:5.0];
    [Constant addInnerShadow:_vwPlaceShadow blackShadow:_vwShadow];
    
    _vwRepeatsBg.layer.masksToBounds = true;
    _vwRepeatsBg.layer.cornerRadius = 5.0;
    _vwRepeatsBg.layer.borderColor = [Constant createColorWithCode:151 green:151 blue:151].CGColor;
    _vwRepeatsBg.layer.borderWidth = 1.0;
    _vwRepeatsBg.layer.opacity = 0.04;
    
    _vwTempoBg.layer.masksToBounds = true;
    _vwTempoBg.layer.cornerRadius = 5.0;
    _vwTempoBg.layer.borderColor = [Constant createColorWithCode:151 green:151 blue:151].CGColor;
    _vwTempoBg.layer.borderWidth = 1.0;
    _vwTempoBg.layer.opacity = 0.04;
  
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
        
        if (selectedIndex == 1) {
            self.leadingLabel.constant = self.btnQuick.frame.origin.x;
        }
        [self.chordsCollView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [self setSelectedCornerRadius:_vwRatioSelected toCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft borderColor:Primary_Color];
    [self setSelectedCornerRadius:_vwRatioDeselected toCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft borderColor:Secondary_Color];
    
    [self setSelectedCornerRadius:_vwPianoSelected toCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft borderColor:Primary_Color];
    [self setSelectedCornerRadius:_vwPianoDeselected toCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft borderColor:Secondary_Color];
    
    [self setSelectedCornerRadius:_vwDrumSelected toCorners:UIRectCornerTopRight | UIRectCornerBottomRight borderColor:Primary_Color];
    [self setSelectedCornerRadius:_vwDrumDeselected toCorners:UIRectCornerTopRight | UIRectCornerBottomRight borderColor:Secondary_Color];
    
    [self setSelectedCornerRadius:_vwOtherSelected toCorners:UIRectCornerTopRight | UIRectCornerBottomRight borderColor:Primary_Color];
    [self setSelectedCornerRadius:_vwOtherDeselected toCorners:UIRectCornerTopRight | UIRectCornerBottomRight borderColor:Secondary_Color];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}



#pragma mark - UIButton Actions
- (IBAction)onTap:(UIPanGestureRecognizer *)recognizer {
    // Make image show up full screen
    [_vwBottom setHidden:!_vwBottom.isHidden];
    [_vwTabs setHidden:_vwBottom.isHidden];
}

- (IBAction)btnShowHideClicked:(UIButton*)sender {
    [_vwBottom setHidden:!_vwBottom.isHidden];
    [_vwTabs setHidden:_vwBottom.isHidden];
}


- (IBAction)btnChangeTabClicked:(UIButton*)sender {
    if (!sender.isSelected) {
        if (sender.tag == 0) {
            
          //  _topToQuick.priority = UILayoutPriorityDefaultLow;
            _quickTopSpace.priority = UILayoutPriorityDefaultLow;
            [_vwQuickSetup setHidden:YES];
            [_imgShadow setHidden:YES];
            
         //   _topToRhythm.priority = UILayoutPriorityDefaultHigh;
            _rhythmTopSpace.priority = UILayoutPriorityDefaultHigh;
            [_vwRhythm setHidden:NO];
            [_btnQuick setSelected:NO];
            [_btnCustom setSelected:NO];
            self.leadingLabel.constant = sender.frame.origin.x;
            
            
        } else if (sender.tag == 1) {
            _quickTopSpace.priority = UILayoutPriorityDefaultHigh;
            [_vwQuickSetup setHidden:NO];
            [_imgShadow setHidden:NO];
            
            
            _rhythmTopSpace.priority = UILayoutPriorityDefaultLow;
            [_vwRhythm setHidden:YES];
            [_btnRandom setSelected:NO];
            [_btnCustom setSelected:NO];
            
           
            [_pickerRatios reloadAllComponents];
            [_pickerNumbers reloadAllComponents];
            [_pickerImage reloadAllComponents];
            self.leadingLabel.constant = sender.frame.origin.x;
        } else {
            NSLog(@"Custom Clicked");
            
          //  self.leadingLabel.constant = _btnQuick.frame.origin.x;
            [self.vwTabs layoutIfNeeded];
            [_btnQuick setSelected:NO];
            [_btnRandom setSelected:NO];
            
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CustomVC* controller = [storyboard instantiateViewControllerWithIdentifier:@"CustomVC"];
            controller.dictSong = self.dictSelectedSong;
            [self.navigationController pushViewController:controller animated:YES];
            
         //   [_vwCustom setHidden:NO];
        }
        
        [sender setSelected:YES];
    } else {
        if (sender.tag == 0) {
            [_imgShadow setHidden:YES];
            _rhythmTopSpace.priority = UILayoutPriorityDefaultHigh;
            [_vwRhythm setHidden:NO];
            
            
        } else if (sender.tag == 1) {
            _quickTopSpace.priority = UILayoutPriorityDefaultHigh;
            [_vwQuickSetup setHidden:NO];
            [_imgShadow setHidden:NO];
            
           
            [_pickerRatios reloadAllComponents];
            [_pickerNumbers reloadAllComponents];
            [_pickerImage reloadAllComponents];
        } else {
            NSLog(@"Custom Clicked");
            
            [_btnQuick setSelected:NO];
            [_btnRandom setSelected:NO];
            
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CustomVC  *controller = [storyboard instantiateViewControllerWithIdentifier:@"CustomVC"];
            controller.dictSong = self.dictSelectedSong;
            [self.navigationController pushViewController:controller animated:NO];
            
         //   [_vwCustom setHidden:NO];
        }
    }
    
   [_vwSongSettings setHidden:YES];
      _settingsTopSpace.priority = UILayoutPriorityDefaultLow;
      [_btnTempo setTintColor:Secondary_Color];
      [_btnTempo setSelected:NO];
      
      [_btnTranspose setSelected:NO];
      [_btnRepeats setSelected:NO];
      
      [_btnMixer setTintColor:Secondary_Color];
      [_btnMixer setSelected:NO];
      
      [_btnHead setTintColor:Secondary_Color];
      [_btnHead setSelected:NO];
}


- (IBAction)btnSongSettingsPressed:(UIButton*)sender {
    
    if (!sender.isSelected) {
        if (sender == _btnRepeats) {
            [_vwRepeats setHidden:NO];
            
            [_vwTempo setHidden:YES];
            [_btnTempo setTintColor:Secondary_Color];
            [_btnTempo setSelected:NO];
            
            [_vwTranspose setHidden:YES];
            [_btnTranspose setSelected:NO];
            
            [_vwMixer setHidden:YES];
            [_btnMixer setTintColor:Secondary_Color];
            [_btnMixer setSelected:NO];
            
            [_vwHead setHidden:YES];
            [_btnHead setTintColor:Secondary_Color];
            [_btnHead setSelected:NO];
            _settingsTopSpace.constant = 25;
        } else if (sender == _btnTempo) {
            [_vwRepeats setHidden:YES];
            [_btnRepeats setSelected:NO];
            
            [_vwTempo setHidden:NO];
            [_btnTempo setTintColor:Primary_Color];
            
            [_vwTranspose setHidden:YES];
            [_btnTranspose setSelected:NO];
            
            [_vwMixer setHidden:YES];
            [_btnMixer setTintColor:Secondary_Color];
            [_btnMixer setSelected:NO];
            
            [_vwHead setHidden:YES];
            [_btnHead setTintColor:Secondary_Color];
            _settingsTopSpace.constant = 25;
            [_btnHead setSelected:NO];
        } else if (sender == _btnTranspose) {
            [_vwTranspose setHidden:NO];
            
            [_vwRepeats setHidden:YES];
            [_btnRepeats setSelected:NO];
            
            [_vwTempo setHidden:YES];
            [_btnTempo setTintColor:Secondary_Color];
            [_btnTempo setSelected:NO];
            
            [_vwMixer setHidden:YES];
            [_btnMixer setTintColor:Secondary_Color];
            [_btnMixer setSelected:NO];
            
            [_vwHead setHidden:YES];
            [_btnHead setTintColor:Secondary_Color];
            [_btnHead setSelected:NO];
            _settingsTopSpace.constant = 25;
        } else if (sender == _btnMixer) {
            [_vwRepeats setHidden:YES];
            [_btnRepeats setSelected:NO];
            
            [_vwMixer setHidden:NO];
            [_btnMixer setTintColor:Primary_Color];
            
            [_vwTranspose setHidden:YES];
            [_btnTranspose setSelected:NO];
            
            [_vwTempo setHidden:YES];
            [_btnTempo setTintColor:Secondary_Color];
            [_btnTempo setSelected:NO];
            
            [_vwHead setHidden:YES];
            [_btnHead setTintColor:Secondary_Color];
            [_btnHead setSelected:NO];
            _settingsTopSpace.constant = 14;
            
        } else if (sender == _btnHead) {
            [_vwTranspose setHidden:YES];
            [_btnTranspose setSelected:NO];
            
            [_vwRepeats setHidden:YES];
            [_btnRepeats setSelected:NO];
            
            [_vwTempo setHidden:YES];
            [_btnTempo setTintColor:Secondary_Color];
            [_btnTempo setSelected:NO];
            
            [_vwMixer setHidden:YES];
            [_btnMixer setTintColor:Secondary_Color];
            [_btnMixer setSelected:NO];
            
            [_vwHead setHidden:NO];
            [_btnHead setTintColor:Primary_Color];
            _settingsTopSpace.constant = 25;
        }
        
        [_vwRhythm setHidden:YES];
        [_vwQuickSetup setHidden:YES];
        [_imgShadow setHidden:NO];
        [_vwSongSettings setHidden:NO];
        
        _quickTopSpace.priority = UILayoutPriorityDefaultLow;
        _rhythmTopSpace.priority = UILayoutPriorityDefaultLow;
        _settingsTopSpace.priority = UILayoutPriorityDefaultHigh;
    } else {
        if (sender == _btnRepeats) {
            [_vwRepeats setHidden:YES];
        } else if (sender == _btnTempo) {
            [_btnTempo setTintColor:Secondary_Color];
            [_vwTempo setHidden:YES];
        } else if (sender == _btnTranspose) {
            [_vwTranspose setHidden:YES];
        } else if (sender == _btnMixer) {
            [_btnMixer setTintColor:Secondary_Color];
            [_vwMixer setHidden:YES];
        } else if (sender == _btnHead) {
            [_btnHead setTintColor:Secondary_Color];
            [_vwHead setHidden:YES];
        }
        
        if (_btnRandom.isSelected) {
            [_vwRhythm setHidden:NO];
            _quickTopSpace.priority = UILayoutPriorityDefaultLow;
               [_vwQuickSetup setHidden:YES];
               [_imgShadow setHidden:YES];
               _rhythmTopSpace.priority = UILayoutPriorityDefaultHigh;
               [_vwRhythm setHidden:NO];
        } else if (_btnQuick.isSelected) {
            [_vwQuickSetup setHidden:NO];
            _quickTopSpace.priority = UILayoutPriorityDefaultHigh;
            [_imgShadow setHidden:NO];
            _rhythmTopSpace.priority = UILayoutPriorityDefaultLow;
            [_vwRhythm setHidden:YES];
        } else {
            
        }
        [_vwSongSettings setHidden:YES];
        _settingsTopSpace.priority = UILayoutPriorityDefaultLow;
    }
    
    
    [sender setSelected:(!sender.isSelected)];
    if (sender == _btnHead) {
        [sender setSelected:NO];
    }
    
}

- (IBAction)btnInstrumentPressed:(UIButton*)sender {
    
    [sender setSelected:(!sender.isSelected)];
    
    if (sender.isSelected) {
        [self changeAppearanceToSelect:sender];
    } else {
        [self changeAppearanceToDeselect:sender];
    }
}

- (IBAction)btnQuicksetupTabClicked:(UIButton*)sender {
    if (!sender.isSelected) {
        if (sender.tag == 0) {
            [_pickerRatios setHidden:NO];
             [_vwGrouping setHidden:YES];
            
            [_btnGrouping setSelected:NO];
            [_btnOther setSelected:NO];
           
            [self changeAppearanceToDeselect:_btnGrouping];
            [self changeAppearanceToDeselect:_btnOther];
            [self changeAppearanceToSelect:_btnRatio];
            
            [_pickerRatios reloadAllComponents];
            
        } else if (sender.tag == 1) {
            [_pickerRatios setHidden:YES];
            [_vwGrouping setHidden:NO];
            
            [_btnRatio setSelected:NO];
            [_btnOther setSelected:NO];
            
            [self changeAppearanceToDeselect:_btnRatio];
            [self changeAppearanceToDeselect:_btnOther];
            [self changeAppearanceToSelect:_btnGrouping];
            
            [_pickerNumbers reloadAllComponents];
            [_pickerImage reloadAllComponents];
        } else {
            [_pickerRatios setHidden:NO];
            [_vwGrouping setHidden:YES];
            
            [_btnGrouping setSelected:NO];
            [_btnRatio setSelected:NO];
            
            [self changeAppearanceToDeselect:_btnRatio];
            [self changeAppearanceToDeselect:_btnGrouping];
            [self changeAppearanceToSelect:_btnOther];
            
            [_pickerRatios reloadAllComponents];
        }
        [sender setSelected:YES];
    }
}

- (IBAction)btnTransposePressed:(UIButton*)sender {
    
    if (!sender.isSelected) {
        [sender setSelected:YES];
        [Constant setBorderWithColor:Primary_Color width:0.5 toView:sender withRadius:3];
        
        for (UIButton *btn in self.vwTransposeBtns.subviews) {
            if (btn.tag != sender.tag) {
                [btn setSelected:NO];
                [Constant setBorderWithColor:[UIColor clearColor] width:0 toView:btn withRadius:0];
            }
        }
    }
}

- (IBAction)btnBackClicked:(UIButton*)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnYesNoClicked:(UIButton*)sender {
    if (!sender.isSelected) {
        if (sender == _btnYes) {
            [_btnYes setSelected:YES];
            [_btnNo setSelected:NO];
        } else {
            [_btnYes setSelected:NO];
            [_btnNo setSelected:YES];
        }
    }
}

- (IBAction)btnSelectedHeadClickedClicked:(UIButton*)sender {
    [_btnHead setTintColor:Secondary_Color];
        [_vwHead setHidden:YES];
    
    if (_btnRandom.isSelected) {
        [_vwRhythm setHidden:NO];
        _quickTopSpace.priority = UILayoutPriorityDefaultLow;
           [_vwQuickSetup setHidden:YES];
           [_imgShadow setHidden:YES];
           _rhythmTopSpace.priority = UILayoutPriorityDefaultHigh;
           [_vwRhythm setHidden:NO];
    } else if (_btnQuick.isSelected) {
        [_vwQuickSetup setHidden:NO];
        _quickTopSpace.priority = UILayoutPriorityDefaultHigh;
        [_imgShadow setHidden:NO];
        _rhythmTopSpace.priority = UILayoutPriorityDefaultLow;
        [_vwRhythm setHidden:YES];
    } else {
        
    }
    [_vwSongSettings setHidden:YES];
    _settingsTopSpace.priority = UILayoutPriorityDefaultLow;
}

#pragma mark - Other Methods
- (void)setBorders {
    
       [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnGrouping withRadius:0.0];
   
//    [self setSelectedCornerRadius:_btnOther toCorners:UIRectCornerTopRight | UIRectCornerBottomRight borderColor:Secondary_Color];
//    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnOther withRadius:0.0];
//
//    [Constant setBorderWithColor:Primary_Color width:0.5 toView:_btnPiano withRadius:0.0];
//    [self setSelectedCornerRadius:_btnPiano toCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft borderColor:Primary_Color];
//    _btnPiano.backgroundColor = [Constant createColorWithCode:37 green:40 blue:41];
//
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnBass withRadius:0.0];
//
//    [self setSelectedCornerRadius:_btnDrum toCorners:UIRectCornerTopRight | UIRectCornerBottomRight borderColor:Secondary_Color];
//    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnDrum withRadius:0.0];
//
    
}

- (void) receiveSelectNotification:(NSNotification *) notification {
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.

    if ([[notification name] isEqualToString:@"TestNotification"]) {
        NSDictionary *userInfo = notification.userInfo;
        NSInteger temp = [[userInfo objectForKey:@"tag"] integerValue];
        
        selectedIndex = temp;
        if (temp == 0) {
            [self btnChangeTabClicked:_btnRandom];
        } else {
            [self btnChangeTabClicked:_btnQuick];
        }
    }
}


- (void)setSelectedCornerRadius:(UIView*)view toCorners:(UIRectCorner)corners borderColor:(UIColor*)color {
  
    
    if (view.layer.sublayers.count == 0) {
         CAShapeLayer * maskLayer = [CAShapeLayer layer];
         view.layer.masksToBounds = YES;
         view.clipsToBounds = YES;
         maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: view.layer.bounds byRoundingCorners: corners cornerRadii: (CGSize){5.0, 5.0}].CGPath;
         view.layer.mask = maskLayer;
         
         
         CAShapeLayer * borderLayer = [CAShapeLayer layer];
         borderLayer.path = maskLayer.path; // Reuse the Bezier path
         borderLayer.fillColor = [UIColor clearColor].CGColor;
         borderLayer.strokeColor = color.CGColor;
         borderLayer.lineWidth = 1;
         borderLayer.name = @"border";
         borderLayer.frame = view.bounds;
         [view.layer addSublayer:borderLayer];
    } else {
//        view.layer.mask = nil;
//
        for (CAShapeLayer *layer in self.view.layer.sublayers) {
            if ([layer.name isEqualToString:@"border"]) {
                [layer removeFromSuperlayer];
            }
        }//
//
        CAShapeLayer * borderLayer = [CAShapeLayer layer];
        CAShapeLayer *layer = view.layer.mask;
        borderLayer.path = layer.path; // Reuse the Bezier path
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = color.CGColor;
        borderLayer.lineWidth = 1;
        borderLayer.name = @"border";
        borderLayer.frame = view.bounds;
        [view.layer addSublayer:borderLayer];

    }
}

- (void)changeAppearanceToDeselect:(UIButton*)btn {
    
    if (btn == _btnGrouping || btn == _btnBass) {
        [Constant setBorderWithColor:Secondary_Color width:0.5 toView:btn withRadius:0.0];
        btn.backgroundColor = [UIColor clearColor];
    } else {
        if (btn == _btnOther) {
          [_vwOtherSelected setHidden:YES];
          [_vwOtherDeselected setHidden:NO];
        } else if (btn == _btnRatio) {
            [_vwRatioSelected setHidden:YES];
            [_vwRatioDeselected setHidden:NO];
        } else if (btn == _btnPiano) {
            [_vwPianoSelected setHidden:YES];
            [_vwPianoDeselected setHidden:NO];
        } else  {
            [_vwDrumSelected setHidden:YES];
            [_vwDrumDeselected setHidden:NO];
        }
    }
}

- (void)changeAppearanceToSelect:(UIButton*)btn {
    if (btn == _btnGrouping || btn == _btnBass) {
        [Constant setBorderWithColor:Primary_Color width:0.5 toView:btn withRadius:0.0];
        btn.backgroundColor = [Constant createColorWithCode:49 green:53 blue:54];
      //  btn.backgroundColor = kCGColorSpaceLinearSRGB
    } else {
        if (btn == _btnOther) {
          [_vwOtherSelected setHidden:NO];
          [_vwOtherDeselected setHidden:YES];
        } else if (btn == _btnRatio) {
            [_vwRatioSelected setHidden:NO];
            [_vwRatioDeselected setHidden:YES];
        } else if (btn == _btnPiano) {
            [_vwPianoSelected setHidden:NO];
            [_vwPianoDeselected setHidden:YES];
        } else  {
            [_vwDrumSelected setHidden:NO];
            [_vwDrumDeselected setHidden:YES];
        }
    }
}

- (void)setScalableProperty:(UILabel*)lbl {
    lbl.amx_autoScaleEnabled = YES;
    lbl.amx_referenceScreenSize = AMXScreenSize5p5Inch;
}

- (void)setSliderThumbImage:(UISlider*)slider {
    [slider setThumbImage:[UIImage imageNamed:@"Thumb"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"Thumb"] forState:UIControlStateHighlighted];
}

- (void)setSliders {
    [self setSliderThumbImage:_sliderHarmony];
    [self setSliderThumbImage:_sliderRhythm];
    [self setSliderThumbImage:_sliderTempo];
    [self setSliderThumbImage:_sliderRepeats];
}



#pragma mark - UIPickerView Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _pickerRatios) {
        if (_btnRatio.isSelected) {
            return arrRatios.count;
        } else {
            return arrOther.count;
        }
    } else if (pickerView == _pickerNumbers) {
        return arrNumbers.count;
    }
    return arrImages.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if (pickerView == _pickerRatios || pickerView == _pickerNumbers) {
           UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:21.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = Secondary_Color;
        if (pickerView == _pickerRatios) {
            if (_btnRatio.isSelected) {
                 label.text = arrRatios[row];
            } else {
                 label.text = arrOther[row];
            }
        } else {
            label.text = arrNumbers[row];
        }
        return label ;
    } else {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, pickerView.frame.size.width, 20)];
            imgView.image = arrImages[row];
            imgView.tintColor = [UIColor whiteColor];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            return  imgView;
    }}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}



#pragma mark - UICollectionView Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (arrChords.count%4 != 0) {
        return [arrChords count]+1;
    }
    return [arrChords count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChordCollectionCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == arrChords.count && arrChords.count%4 != 0) {
        [cell.vwChord1 setHidden:YES];
        [cell.vwChord2 setHidden:YES];
        [cell.vwChord3 setHidden:YES];
        [cell.vwChord4 setHidden:YES];
        [cell.vwChord01 setHidden:YES];
        [cell.vwChord02 setHidden:YES];
        [cell.lblLastChordLine setHidden:YES];
    } else {
        if ((indexPath.row+1)%4 == 0) {
            [cell.lblLastChordLine setHidden:NO];
        } else {
            [cell.lblLastChordLine setHidden:YES];
        }
        NSArray* arr = [arrChords[indexPath.row] componentsSeparatedByString:@"chord"];
        
        
        if (arr.count-1 == 1) {
            [cell.vwChord1 setHidden:YES];
            [cell.vwChord2 setHidden:YES];
            [cell.vwChord3 setHidden:YES];
            [cell.vwChord4 setHidden:YES];
            [cell.vwChord01 setHidden:NO];
            [cell.vwChord02 setHidden:YES];
        } else if (arr.count-1 == 2) {
            [cell.vwChord1 setHidden:YES];
            [cell.vwChord2 setHidden:YES];
            [cell.vwChord3 setHidden:YES];
            [cell.vwChord4 setHidden:YES];
            [cell.vwChord01 setHidden:NO];
            [cell.vwChord02 setHidden:NO];
        } else if (arr.count-1 == 3) {
            [cell.vwChord1 setHidden:NO];
            [cell.vwChord2 setHidden:YES];
            [cell.vwChord3 setHidden:NO];
            [cell.vwChord4 setHidden:NO];
            [cell.vwChord01 setHidden:YES];
            [cell.vwChord02 setHidden:YES];
        } else {
            [cell.vwChord1 setHidden:NO];
            [cell.vwChord2 setHidden:NO];
            [cell.vwChord3 setHidden:NO];
            [cell.vwChord4 setHidden:NO];
            [cell.vwChord01 setHidden:YES];
            [cell.vwChord02 setHidden:YES];
        }
        
        [self setScalableProperty:cell.lblExtended01];
        [self setScalableProperty:cell.lblRoot01];
        [self setScalableProperty:cell.lblTypeA01];
        [self setScalableProperty:cell.lblTypeB01];
        [self setScalableProperty:cell.lblAccidental01];
        
        [self setScalableProperty:cell.lblExtended02];
        [self setScalableProperty:cell.lblRoot02];
        [self setScalableProperty:cell.lblTypeA02];
        [self setScalableProperty:cell.lblTypeB02];
        [self setScalableProperty:cell.lblAccidental02];
        
        [self setScalableProperty:cell.lblExtended1];
        [self setScalableProperty:cell.lblRoot1];
        [self setScalableProperty:cell.lblTypeA1];
        [self setScalableProperty:cell.lblTypeB1];
        [self setScalableProperty:cell.lblAccidental1];
        
        [self setScalableProperty:cell.lblExtended2];
        [self setScalableProperty:cell.lblRoot2];
        [self setScalableProperty:cell.lblTypeA2];
        [self setScalableProperty:cell.lblTypeB2];
        [self setScalableProperty:cell.lblAccidental2];
        
        [self setScalableProperty:cell.lblExtended3];
        [self setScalableProperty:cell.lblRoot3];
        [self setScalableProperty:cell.lblTypeA3];
        [self setScalableProperty:cell.lblTypeB3];
        [self setScalableProperty:cell.lblAccidental3];
        
        [self setScalableProperty:cell.lblExtended4];
        [self setScalableProperty:cell.lblRoot4];
        [self setScalableProperty:cell.lblTypeA4];
        [self setScalableProperty:cell.lblTypeB4];
        [self setScalableProperty:cell.lblAccidentalt4];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 0.0;
    if ( IDIOM == IPAD ) {
        height = collectionView.frame.size.height/12.5;
    } else {
        height = 41;
    }
    return CGSizeMake((self.view.frame.size.width/4)-1, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 2, 10, 2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}





@end
