//
//  CustomVC.h
//  GeniusJamTracks
//
//   18/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface CustomVC : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic) NSMutableDictionary *dictSong;

@end

NS_ASSUME_NONNULL_END
