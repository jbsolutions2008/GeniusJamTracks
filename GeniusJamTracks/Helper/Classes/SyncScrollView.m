//
//  SyncScrollView.m
//  GeniusJamTracks
//
//   on 15/07/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import "SyncScrollView.h"

@implementation SyncScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return YES;

}

@end
