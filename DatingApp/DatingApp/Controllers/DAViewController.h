//
//  DAViewController.h
//  DatingApp
//
//  Created by Dmitry Korolchenko on 20/03/14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

//iPhone 5
#ifndef IS_IPHONE_5
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)

//iOS 7
#define isiOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.9)
#endif

@interface DAViewController : UIViewController

+ (id)create;

@end
