//
//  DAViewController.m
//  DatingApp
//
//  Created by Dmitry Korolchenko on 20/03/14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import "DAViewController.h"

@interface DAViewController ()

@end

@implementation DAViewController

+ (id)create {
    //  Get view controller ID: it is always it's unique part of name, e.g.: DAHomeViewController => homeID
    NSString *className = NSStringFromClass([self class]);
    NSString *viewControllerID = [className substringToIndex:[className rangeOfString:@"View"].location];
    viewControllerID = [[viewControllerID.lowercaseString substringFromIndex:2] stringByAppendingString:@"ID"];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    return [mainStoryboard instantiateViewControllerWithIdentifier:viewControllerID];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
