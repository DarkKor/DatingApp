//
//  DAPagingView.m
//  DatingApp
//
//  Created by Alexander Naumenko on 21.03.14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import "DAPagingView.h"

@implementation DAPagingView

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
        UIImage *image = [UIImage imageNamed:@"top_bar_white_marker@2x.png"];
        
        CGFloat h = self.frame.size.height;
        
        h -= 8;
        h /= 3;
        
        for (int i = 0; i < 4; i++)
        {
            UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
            v.image = image;
            v.center = CGPointMake(self.frame.size.width / 2, 1 + 3 + i * h);
            v.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            [self addSubview:v];
            v.alpha = i == 3 ? 1.0 : 0.5;
        }
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

@end
