//
//  SecondViewController.m
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-28.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.title = @"HOME";
        self.tabBarItem.image = [UIImage imageNamed:@"homeTabImage"];
    }
    
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aScrollView.alpha = 0.0;
    
    [UIView animateWithDuration:ANIMATION_SPEED animations:^
     {
         aScrollView.alpha = 1.0;
     }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:ANIMATION_SPEED];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    aScrollView.contentSize = CGSizeMake(width, contentView.frame.size.height);
}

- (IBAction)openWebsite:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://jcdigitalapps.wordpress.com"]];
}

@end
