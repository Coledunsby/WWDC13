//
//  ResumeViewController.m
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-29.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import "ResumeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "ContentView.h"
#import "HeaderView.h"

#define HEADER_HEIGHT 40

@implementation ResumeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"RESUME";
        self.tabBarItem.image = [UIImage imageNamed:@"resumeTabImage"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    headers = [[NSMutableArray alloc] init];
    sections = [[NSMutableArray alloc] init];
    cv = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cv" ofType:@"plist"]];
    
    aImageView.layer.borderWidth = 1.0f;
    aImageView.layer.borderColor = [UIColor blackColor].CGColor;
    
    for (int i = 0; i < [[cv objectForKey:@"Headers"] count]; i++)
    {
        [self addSectionWithTitle:[[cv objectForKey:@"Headers"] objectAtIndex:i] andTag:i];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
    [UIView animateWithDuration:duration animations:^
     {
         for (UIView *section in sections)
         {
             section.frame = CGRectMake(section.frame.origin.x, section.frame.origin.y, width - (2 * PADDING), section.frame.size.height);
             
             if ([section.subviews count] >= 2)
             {
                 HeaderView *tempView = [[HeaderView alloc] init];
                 tempView.tag = [[section.subviews objectAtIndex:1] tag];
                 [self handleTap:tempView];
             }
         }
         
         for (UIView *header in headers)
         {
             header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, width - (2 * PADDING), header.frame.size.height);
             
             if (header.subviews.count >= 1)
             {
                 [[header.subviews objectAtIndex:0] setFrame:CGRectMake([[header.subviews objectAtIndex:0] frame].origin.x, [[header.subviews objectAtIndex:0] frame].origin.y, width - (2 * PADDING), [[header.subviews objectAtIndex:0] frame].size.height)];
             }
         }
     }];
    
    aScrollView.contentSize = CGSizeMake(width, aScrollView.contentSize.height);
}

- (void)addSectionWithTitle:(NSString *)title andTag:(int)tag
{
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - (2 * PADDING), HEADER_HEIGHT)];
    headerView.titleLabel.text = title;
    headerView.tag = tag;
    
    UIView *section = [[UIView alloc] init];
    
    if ([sections count] == 0)
    {
        section.frame = CGRectMake(PADDING, PADDING + (aImageView.frame.size.height + 10), self.view.frame.size.width - (2 * PADDING), HEADER_HEIGHT);
    }
    else
    {
        section.frame = CGRectMake(PADDING, [[sections objectAtIndex:[sections count] - 1] frame].origin.y + [[sections objectAtIndex:[sections count] - 1] frame].size.height + PADDING, self.view.frame.size.width - (2 * PADDING), HEADER_HEIGHT);
    }

    [section addSubview:headerView];
    [aScrollView addSubview:section];
    
    [headers addObject:headerView];
    [sections addObject:section];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [headerView addGestureRecognizer:tap];
    
    [self updateScrollViewContentSize];
}

- (void)updateScrollViewContentSize
{
    float height = (([sections count] + 1) * PADDING) + (aImageView.frame.size.height + 10);
    
    for (UIView *section in sections)
    {
        height += section.frame.size.height;
    }
    
    aScrollView.contentSize = CGSizeMake(self.view.frame.size.width, height + 50);
}

- (void)handleTap:(id)sender
{
    int tag;
    
    if ([sender isKindOfClass:[HeaderView class]])
    {
        tag = [sender tag];
    }
    else
    {
        tag = [[sender view] tag];
    }
    
    UIView *section = [sections objectAtIndex:tag];
    id content = [cv objectForKey:[[[[headers objectAtIndex:tag] subviews] objectAtIndex:0] text]];
    CGSize size = CGSizeMake(0, 5);
    
    if ([section.subviews count] <= 1)
    {
        UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, section.frame.size.width, section.frame.size.height)];
        infoView.backgroundColor = [UIColor whiteColor];
        infoView.layer.borderColor = [UIColor blackColor].CGColor;
        infoView.layer.borderWidth = 1.0f;
        infoView.layer.cornerRadius = 5.0f;
        
        ContentView *contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, 0, infoView.frame.size.width, infoView.frame.size.height)];
        contentView.alpha = 0.0;
        
        if ([content isKindOfClass:[NSString class]])
        {
            size = [content sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] constrainedToSize:CGSizeMake(self.view.frame.size.width - (2 * PADDING) - 20, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, contentView.frame.size.width - 20, size.height + 10)];
            contentLabel.text = content;
            contentLabel.backgroundColor = [UIColor clearColor];
            contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
            contentLabel.numberOfLines = 0;
            contentLabel.textColor = [UIColor blackColor];
            contentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
            [contentView addSubview:contentLabel];
            [infoView addSubview:contentView];
        }
        else if ([content isKindOfClass:[NSArray class]])
        {
            if ([[content objectAtIndex:0] isKindOfClass:[NSString class]])
            {
                size = CGSizeMake(0, 5);
                
                for (NSString *string in content)
                {
                    CGSize aSize = [string sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] constrainedToSize:CGSizeMake(self.view.frame.size.width - (2 * PADDING) - 20, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
                    
                    UILabel *contentLabel;
                    
                    if ([[[[[headers objectAtIndex:tag] subviews] objectAtIndex:0] text] isEqualToString:@"Citizenship"])
                    {
                        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, size.height, contentView.frame.size.width - 20, aSize.height)];
                        
                        UIImageView *imageView;
                        
                        if ([content indexOfObject:string] == 0)
                        {
                            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UnitedStatesFlag"]];
                        }
                        else
                        {
                            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CanadaFlag"]];
                        }
                        
                        imageView.frame = CGRectMake(10, contentLabel.frame.origin.y, 16, 16);
                        [contentView addSubview:imageView];

                        contentLabel.text = string;
                    }
                    else
                    {
                        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, size.height, contentView.frame.size.width - 20, aSize.height)];
                        contentLabel.text = [NSString stringWithFormat:@" › %@", string];
                    }
                    
                    size = CGSizeMake(size.width, aSize.height + size.height);
                    
                    contentLabel.backgroundColor = [UIColor clearColor];
                    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    contentLabel.numberOfLines = 0;
                    contentLabel.textColor = [UIColor blackColor];
                    contentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
                    [contentView addSubview:contentLabel];
                    [infoView addSubview:contentView];
                }
            }
            else
            {
                size = CGSizeMake(0, 10);
                
                for (NSArray *array in content)
                {
                    for (int i = 0; i < [array count]; i++)
                    {
                        NSString *string = [array objectAtIndex:i];
                        
                        CGSize aSize = [string sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] constrainedToSize:CGSizeMake(self.view.frame.size.width - (2 * PADDING) - 20, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
                        
                        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, size.height, contentView.frame.size.width - 20, aSize.height)];
                        
                        size = CGSizeMake(size.width, aSize.height + size.height);
                        
                        contentLabel.text = string;
                        contentLabel.backgroundColor = [UIColor clearColor];
                        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
                        contentLabel.numberOfLines = 0;
                        contentLabel.textColor = [UIColor blackColor];
                        contentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
                        [contentView addSubview:contentLabel];
                        [infoView addSubview:contentView];
                    }
                    
                    size = CGSizeMake(size.width, 15 + size.height);
                }
                
                size = CGSizeMake(size.width, size.height - 10);
            }
        }
        
        [section addSubview:infoView];
        [section bringSubviewToFront:[section.subviews objectAtIndex:0]];
        
        [UIView animateWithDuration:ANIMATION_SPEED
                         animations:^
         {
             section.frame = CGRectMake(section.frame.origin.x, section.frame.origin.y, section.frame.size.width, section.frame.size.height + size.height + 10);
             infoView.frame = CGRectMake(0, 0, section.frame.size.width, section.frame.size.height);
             contentView.frame = CGRectMake(0, HEADER_HEIGHT, infoView.frame.size.width, size.height + 10);
             contentView.alpha = 1.0;
             
             for (int i = tag + 1; i < [sections count]; i++)
             {
                 UIView *section = [sections objectAtIndex:i];
                 [[sections objectAtIndex:i] setCenter:CGPointMake(section.center.x, section.center.y + (size.height + 10))];
             }
         }
                         completion:^(BOOL finished)
         {
             [self updateScrollViewContentSize];
         }];
    }
    else
    {
        if ([content isKindOfClass:[NSString class]])
        {
            size = [content sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] constrainedToSize:CGSizeMake(self.view.frame.size.width - (2 * PADDING) - 20, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        }
        else if ([content isKindOfClass:[NSArray class]])
        {
            if ([[content objectAtIndex:0] isKindOfClass:[NSString class]])
            {
                size = CGSizeMake(0, 5);
                
                for (NSString *string in content)
                {
                    CGSize aSize = [string sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] constrainedToSize:CGSizeMake(self.view.frame.size.width - (2 * PADDING) - 20, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
                    size = CGSizeMake(size.width, aSize.height + size.height);
                }
            }
            else
            {
                size = CGSizeMake(0, 10);
                
                for (NSArray *array in content)
                {
                    for (int i = 0; i < [array count]; i++)
                    {
                        NSString *string = [array objectAtIndex:i];
                        
                        CGSize aSize = [string sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] constrainedToSize:CGSizeMake(self.view.frame.size.width - (2 * PADDING) - 20, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];

                        size = CGSizeMake(size.width, aSize.height + size.height);
                    }
                    
                    size = CGSizeMake(size.width, 15 + size.height);
                }
                
                size = CGSizeMake(size.width, size.height - 10);
            }
        }
        
        UIView *infoView = [section.subviews objectAtIndex:0];
        ContentView *contentView = [infoView.subviews objectAtIndex:0];
        
        [UIView animateWithDuration:ANIMATION_SPEED
                         animations:^
         {
             for (int i = tag + 1; i < [sections count]; i++)
             {
                 UIView *section = [sections objectAtIndex:i];
                 [[sections objectAtIndex:i] setCenter:CGPointMake(section.center.x, section.center.y - (size.height + 10))];
             }
             
             section.frame = CGRectMake(section.frame.origin.x, section.frame.origin.y, section.frame.size.width, HEADER_HEIGHT);
             
             contentView.frame = CGRectMake(0, 0, section.frame.size.width, HEADER_HEIGHT);
             contentView.alpha = 0.0;
             
             infoView.frame = CGRectMake(0, 0, section.frame.size.width, section.frame.size.height);
         }
                         completion:^(BOOL finished)
         {
             [contentView removeFromSuperview];
             [infoView removeFromSuperview];
             [self updateScrollViewContentSize];
         }];
    }
}

- (IBAction)call:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"+1 (514) 867-2653" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call", @"Text", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Call"])
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unavailable" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://+15148672653"]];
        }
    }
    else if ([buttonTitle isEqualToString:@"Text"])
    {
        if([MFMessageComposeViewController canSendText])
        {
            MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
            controller.body = @"";
            controller.recipients = [NSArray arrayWithObjects:@"+15148672653", nil];
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unavailable" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        NSLog(@"Cancel Pressed");
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultFailed)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unknown Error" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendEmail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setToRecipients:[NSArray arrayWithObject:@"coledunsby@gmail.com"]];
        [mailViewController setSubject:@""];
        [mailViewController setMessageBody:@"" isHTML:NO];
        [self presentViewController:mailViewController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unavailable" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)openAddress:(id)sender
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(45.64851,-73.79364);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:location addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    item.name = @"516 rue de l'Érabliere, Rosemère (QC) J7A 4L3";
    [item openInMapsWithLaunchOptions:nil];
}

@end
