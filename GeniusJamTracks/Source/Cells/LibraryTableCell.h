//
//  LibraryTableCell.h
//  GeniusJamTracks
//
//   24/04/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LibraryTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet UILabel *lblDesc;

@end

NS_ASSUME_NONNULL_END
