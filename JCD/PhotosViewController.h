//
//  PhotosViewController.h
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-30.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosViewController : UIViewController
{
    IBOutlet UIScrollView *aScrollView;
    
    NSArray *images;
    NSMutableArray *imageViews;
    
    UIActivityIndicatorView *activityIndicator;
}

@end
