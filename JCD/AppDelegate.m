//
//  AppDelegate.m
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-28.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import "AppDelegate.h"
#import "MyAppsViewController.h"
#import "HomeViewController.h"
#import "ResumeViewController.h"
#import "PhotosViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *myAppsViewController;
    UIViewController *homeViewController;
    UIViewController *resumeViewController;
    UIViewController *photosViewController;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        myAppsViewController = [[MyAppsViewController alloc] initWithNibName:@"MyAppsViewController_iPhone" bundle:nil];
        homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPhone" bundle:nil];
        resumeViewController = [[ResumeViewController alloc] initWithNibName:@"ResumeViewController_iPhone" bundle:nil];
        photosViewController = [[PhotosViewController alloc] initWithNibName:@"PhotosViewController_iPhone" bundle:nil];
    }
    else
    {
        myAppsViewController = [[MyAppsViewController alloc] initWithNibName:@"MyAppsViewController_iPad" bundle:nil];
        homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPad" bundle:nil];
        resumeViewController = [[ResumeViewController alloc] initWithNibName:@"ResumeViewController_iPad" bundle:nil];
        photosViewController = [[PhotosViewController alloc] initWithNibName:@"PhotosViewController_iPad" bundle:nil];
    }
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[homeViewController, resumeViewController, photosViewController, myAppsViewController];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
