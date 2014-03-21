//
//  DABottomPanel.m
//  DatingApp
//
//  Created by Alexander Naumenko on 21.03.14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import "DABottomPanel.h"

@implementation DABottomPanel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (DABottomPanel *)create
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"DABottomPanel" owner:nil options:nil];
    for (id obj in arr)
        if ([obj isKindOfClass:[self class]])
        {
            return obj;
        }
    return nil;
}

@end
