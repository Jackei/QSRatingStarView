//
//  QSRatingView.m
//  QSRatingStarView
//
//  Created by qizhijian on 16/1/11.
//  Copyright © 2016年 qizhijian. All rights reserved.
//

#import "QSRatingView.h"

@implementation QSRatingView
{
    CAShapeLayer      *shapeLayer;
    CGPoint            beginPoint;
    CGFloat            beginWidth;
}

- (instancetype)initWithFrame:(CGRect)frame andStarCount:(NSInteger)starCount
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CAReplicatorLayer *rep = [CAReplicatorLayer layer];
        rep.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        rep.instanceTransform = CATransform3DMakeTranslation(CGRectGetWidth(frame)/starCount, 0, 0);
        rep.instanceCount = starCount;
        
        CALayer *layer1 = [CALayer layer];
        layer1.frame = CGRectMake(0, 0, CGRectGetWidth(frame)/starCount, CGRectGetHeight(frame));
        layer1.contents = (__bridge id _Nullable)([UIImage imageNamed:@"b27_icon_star_gray"].CGImage);
        [rep addSublayer:layer1];
        
        [self.layer addSublayer:rep];
        
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(CGRectGetWidth(frame)/starCount, 0, 0);
        replicatorLayer.instanceCount = starCount;
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, CGRectGetWidth(frame)/starCount, CGRectGetHeight(frame));
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"b27_icon_star_yellow"].CGImage);
        [replicatorLayer addSublayer:layer];
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(frame)/2, CGRectGetHeight(frame))];
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        replicatorLayer.mask = shapeLayer;
        
        [self.layer addSublayer:replicatorLayer];
    }
    return self;
}

- (void)doAnimation:(CGFloat)diff
{
    UIBezierPath *bez;
    if (beginWidth + diff > CGRectGetWidth(self.frame))
    {
        beginWidth = CGRectGetWidth(self.frame);
        bez = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, beginWidth, CGRectGetHeight(self.frame))];
    }
    else if (beginWidth + diff <= 0)
    {
        beginWidth = 0;
        bez = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, beginWidth, CGRectGetHeight(self.frame))];
    }
    else
    {
        bez = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, beginWidth+diff, CGRectGetHeight(self.frame))];
    }
    
    shapeLayer.path = bez.CGPath;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    beginPoint = [touch locationInView:self];
    
    beginWidth = CGPathGetPathBoundingBox(shapeLayer.path).size.width;
    
    [self doAnimation:beginPoint.x-beginWidth];
    
    beginWidth = beginPoint.x;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    CGFloat diff = point.x - beginPoint.x;
    
    [self doAnimation:diff];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat f = CGPathGetPathBoundingBox(shapeLayer.path).size.width;
    NSLog(@"current ---- %.2f",f/CGRectGetWidth(self.frame));
}

@end
