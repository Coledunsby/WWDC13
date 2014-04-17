//
//  FirstViewController.h
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-28.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAppsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    
    NSArray *nowAvailable;
    NSArray *comingSoon;
    NSArray *inDevelopment;
}

@end
