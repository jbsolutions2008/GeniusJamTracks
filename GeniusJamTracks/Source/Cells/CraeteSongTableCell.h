//
//  CraeteSongTableCell.h
//  GeniusJamTracks
//
//    13/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CraeteSongTableCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UILabel *lblTrioName;
@property (nonatomic, strong) IBOutlet UILabel *lblDesc;
@property (nonatomic, strong) IBOutlet UIImageView *vwShadow;
@end

NS_ASSUME_NONNULL_END
