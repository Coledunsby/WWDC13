//
//  HeaderView.m
//  JCD
//
//  Created by James-Cole Dunsby on 2013-04-30.
//  Copyright (c) 2013 JCDigital. All rights reserved.
//

#import "HeaderView.h"
#import "Common.h"
#import <QuartzCore/QuartzCore.h>

@interface HeaderView()

@property (nonatomic, assign) CGRect paperRect;

@end

@implementation HeaderView

@synthesize titleLabel, darkColor, lightColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.layer.borderColor = darkColor.CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 0.0f;
        self.clipsToBounds = YES;
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.opaque = NO;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        titleLabel.shadowOffset = CGSizeMake(0, -1);
        titleLabel.frame = self.frame;
        [self addSubview:titleLabel];
        
        lightColor = [UIColor colorWithRed:0.40 green:0.70 blue:0.85 alpha:1.0];
        darkColor = [UIColor colorWithRed:0.10 green:0.30 blue:0.55 alpha:1.0];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, self.lightColor.CGColor);
    CGContextFillRect(context, self.frame);
    CGContextRestoreGState(context);
    
    drawGlossAndGradient(context, self.frame, self.lightColor.CGColor, self.darkColor.CGColor);
    
    CGContextSetStrokeColorWithColor(context, self.darkColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, rectFor1PxStroke(self.frame));
}

@end
