//
//  SongChordsVC.h
//  GeniusJamTracks
//
//   13/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomVC.h"

NS_ASSUME_NONNULL_BEGIN



@interface SongChordsVC : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>
@property (nonatomic) NSMutableDictionary *dictSelectedSong;

@end

NS_ASSUME_NONNULL_END
