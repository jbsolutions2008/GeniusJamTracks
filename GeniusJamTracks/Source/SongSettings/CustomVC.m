//
//  CustomVC.m
//  GeniusJamTracks
//
//   18/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "CustomVC.h"
#import "Constant.h"
#import "ChordCollectionCell.h"
#import "AMXFontAutoScale.h"
#import "LibraryVC.h"
#import "AppTabbarController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@interface CustomVC ()

@property (nonatomic, strong) IBOutlet UIView *vwTabs;
@property (nonatomic, strong) IBOutlet UIButton *btnMenu;
@property (nonatomic, strong) IBOutlet UIButton *btnRandom;
@property (nonatomic, strong) IBOutlet UIButton *btnQuick;
@property (nonatomic, strong) IBOutlet UIButton *btnCustom;


@property (nonatomic, strong) IBOutlet UICollectionView *collSongSettingsView;

//Quick setup subviews
@property (nonatomic, strong) IBOutlet UIView *vwQuicksetupContainer;
@property (nonatomic, strong) IBOutlet UIView *vwQuickShadow;

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

//In and Out outlets
@property (nonatomic, strong) IBOutlet UIButton *btnIn;
@property (nonatomic, strong) IBOutlet UIButton *btnOut;
@property (nonatomic, strong) IBOutlet UIButton *btnDone;
@property (nonatomic, strong) IBOutlet UILabel *lblOutvalue;
@property (nonatomic, strong) IBOutlet UILabel *lblInValue;

//Main Container Views
@property (nonatomic, strong) IBOutlet UIView *vwSongSettings;
@property (nonatomic, strong) IBOutlet UIView *vwQuick;

//Instruments
@property (nonatomic, strong) IBOutlet UIButton *btnPiano;
@property (nonatomic, strong) IBOutlet UIButton *btnBass;
@property (nonatomic, strong) IBOutlet UIButton *btnDrum;
@property (nonatomic, strong) IBOutlet UIView *vwInstrument;

//Random
@property (nonatomic, strong) IBOutlet UIView *vwRandom;
@property (nonatomic, strong) IBOutlet UIView *vwRandomShadow;

//Harmony
@property (nonatomic, strong) IBOutlet UIView *vwHarmony;
@property (nonatomic, strong) IBOutlet UISlider *sliderHarmony;

//Repeats
@property (nonatomic, strong) IBOutlet UIView *vwRepeats;
@property (nonatomic, strong) IBOutlet UISlider *sliderRepeats;
@property (nonatomic, strong) IBOutlet UILabel *lblRepeatsvalue;

//Tempo
@property (nonatomic, strong) IBOutlet UIView *vwTempo;
@property (nonatomic, strong) IBOutlet UISlider *sliderTempo;
@property (nonatomic, strong) IBOutlet UILabel *lblTempovalue;

//Transpose
@property (nonatomic, strong) IBOutlet UIView *vwTranspose;
@property (nonatomic, strong) IBOutlet UIView *vwTransposeBtns;

//Head
@property (nonatomic, strong) IBOutlet UIView *vwHead;
@property (nonatomic, strong) IBOutlet UIButton *btnYes;
@property (nonatomic, strong) IBOutlet UIButton *btnNo;

//Mixer
@property (nonatomic, strong) IBOutlet UISlider *sliderPiano;
@property (nonatomic, strong) IBOutlet UISlider *sliderDrum;
@property (nonatomic, strong) IBOutlet UISlider *sliderBass;
@property (nonatomic, strong) IBOutlet UISlider *sliderMixerTempo;
@property (nonatomic, strong) IBOutlet UIView *vwMixer;

//Buttons
@property (nonatomic, strong) IBOutlet UIButton *btnHead;
@property (nonatomic, strong) IBOutlet UIButton *btnTempo; //(“metronome icon_130”);
@property (nonatomic, strong) IBOutlet UIButton *btnTranspose; //"C"
@property (nonatomic, strong) IBOutlet UIButton *btnRepeats; // "x4"
@property (nonatomic, strong) IBOutlet UIButton *btnMixer; //"mixer"

//Main Scroller
@property (nonatomic, strong) IBOutlet UICollectionView *collView;
@property (nonatomic, strong) IBOutlet UIView *vwMainScroller;
@property (nonatomic, strong) IBOutlet UIView *vwScrollContainer;
@property (nonatomic, strong) IBOutlet UIView *vwScrollContainerShadow;
@property (nonatomic, strong) IBOutlet UIView *vwMainInstrument;
@property (nonatomic, strong) IBOutlet UIScrollView *scrlView;

@property (nonatomic, strong) IBOutlet UIView *vwPiano;
@property (nonatomic, strong) IBOutlet UIView *vwBass;
@property (nonatomic, strong) IBOutlet UIView *vwDrum;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *pianoLeading;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *pianoWidth;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bassLeading;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *drumLeading;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bassWidth;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *drumWidth;

@property (nonatomic, strong) IBOutlet UIButton *btnShowSetting;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *collHeight;



@end


NSMutableArray *arrRatios_;
NSMutableArray *arrImages_;
NSMutableArray *arrNumbers_;
NSMutableArray *arrOther_;
NSMutableArray *arrChords_;
UICollectionViewLayout *collLayout;
BOOL wasMainScroll;

@implementation CustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ( IDIOM == IPAD ) {
        _collHeight.constant = _vwScrollContainer.frame.size.height / 9;
    } else {
        _collHeight.constant = 41.0;
    }
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    recognizer.delegate = self;
    [_collView addGestureRecognizer:recognizer];
    
    UITapGestureRecognizer * recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnShowHidePressed:)];
    recognizer1.delegate = self;
    [_collSongSettingsView addGestureRecognizer:recognizer1];
    
    [_vwScrollContainer addGestureRecognizer:self.collView.panGestureRecognizer];

    [_vwScrollContainer addGestureRecognizer:self.scrlView.panGestureRecognizer];
    
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:[_dictSong.allValues[0] componentsSeparatedByString:@"bar"]];
    [arr removeObjectAtIndex:0];
    arrChords_ = arr;
    
    [self.collView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.scrlView.contentSize = CGSizeMake(self.collView.contentSize.width, self.scrlView.contentSize.height);
        collLayout = self.collView.collectionViewLayout;
        [self setInstrument];
        
    });
    
    arrRatios_ = [[NSMutableArray alloc]initWithObjects:@"5:3",@"3:4",@"2:3", nil];
    arrNumbers_ = [[NSMutableArray alloc]initWithObjects:@"4",@"3",@"2", nil];
    arrOther_ = [[NSMutableArray alloc]initWithObjects:@"anticipation",@"double time",@"triple time", nil];
    arrImages_ = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"4"],[UIImage imageNamed:@"8"],[UIImage imageNamed:@"16"], nil];
  
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-90));
    

    [self.vwTabs setTransform: transform];
    [self setSliders];
    _lblRepeatsvalue.text = [NSString stringWithFormat:@"Repeats %s","4"];//replace 4 with slider value
    _lblTempovalue.text = [NSString stringWithFormat:@"Tempo %s","130"];//replace 130 with tempo slider value
    

}

- (void)viewWillAppear:(BOOL)animated {
    [[UIDevice currentDevice] setValue:
    [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]
                               forKey:@"orientation"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIDevice currentDevice] setValue:
    [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                               forKey:@"orientation"];
}

- (void)viewDidLayoutSubviews {
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwRandomShadow withRadius:5.0];
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwRandom withRadius:5.0];
    
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwQuickShadow withRadius:5.0];
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwQuicksetupContainer withRadius:5.0];
    
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwScrollContainer withRadius:5.0];
    [Constant setBorderWithColor:[UIColor clearColor] width:0.0 toView:_vwScrollContainerShadow withRadius:5.0];
    
   
    [Constant addInnerShadow:_vwRandomShadow blackShadow:_vwRandom];
    [Constant addInnerShadow:_vwQuickShadow blackShadow:_vwQuicksetupContainer];
    [Constant addInnerShadow:_vwScrollContainerShadow blackShadow:_vwScrollContainer];
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnGrouping withRadius:0.0];
    
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnDone withRadius:5.0];
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnIn withRadius:5.0];
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnOut withRadius:5.0];
    
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnPiano withRadius:5.0];
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnDrum withRadius:5.0];
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_btnBass withRadius:5.0];
}

- (void)viewWillLayoutSubviews {
     
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self setSelectedCornerRadius:_vwRatioSelected toCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft borderColor:Primary_Color];
    [self setSelectedCornerRadius:_vwRatioDeselected toCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft borderColor:Secondary_Color];
    

    
    [self setSelectedCornerRadius:_vwOtherSelected toCorners:UIRectCornerTopRight | UIRectCornerBottomRight borderColor:Primary_Color];
    [self setSelectedCornerRadius:_vwOtherDeselected toCorners:UIRectCornerTopRight | UIRectCornerBottomRight borderColor:Secondary_Color];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
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

#pragma mark - UIButton Actions

- (IBAction)btnBackClicked:(UIButton*)sender {
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[AppTabbarController class]]){
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }

    //[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnSectionClicked:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnBarClicked:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnChorusClicked:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
            
            [_vwHarmony setHidden:YES];
            
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
            
            [_btnHead setSelected:NO];
            [_vwHarmony setHidden:YES];
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
            [_vwHarmony setHidden:YES];
            
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
            
            [_vwHarmony setHidden:YES];
            
            
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
            
            [_vwHarmony setHidden:YES];
        }
        
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
        
        [_vwHarmony setHidden:NO];
        /*
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
         */
    }
         
    
    
    [sender setSelected:(!sender.isSelected)];
    if (sender == _btnHead) {
        [sender setSelected:NO];
    }
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
    [_vwHarmony setHidden:NO];
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

- (IBAction)btnShowHidePressed:(UIButton*)btn {
    
    wasMainScroll = !(_vwMainScroller.isHidden);
    [_vwInstrument setHidden:YES];
    [_vwSongSettings setHidden:!(_vwSongSettings.isHidden)];
    [_collSongSettingsView setHidden:_vwSongSettings.isHidden];
    [_btnShowSetting setHidden:_vwSongSettings.isHidden];
    [_vwQuick setHidden:YES];
    [_vwMainScroller setHidden:!(_vwSongSettings.isHidden)];
    [_btnMenu setSelected:!(_vwQuick.isHidden)];
    
    [self syncChordScroll];
    
    
    
}

- (IBAction)onTap:(UIPanGestureRecognizer *)recognizer {
    wasMainScroll = !(_vwMainScroller.isHidden);
    [_vwInstrument setHidden:YES];
    [_vwSongSettings setHidden:!(_vwSongSettings.isHidden)];
    [_btnShowSetting setHidden:_vwSongSettings.isHidden];
    [_vwQuick setHidden:YES];
    [_btnMenu setSelected:!(_vwQuick.isHidden)];
    [_vwMainScroller setHidden:!(_vwSongSettings.isHidden)];
    [_collSongSettingsView setHidden:!(_vwMainScroller.isHidden)];
    
    [self syncChordScroll];
}

- (IBAction)btnDoneClicked:(UIButton*)sender {
    wasMainScroll = !(_vwMainScroller.isHidden);
    [_vwQuick setHidden:YES];
    [_vwInstrument setHidden:YES];
    [_vwSongSettings setHidden:YES];
    [_btnShowSetting setHidden:_vwSongSettings.isHidden];
    [_vwMainScroller setHidden:!(_vwSongSettings.isHidden)];
    [_collSongSettingsView setHidden:!(_vwMainScroller.isHidden)];
    [_btnMenu setSelected:!(_vwQuick.isHidden)];
    
    [self syncChordScroll];
}

- (IBAction)btnMenuClicked:(UIButton*)sender {
    [sender setSelected:!(sender.isSelected)];
    wasMainScroll = !(_vwMainScroller.isHidden);
    [_vwQuick setHidden:!(_vwQuick.isHidden)];
    [_btnMenu setSelected:!(_vwQuick.isHidden)];
    [_vwInstrument setHidden:(_vwQuick.isHidden)];
    [_vwSongSettings setHidden:YES];
    [_btnShowSetting setHidden:_vwSongSettings.isHidden];
    [_vwMainScroller setHidden:!(_vwQuick.isHidden)];
    [_collSongSettingsView setHidden:!(_vwMainScroller.isHidden)];
    
    [self syncChordScroll];
    
}

- (IBAction)btnInOutClicked:(UIButton*)sender {
    if (!sender.isSelected) {
        if (sender == _btnIn) {
            [_btnIn setSelected:YES];
            [_btnOut setSelected:NO];
            [self changeAppearanceToSelect:_btnIn];
            [self changeAppearanceToDeselect:_btnOut];
        } else {
            [_btnIn setSelected:NO];
            [_btnOut setSelected:YES];
            [self changeAppearanceToSelect:_btnOut];
            [self changeAppearanceToDeselect:_btnIn];
        }
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

- (IBAction)btnMainInstrumentPressed:(UIButton*)sender {
    
    [sender setSelected:(!sender.isSelected)];
}

- (IBAction)btnTabPressed:(UIButton*)sender {
    
    NSDictionary *userInfo =
    [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:sender.tag]  forKey:@"tag"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"TestNotification" object:nil userInfo:userInfo];
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Other Methods
- (void)setSliderThumbImage:(UISlider*)slider {
    [slider setThumbImage:[UIImage imageNamed:@"Thumb"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"Thumb"] forState:UIControlStateHighlighted];
}

- (void)setSliders {
    [self setSliderThumbImage:_sliderHarmony];
    [self setSliderThumbImage:_sliderBass];
    [self setSliderThumbImage:_sliderTempo];
    [self setSliderThumbImage:_sliderRepeats];
    [self setSliderThumbImage:_sliderPiano];
    [self setSliderThumbImage:_sliderDrum];
    [self setSliderThumbImage:_sliderMixerTempo];
}

- (void)setScalableProperty:(UILabel*)lbl {
    
    lbl.amx_autoScaleEnabled = YES;
    if ( IDIOM == IPAD ) {
        lbl.amx_referenceScreenSize = AMXScreenSizeIpadLandscape;
    } else {
        lbl.amx_referenceScreenSize = AMXScreenSizeLandscape;
    }
    
    
}

- (void)syncChordScroll {
    if (!(wasMainScroll)) {
        [_collView setContentOffset:_collSongSettingsView.contentOffset animated:NO];
        [_scrlView setContentOffset:_collSongSettingsView.contentOffset animated:NO];
    }
    
    if (!(_collSongSettingsView.isHidden)) {
        [_collSongSettingsView setContentOffset:_collView.contentOffset animated:NO];
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
    
    if (btn == _btnGrouping ) {
        [Constant setBorderWithColor:Secondary_Color width:0.5 toView:btn withRadius:0.0];
        btn.backgroundColor = [UIColor clearColor];
    } else if (btn == _btnOut || btn == _btnIn || btn == _btnPiano || btn == _btnBass || btn == _btnDrum) {
        [Constant setBorderWithColor:Secondary_Color width:0.5 toView:btn withRadius:5.0];
        btn.backgroundColor = [UIColor clearColor];
    }
    else {
        if (btn == _btnOther) {
          [_vwOtherSelected setHidden:YES];
          [_vwOtherDeselected setHidden:NO];
        } else if (btn == _btnRatio) {
            [_vwRatioSelected setHidden:YES];
            [_vwRatioDeselected setHidden:NO];
        }
    }
}

- (void)changeAppearanceToSelect:(UIButton*)btn {
    if (btn == _btnGrouping ) {
        [Constant setBorderWithColor:Primary_Color width:0.5 toView:btn withRadius:0.0];
        btn.backgroundColor = [Constant createColorWithCode:49 green:53 blue:54];
      //  btn.backgroundColor = kCGColorSpaceLinearSRGB
    } else if (btn == _btnOut || btn == _btnIn)  {
        [Constant setBorderWithColor:Primary_Color width:0.5 toView:btn withRadius:5.0];
        btn.backgroundColor = [Constant createColorWithCode:49 green:53 blue:54];
    } else if (btn == _btnPiano || btn == _btnBass || btn == _btnDrum) {
        [Constant setBorderWithColor:Primary_Color width:0.5 toView:btn withRadius:5.0];
        btn.backgroundColor = [Constant createColorWithCode:26 green:26 blue:26];
    } else {
        if (btn == _btnOther) {
          [_vwOtherSelected setHidden:NO];
          [_vwOtherDeselected setHidden:YES];
        } else if (btn == _btnRatio) {
            [_vwRatioSelected setHidden:NO];
            [_vwRatioDeselected setHidden:YES];
        }
    }
}

-(void)setInstrument {
    /*
    pianoBox1 = “3:4”
    StartingPoint = Position 1. 3. 1
    “1” is Bar 1
    “3” is the 3rd place in the Bar (2.0)
    EndingPoint = Position 3. 2. 1
    “3” is Bar 3
    “2” is the 2nd place in the Bar (1.0)
     */
    
    
    //starting point, "indexPathForItem:0", 0 is for first cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    ChordCollectionCell *cell = (ChordCollectionCell*)[self.collView cellForItemAtIndexPath:indexPath];
    CGRect cellRect = cell.frame;
    
    _pianoLeading.constant = cellRect.origin.x + cell.vwChord3.frame.origin.x;
    
    
    //ending point, "indexPathForItem:2", 2 is for third cell
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:2 inSection:0];
    ChordCollectionCell *cell1 = (ChordCollectionCell*)[self.collView cellForItemAtIndexPath:indexPath1];
    CGRect cellRect1 = cell1.frame;
    
    _pianoWidth.constant = cellRect1.origin.x + cell1.vwChord2.frame.origin.x - _pianoLeading.constant;
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_vwPiano withRadius:5.0];
    
    
    
    /*
    bassBox1 = “triplets in groups of 5”
    StartingPoint = Position 2. 1. 1
    “2” is Bar 2
    “1” is the 1st place in the Bar2 (0.0)
    EndingPoint = Position 6. 1. 1
    “6” is Bar 6
    “1” is the 1st place in the Bar6 (0.0)
     */
    
    
    
     //starting point, "indexPathForItem:1", 1 is for second cell
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:1 inSection:0];
    
    UICollectionViewLayoutAttributes *layoutAttributes = [collLayout layoutAttributesForItemAtIndexPath:indexPath2];
    CGRect cellRect2 = layoutAttributes.frame;
     
    _bassLeading.constant = cellRect2.origin.x + (cellRect2.size.width/6.22)*0 + 4;
     
     //ending point, "indexPathForItem:5", 5 is for sixth cell
     NSIndexPath *indexPath3 = [NSIndexPath indexPathForItem:5 inSection:0];
    
    UICollectionViewLayoutAttributes *layoutAttributes1 = [collLayout layoutAttributesForItemAtIndexPath:indexPath3];
    CGRect cellRect3 = layoutAttributes1.frame;
     
     _bassWidth.constant = cellRect3.origin.x + (cellRect3.size.width/6.22)*1 + 4 - _bassLeading.constant;
     [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_vwBass withRadius:5.0];
    
    
    /*
    drumsBox1 = “2:3”
    StartingPoint = Position 3. 3. 1
    “3” is Bar 3
    “3” is the 3rd place in the Bar3 (2.0)
    EndingPoint = Position 5. 1. 1
    “5” is Bar 5
    “1” is the 1st place in the Bar5 (0.0)
    */
    
    //starting point, "indexPathForItem:2", 2 is for third cell
    NSIndexPath *indexPath4 = [NSIndexPath indexPathForItem:2 inSection:0];
    
    UICollectionViewLayoutAttributes *layoutAttribute2 = [collLayout layoutAttributesForItemAtIndexPath:indexPath4];
    CGRect cellRect4 = layoutAttribute2.frame;
    _drumLeading.constant = cellRect4.origin.x + (cellRect4.size.width/6.22)*2 + 4;
    
    
    //ending point, "indexPathForItem:4", 4 is for fifth cell
    NSIndexPath *indexPath5 = [NSIndexPath indexPathForItem:4 inSection:0];
    
    UICollectionViewLayoutAttributes *layoutAttribute3 = [collLayout layoutAttributesForItemAtIndexPath:indexPath5];
    CGRect cellRect5 = layoutAttribute3.frame;
    _drumWidth.constant =  cellRect5.origin.x + (cellRect4.size.width/6.22)*0 + 4 - _drumLeading.constant;
    [Constant setBorderWithColor:Secondary_Color width:0.5 toView:_vwDrum withRadius:5.0];
    [self.view layoutIfNeeded];
    
    
}



#pragma mark - UIPickerView Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _pickerRatios) {
        if (_btnRatio.isSelected) {
            return arrRatios_.count;
        } else {
            return arrOther_.count;
        }
    } else if (pickerView == _pickerNumbers) {
        return arrNumbers_.count;
    }
    return arrImages_.count;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if (pickerView == _pickerRatios || pickerView == _pickerNumbers) {
           UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:21.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = Secondary_Color;
        if (pickerView == _pickerRatios) {
            if (_btnRatio.isSelected) {
                label.text = arrRatios_[row];
            } else {
                 label.text = arrOther_[row];
            }
        } else {
            label.text = arrNumbers_[row];
        }
        return label ;
    } else {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, pickerView.frame.size.width, 20)];
            imgView.image = arrImages_[row];
            imgView.tintColor = [UIColor whiteColor];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            return  imgView;
    }}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}
#pragma mark - UIScrollView Methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _collView) {
        [_collSongSettingsView setContentOffset:_collView.contentOffset animated:YES];
    }
//    else if (scrollView == _scrlView) {
//        [_collView setContentOffset:_scrlView.contentOffset animated:YES];
//    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == _collView) {
//           // [_scrlView setContentOffset:_collView.contentOffset animated:YES];
//        } else if (scrollView == _scrlView) {
//            [_collView setContentOffset:_scrlView.contentOffset animated:YES];
//        }
//}

#pragma mark - UICollectionView Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (arrChords_.count%4 != 0) {
        return [arrChords_ count]+1;
    }
    return [arrChords_ count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChordCollectionCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if ( IDIOM == IPAD ) {
        cell.vwLargeChordWidth.constant = cell.frame.size.width/2.5;
        cell.vwSmallChordWidth.constant = cell.frame.size.width/5;
    } else {
        cell.vwLargeChordWidth.constant = cell.frame.size.width/3.11;
        cell.vwSmallChordWidth.constant = cell.frame.size.width/6.22;
    }
    if (indexPath.row == arrChords_.count && arrChords_.count%4 != 0) {
        [cell.vwChord1 setHidden:YES];
        [cell.vwChord2 setHidden:YES];
        [cell.vwChord3 setHidden:YES];
        [cell.vwChord4 setHidden:YES];
        [cell.vwChord01 setHidden:YES];
        [cell.vwChord02 setHidden:YES];
        [cell.lblLastChordLine setHidden:YES];
    } else {
//        if ((indexPath.row+1)%4 == 0) {
//            [cell.lblLastChordLine setHidden:NO];
//        } else {
            [cell.lblLastChordLine setHidden:YES];
      //  }
        NSArray* arr = [arrChords_[indexPath.row] componentsSeparatedByString:@"chord"];
        
        
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
    
//    CGFloat height = 0.0;
//    if ( IDIOM == IPAD ) {
//        height = collectionView.frame.size.height/12.5;
//    } else {
//        height = 41;
//    }
  //  return CGSizeMake((collectionView.frame.size.width/5.9)-1, height);
    return CGSizeMake((collectionView.frame.size.width/4), collectionView.frame.size.height);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
  //  return UIEdgeInsetsMake(10, 2, 10, 2);
//}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    //total size - cell content * 4/3
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
   // return (collectionView.frame.size.width - ((collectionView.frame.size.width/5.9)*4))/3;
    return 0.0;
}







@end
