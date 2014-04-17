//
//  FirstViewController.m
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-28.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import "MyAppsViewController.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"

@implementation MyAppsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"APPS";
        self.tabBarItem.image = [UIImage imageNamed:@"appsTabImage"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *file = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"]];
    
    nowAvailable = [[NSArray alloc] initWithArray:[file objectForKey:@"Now Available"]];
    comingSoon = [[NSArray alloc] initWithArray:[file objectForKey:@"Coming Soon"]];
    inDevelopment = [[NSArray alloc] initWithArray:[file objectForKey:@"In Development"]];
    
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.backgroundView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Now Available";
    }
    else if (section == 1)
    {
        return @"Coming Soon";
    }
    else
    {
        return @"In Development";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [nowAvailable count];
    }
    else if (section == 1)
    {
        return [comingSoon count];
    }
    else
    {
        return [inDevelopment count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]])
    {
        cell.backgroundView = [[CustomCellBackground alloc] init];
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]])
    {
        cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    }
    
    NSDictionary *entry;
    
    if (indexPath.section == 0)
    {
        entry = [nowAvailable objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        entry = [comingSoon objectAtIndex:indexPath.row];
    }
    else
    {
        entry = [inDevelopment objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [entry objectForKey:@"title"];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    cell.imageView.image = [UIImage imageNamed:[entry objectForKey:@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[nowAvailable objectAtIndex:indexPath.row] objectForKey:@"link"]]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CustomHeader *header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    if (section == 1)
    {
        header.lightColor = [UIColor colorWithRed:0.60 green:0.40 blue:0.85 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:0.30 green:0.1 blue:0.55 alpha:1.0];
    }
    else if (section == 2)
    {
        header.lightColor = [UIColor orangeColor];
        header.darkColor = [UIColor redColor];
    }
    
    return header;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [myTableView reloadData];
}

@end
