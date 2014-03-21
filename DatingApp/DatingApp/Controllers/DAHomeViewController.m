//
//  DAHomeViewController.m
//  DatingApp
//
//  Created by Dmitry Korolchenko on 20/03/14.
//  Copyright (c) 2014 GrowApp Solutions. All rights reserved.
//

#import "DAHomeViewController.h"

@interface DAHomeViewController ()

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSArray *bluredPhotos;

@end

@implementation DAHomeViewController

@synthesize photos;
@synthesize bluredPhotos;
@synthesize carousel;

- (UIImage *)emptyImage
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    
    return UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

- (void)awakeFromNib
{
    self.photos = @[[self emptyImage],
                    [UIImage imageNamed:@"1.jpg"],
                    [UIImage imageNamed:@"2.jpg"],
                    [UIImage imageNamed:@"3.jpg"],
                    [UIImage imageNamed:@"4.jpg"],
                    [UIImage imageNamed:@"5.jpg"]
                    ];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (UIImage *img in self.photos)
    {
        UIImage *bl = [img applyDarkEffect];
        [arr addObject:bl];
    }
    
    self.bluredPhotos = arr;
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
    
    
    
    carousel.type = iCarouselTypeCustom;
    carousel.bounces = NO;
    [carousel reloadData];
    
    [carousel scrollToItemAtIndex:1 animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.83 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.photos = [self.photos subarrayWithRange:NSMakeRange(1, self.photos.count - 1)];
        self.bluredPhotos = [self.bluredPhotos subarrayWithRange:NSMakeRange(1, self.bluredPhotos.count - 1)];
        carousel.currentItemIndex = 0;
        [carousel reloadData];
    });
    
    CGRect rect = self.paging.frame;
    CGPoint center = self.paging.center;
    rect.size.height = 300;
    rect.origin.y = center.y - rect.size.height / 2;
    self.paging.frame = rect;
    
    [UIView animateWithDuration:0.8
                     animations:^{
                         CGRect rect = self.paging.frame;
                         CGPoint center = self.paging.center;
                         rect.size.height = 50;
                         rect.origin.y = center.y - rect.size.height / 2;
                         self.paging.frame = rect;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - iCarousel Delegate and Datasourse

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [photos count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIImage *image = self.photos[index];
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270.0f, 270.0f)];
        ((UIImageView *)view).image = [image isKindOfClass:[NSNull class]] ? nil : image;
        view.layer.cornerRadius = 3;
        view.clipsToBounds = YES;
    }
    else
    {
        //get a reference to the label in the recycled view
        ((UIImageView *)view).image = [image isKindOfClass:[NSNull class]] ? nil : image;
    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
        return 1.05;
    if (option == iCarouselOptionShowBackfaces)
        return NO;
    else
        return value;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    if (offset > 0)
    {
        if (offset > 3)
        {
            return CATransform3DTranslate(transform, 0.0f, 1000.0f, 0.0f);
        }
        
        CGFloat count = 5;
        CGFloat spacing = 1.05;
        CGFloat arc = M_PI * 2.0f;
        CGFloat radius = fmaxf(0.01f, 270 * spacing / 2.0f / tanf(arc/2.0f/count));
        CGFloat angle = offset / count * arc;
        
        radius = -radius;
        angle = -angle;
        
        transform = CATransform3DTranslate(transform, 0.0f, 0.0f, -radius);
        transform = CATransform3DRotate(transform, angle, 0.0f, 1.0f, 0.0f);
        return CATransform3DTranslate(transform, 0.0f, 0.0f, radius + 0.01f);
    }
    else
    {
        CGFloat count = 20;
        CGFloat spacing = 1.05;
        CGFloat arc = M_PI * 2.0f;
        CGFloat radius = fmaxf(0.01f, 270 * spacing / 2.0f / tanf(arc/2.0f/count));
        CGFloat angle = offset / 5 * arc;
        
        radius = -radius;
        angle = -angle;
        transform = CATransform3DTranslate(transform, offset * 270 * spacing, 0.0f, 0.0f);
        transform = CATransform3DRotate(transform, -angle * 0.2, 0.0f, 1.0f, 0.0f);
        
        return transform;
    }
}

- (void)changeTransformForItem:(NSInteger)index withOffset:(CGFloat)offset
{
    if (offset <= 1 && offset > -1)
    {
        if (offset <= 0)
        {
            CGFloat val = 1 + offset;
            self.imgBack1.alpha = val;
            self.imgBack1.image = self.bluredPhotos[index];
            NSLog(@"alfa 1 = %.2f", val);
        }
        else
        {
            CGFloat val = 1 - offset;
            self.imgBack2.alpha = val;
            self.imgBack2.image = self.bluredPhotos[index];
            NSLog(@"alfa 2 = %.2f", val);

        }
    }
}

@end
