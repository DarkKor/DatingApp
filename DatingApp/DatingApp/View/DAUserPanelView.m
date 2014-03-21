//
//  DAUserPanelView.m
//  DatingApp
//
//  Created by Dmitry Korolchenko on 20/03/14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import "DAUserPanelView.h"
#import "AppHelper.h"

@implementation DAUserPanelView
{
    CGPoint btnAvatarPoint;
    CGPoint imgAvatarPoint;
    
    __strong NSMutableArray *premiumFrames;
    __strong NSMutableArray *invertedPremiumFrames;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        NSLog(@"init from xib");
        
        premiumFrames = [[NSMutableArray alloc] init];
        invertedPremiumFrames = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 144; i++)
        {
            NSString *name = [NSString stringWithFormat:@"premium_animation_%d.png", 145 - i];
            NSLog(@"name = %@", name);
            UIImage *image = [UIImage imageNamed:name];
            [premiumFrames addObject:image];
        }
        
        invertedPremiumFrames = premiumFrames;
        
        /*
        for (int i = 143; i >= 0; i--)
        {
            [invertedPremiumFrames addObject:premiumFrames[i]];
        }
         */
        
        self.imgAnimation.animationRepeatCount = 1;
        self.imgAnimation.image = premiumFrames[0];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (DAUserPanelView *)create
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"DAUserPanelView" owner:nil options:nil];
    for (id obj in arr)
        if ([obj isKindOfClass:[self class]])
        {
            DAUserPanelView *userPanel = (DAUserPanelView *)obj;
            userPanel.vAvatar.layer.mask = [AppHelper roundMaskByView:userPanel.imgAvatar
                                                                 margin:3];
            userPanel.currentIndex = 0;
            return userPanel;
        }
    return nil;
}

- (void)premiumAnimation:(void(^)())didFinish
{
    self.imgAnimation.hidden = NO;
    self.imgAnimation.animationImages = premiumFrames;
    self.imgAnimation.animationDuration = 5.0;
    [self.imgAnimation startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.imgAnimation stopAnimating];
        self.imgAnimation.hidden = YES;
        if (didFinish != nil)
            didFinish();
    });
}

- (void)startAnimate:(void(^)())didFinish
{
    btnAvatarPoint = self.btnAvatar.center;
    imgAvatarPoint = self.vAvatar.center;
    
    CGPoint offset = CGPointMake(imgAvatarPoint.x - btnAvatarPoint.x,
                                 imgAvatarPoint.y - btnAvatarPoint.y);
    
    self.btnAvatar.center = CGPointMake(self.frame.size.width / 2,
                                        btnAvatarPoint.y);
    self.vAvatar.center = CGPointMake(self.frame.size.width / 2 + offset.x,
                                        imgAvatarPoint.y);
    self.container.alpha = 0;
    self.cursor.alpha = 0;
    CATransform3D transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
    transform = CATransform3DConcat(transform, CATransform3DMakeRotation(M_PI_4, 0, 0, 1));
    self.imgAvatar.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
    self.imgAvatar.layer.transform = transform;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         CATransform3D transform = self.imgAvatar.layer.transform;
                         transform = CATransform3DConcat(transform, CATransform3DMakeRotation(-M_PI_4, 0, 0, 1));
                         self.imgAvatar.layer.transform = transform;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              self.imgAvatar.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
                                          } completion:^(BOOL finished) {
                                              [self showPanel:didFinish];
                                          }];
                     }];
}

- (void)showPanel:(void(^)())didFinish
{
    CGRect rect = self.container.frame;
    rect.origin.x += 120;
    rect.size.width -= 120 + 90;
    self.container.frame = rect;
    self.btnChat.alpha = self.btnLike.alpha = self.btnLook.alpha = self.btnPeople.alpha = 0;
    self.container.alpha = 1.0;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.vAvatar.center = imgAvatarPoint;
                         self.btnAvatar.center = btnAvatarPoint;
                         
                         CGRect rect = self.container.frame;
                         rect.origin.x -= 120;
                         rect.size.width += 120 + 90;
                         self.container.frame = rect;
                     } completion:^(BOOL finished) {
                         [self showButtons:didFinish];
                     }];
}

- (void)showButtons:(void(^)())didFinish
{
    [self showButton:self.btnChat didFinish:^{
        [self showButton:self.btnLike didFinish:^{
            [self showButton:self.btnLook didFinish:^{
                [self showButton:self.btnPeople didFinish:^{
                    self.currentIndex = 0;
                    self.cursor.alpha = 0;
                    [self jumpCursor:didFinish];
                }];
            }];
        }];
    }];
}

- (void)showButton:(UIButton *)btn didFinish:(void(^)())didFinish
{
    btn.alpha = 0.0;
    btn.layer.transform = CATransform3DMakeScale(0.2, 0.2, 0.2);
    [UIView animateWithDuration:0.02 animations:^{
        btn.alpha = 1.0;
        btn.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            btn.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
        } completion:^(BOOL finished) {
            didFinish();
        }];
    }];
}

- (IBAction)btn_Click:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self setCurrentIndex:btn.tag animated:YES];
}

- (void)setCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated
{
    CGRect rect = self.cursor.frame;
    rect.origin.x = [self centerForIndex:self.currentIndex] - rect.size.width / 2;
    self.cursor.frame = rect;
    self.currentIndex = currentIndex;
    [UIView animateWithDuration:0.1
                     animations:^{
                         CGRect rect = self.cursor.frame;
                         rect.origin.x = [self centerForIndex:self.currentIndex];
                         self.cursor.frame = rect;

                     } completion:^(BOOL finished) {
                         
                     }];
}

- (CGFloat)centerForIndex:(NSInteger)index
{
    if (index == 0)
        return self.btnPeople.center.x;
    if (index == 1)
        return self.btnLook.center.x;
    if (index == 2)
        return self.btnLike.center.x;
    if (index == 3)
        return self.btnChat.center.x;
    
    return 0;
}

- (void)jumpCursor:(void(^)())didFinish
{
    CGRect rect = self.cursor.frame;
    rect.origin.x = [self centerForIndex:self.currentIndex];
    self.cursor.frame = rect;
    CGFloat y = rect.origin.y;
    [UIView animateWithDuration:0.1
                     animations:^{
                         self.cursor.alpha = 1.0;
                         CGRect r = self.cursor.frame;
                         r.origin.y += 25;
                         self.cursor.frame = r;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              self.cursor.alpha = 1.0;
                                              CGRect r = self.cursor.frame;
                                              r.origin.y = y - 10;
                                              self.cursor.frame = r;
                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.1
                                                               animations:^{
                                                                   self.cursor.alpha = 1.0;
                                                                   CGRect r = self.cursor.frame;
                                                                   r.origin.y = y + 5;
                                                                   self.cursor.frame = r;
                                                               } completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:0.1
                                                                                    animations:^{
                                                                                        self.cursor.alpha = 1.0;
                                                                                        CGRect r = self.cursor.frame;
                                                                                        r.origin.y = y;
                                                                                        self.cursor.frame = r;
                                                                                    } completion:^(BOOL finished) {
                                                                                        didFinish();
                                                                                    }];

                                                               }];

                                          }];
                     }];
}

@end
