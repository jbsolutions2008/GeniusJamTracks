//
//  SettingsTableCell.h
//  GeniusJamTracks
//
//   29/04/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UIImageView *imgArrow;
@property (nonatomic, strong) IBOutlet UILabel *lblValue;

@end

NS_ASSUME_NONNULL_END
