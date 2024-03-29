//
//  DAHomeViewController.h
//  DatingApp
//
//  Created by Dmitry Korolchenko on 20/03/14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAViewController.h"
#import "iCarousel.h"
#import "UIImage+ImageEffects.h"
#import "DAPagingView.h"
#import "DAUserPanelView.h"
#import "DABottomPanel.h"

@interface DAHomeViewController : DAViewController <iCarouselDataSource, iCarouselDelegate>
{
    iCarousel *carousel;
}

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@property (nonatomic, strong) IBOutlet UIImageView *imgBack1;
@property (nonatomic, strong) IBOutlet UIImageView *imgBack2;
@property (nonatomic, strong) IBOutlet DAPagingView *paging;
@property (nonatomic, strong) IBOutlet DAUserPanelView *notificationPanel;
@property (nonatomic, strong) IBOutlet DABottomPanel *bottomPanel;
@property (nonatomic) IBOutlet UILabel *lblHi;

@end
