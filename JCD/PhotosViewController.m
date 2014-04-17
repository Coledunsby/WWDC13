//
//  PhotosViewController.m
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-30.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import "PhotosViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation PhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"PHOTOS";
        self.tabBarItem.image = [UIImage imageNamed:@"imagesTabImage"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    images = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"]];
    imageViews = [[NSMutableArray alloc] init];
    
    CGPoint center;
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
        center = CGPointMake([UIScreen mainScreen].bounds.size.height / 2, [UIScreen mainScreen].bounds.size.width / 2);
    }
    else
    {
        center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    }
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(0.0, 0.0, 37.0, 37.0);
    activityIndicator.color = [UIColor blackColor];
    activityIndicator.center = center;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([imageViews count] == 0)
    {
        [self loadImages];
        [self resizeScrollView];
        
        if (activityIndicator)
        {
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
            activityIndicator = nil;
        }
    }
    
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:ANIMATION_SPEED];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{    
    float width;
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    else
    {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    
    [UIView animateWithDuration:duration animations:^
     {
         for (UIImageView *imageView in imageViews)
         {
             imageView.center = CGPointMake(width / 2, imageView.center.y);
         }
     }];
    
    aScrollView.contentSize = CGSizeMake(width, aScrollView.contentSize.height);
}

- (void)loadImages
{
    float smallestSide = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    for (NSDictionary *dictionary in images)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[dictionary objectForKey:@"image"]]];
        float ratio = imageView.image.size.height / imageView.image.size.width;
        
        if ([imageViews count] == 0)
        {
            float width = smallestSide - (2 * PADDING);
            imageView.frame = CGRectMake(PADDING, PADDING, width, width * ratio);
        }
        else
        {
            float height = ([imageViews count] + 1) * PADDING;
            float width = smallestSide - (2 * PADDING);
            
            for (UIImageView *aImageView in imageViews)
            {
                float aRatio = aImageView.image.size.height / aImageView.image.size.width;
                float aWidth = smallestSide - (2 * PADDING);
                height += (aWidth * aRatio);
            }
            
            imageView.frame = CGRectMake(PADDING, height, width, width * ratio);
        }
        
        UILabel *captionLabel = [[UILabel alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            captionLabel.frame = CGRectMake(0, imageView.frame.size.height - 40, imageView.frame.size.width, 40);
            captionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        }
        else
        {
            captionLabel.frame = CGRectMake(0, imageView.frame.size.height - 20, imageView.frame.size.width, 20);
            captionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        }
        
        captionLabel.text = [NSString stringWithFormat:@" %@", [dictionary objectForKey:@"caption"]];
        captionLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        captionLabel.textColor = [UIColor whiteColor];
        [imageView addSubview:captionLabel];
        
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.layer.borderWidth = 1.0;
        
        [imageViews addObject:imageView];
        [aScrollView addSubview:imageView];
    }
}

- (void)resizeScrollView
{
    float height = ([imageViews count] + 1) * PADDING;
    
    for (UIImageView *imageView in imageViews)
    {
        height += imageView.frame.size.height;
    }
    
    aScrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
