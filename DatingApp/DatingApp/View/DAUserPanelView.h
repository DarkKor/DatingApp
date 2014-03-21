//
//  DAUserPanelView.h
//  DatingApp
//
//  Created by Dmitry Korolchenko on 20/03/14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAUserPanelView : UIView

@property (nonatomic) IBOutlet UIButton *btnPeople;
@property (nonatomic) IBOutlet UIButton *btnLook;
@property (nonatomic) IBOutlet UIButton *btnLike;
@property (nonatomic) IBOutlet UIButton *btnChat;
@property (nonatomic) IBOutlet UIButton *btnAvatar;
@property (nonatomic) IBOutlet UIImageView *imgAvatar;
@property (nonatomic) IBOutlet UIView *vAvatar;
@property (nonatomic) IBOutlet UIView *container;
@property (nonatomic) IBOutlet UIView *cursor;

@property (nonatomic, assign) NSInteger currentIndex;

+ (DAUserPanelView *)create;
- (void)startAnimate:(void(^)())didFinish;

@end
