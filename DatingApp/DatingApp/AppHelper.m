//
//  AppHelper.m
//  DatingApp
//
//  Created by Alexander Naumenko on 21.03.14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper

+ (CAShapeLayer *)roundMaskByView:(UIView *)aView margin:(CGFloat)radius
{
    CGSize size = aView.frame.size;
    
    //Creating path for clipping
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //Clipping
    [path addArcWithCenter:CGPointMake(size.width / 2, size.height / 2)
                    radius:(MIN(size.width, size.height) / 2) - radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [path CGPath];
    
    return maskLayer;
}

@end
