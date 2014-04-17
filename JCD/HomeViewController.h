//
//  SecondViewController.h
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-28.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
{
    IBOutlet UIScrollView *aScrollView;
    IBOutlet UIView *contentView;
}

- (IBAction)openWebsite:(id)sender;

@end
