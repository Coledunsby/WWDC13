//
//  CustomHeader.m
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-30.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import "CustomHeader.h"
#import "Common.h"

@interface CustomHeader()

@property (nonatomic, assign) CGRect coloredBoxRect;
@property (nonatomic, assign) CGRect paperRect;

@end

@implementation CustomHeader

@synthesize titleLabel, darkColor, lightColor;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.opaque = NO;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        titleLabel.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:titleLabel];
        
        lightColor = [UIColor colorWithRed:0.40 green:0.70 blue:0.85 alpha:1.0];
        darkColor = [UIColor colorWithRed:0.10 green:0.35 blue:0.50 alpha:1.0];
    }
    return self;
}

- (void)layoutSubviews
{    
    CGFloat coloredBoxMargin = 6.0;
    CGFloat sideMargin;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        sideMargin = 30.0;
    }
    else
    {
        sideMargin = 6.0;
    }
    
    CGFloat coloredBoxHeight = 40.0;
    self.coloredBoxRect = CGRectMake(sideMargin, coloredBoxMargin, self.bounds.size.width-sideMargin*2, coloredBoxHeight);
    
    CGFloat paperMargin;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        paperMargin = 44.0;
    }
    else
    {
        paperMargin = 9.0;
    }
    
    self.paperRect = CGRectMake(paperMargin, CGRectGetMaxY(self.coloredBoxRect), self.bounds.size.width-paperMargin*2, self.bounds.size.height-CGRectGetMaxY(self.coloredBoxRect));
    
    self.titleLabel.frame = self.coloredBoxRect;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    UIColor *shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    CGContextSetFillColorWithColor(context, whiteColor.CGColor);
    CGContextFillRect(context, _paperRect);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
    CGContextSetFillColorWithColor(context, self.lightColor.CGColor);
    CGContextFillRect(context, self.coloredBoxRect);
    CGContextRestoreGState(context);
    drawGlossAndGradient(context, self.coloredBoxRect, self.lightColor.CGColor, self.darkColor.CGColor);
    
    CGContextSetStrokeColorWithColor(context, self.darkColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, rectFor1PxStroke(self.coloredBoxRect));
}

@end
