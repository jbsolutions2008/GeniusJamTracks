//
//  ChordCollectionCell.h
//  GeniusJamTracks
//
//   22/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChordCollectionCell : UICollectionViewCell

//These are the views when =<2 chords need to be shown
@property (nonatomic, strong) IBOutlet UIView *vwChord01;
@property (nonatomic, strong) IBOutlet UIView *vwChord02;

@property (nonatomic, strong) IBOutlet UILabel *lblRoot01;
@property (nonatomic, strong) IBOutlet UILabel *lblRoot02;

@property (nonatomic, strong) IBOutlet UILabel *lblTypeA01;
@property (nonatomic, strong) IBOutlet UILabel *lblTypeA02;

@property (nonatomic, strong) IBOutlet UILabel *lblTypeB01;
@property (nonatomic, strong) IBOutlet UILabel *lblTypeB02;

@property (nonatomic, strong) IBOutlet UILabel *lblAccidental01;
@property (nonatomic, strong) IBOutlet UILabel *lblAccidental02;

@property (nonatomic, strong) IBOutlet UILabel *lblExtended01;
@property (nonatomic, strong) IBOutlet UILabel *lblExtended02;


//These are the views when >2 chords needs to be shown
@property (nonatomic, strong) IBOutlet UIView *vwChord1;
@property (nonatomic, strong) IBOutlet UIView *vwChord2;
@property (nonatomic, strong) IBOutlet UIView *vwChord3;
@property (nonatomic, strong) IBOutlet UIView *vwChord4;

@property (nonatomic, strong) IBOutlet UILabel *lblSequence;

@property (nonatomic, strong) IBOutlet UILabel *lblRoot1;
@property (nonatomic, strong) IBOutlet UILabel *lblRoot2;
@property (nonatomic, strong) IBOutlet UILabel *lblRoot3;
@property (nonatomic, strong) IBOutlet UILabel *lblRoot4;

@property (nonatomic, strong) IBOutlet UILabel *lblTypeB1;
@property (nonatomic, strong) IBOutlet UILabel *lblTypeB2;
@property (nonatomic, strong) IBOutlet UILabel *lblTypeB3;
@property (nonatomic, strong) IBOutlet UILabel *lblTypeB4;

@property (nonatomic, strong) IBOutlet UILabel *lblTypeA1;
@property (nonatomic, strong) IBOutlet UILabel *lblTypeA2;
@property (nonatomic, strong) IBOutlet UILabel *lblTypeA3;
@property (nonatomic, strong) IBOutlet UILabel *lblTypeA4;

@property (nonatomic, strong) IBOutlet UILabel *lblAccidental1;
@property (nonatomic, strong) IBOutlet UILabel *lblAccidental2;
@property (nonatomic, strong) IBOutlet UILabel *lblAccidental3;
@property (nonatomic, strong) IBOutlet UILabel *lblAccidentalt4;

@property (nonatomic, strong) IBOutlet UILabel *lblExtended1;
@property (nonatomic, strong) IBOutlet UILabel *lblExtended2;
@property (nonatomic, strong) IBOutlet UILabel *lblExtended3;
@property (nonatomic, strong) IBOutlet UILabel *lblExtended4;

@property (nonatomic, strong) IBOutlet UILabel *lblLastChordLine;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *vwLargeChordWidth;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *vwSmallChordWidth;

@end



NS_ASSUME_NONNULL_END
