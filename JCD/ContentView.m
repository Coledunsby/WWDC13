//
//  ContentView.m
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-30.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import "ContentView.h"
#import "Common.h"
#import <QuartzCore/QuartzCore.h>

@implementation ContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *whiteColor = [UIColor whiteColor];
    UIColor *lightGrayColor = [UIColor lightGrayColor];
    
    CGRect paperRect = self.bounds;
    
    drawLinearGradient(context, paperRect, whiteColor.CGColor, lightGrayColor.CGColor);
}

@end
