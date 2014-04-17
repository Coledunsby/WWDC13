//
//  ResumeViewController.h
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-29.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ResumeViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>
{
    IBOutlet UIScrollView *aScrollView;
    IBOutlet UIImageView *aImageView;
    
    NSMutableArray *headers;
    NSMutableArray *sections;
    NSDictionary *cv;
}

- (IBAction)call:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)openAddress:(id)sender;

@end
