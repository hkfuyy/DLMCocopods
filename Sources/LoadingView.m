//
//  LoadingView.m
//  AizhizuPartner
//
//  Created by HRK on 16/3/29.
//  Copyright © 2016年 herenke. All rights reserved.
//

#import "LoadingView.h"

#define IMAGEWIDTH 50

#define SCREENWIDTH self.frame.size.width
#define SCREENHEIGTH self.frame.size.height

@interface LoadingView ()
{
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
    
}
@property (nonatomic,retain) UIImageView        *imgView;
@property (nonatomic,strong) CALayer            *staticLayer;
@property (nonatomic,strong) CAGradientLayer    *staticShadowLayer;
@property (nonatomic)        double             getAddressTime;
@property (nonatomic,strong) NSTimer            *timer ;
@end

@implementation LoadingView

#pragma mark 懒加载
-(CALayer *)staticLayer{
    if (!_staticLayer) {
        self.staticLayer = [[CALayer alloc] init];
        self.staticLayer.cornerRadius = IMAGEWIDTH;
        self.staticLayer.frame = CGRectMake(0, 0, self.staticLayer.cornerRadius*2 , self.staticLayer.cornerRadius*2);
        self.staticLayer.borderWidth = 1;
        self.staticLayer.position = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGTH/2.0);
        
        UIColor *color = [UIColor colorWithRed:248/255.0 green:220/255.0 blue:82/255.0 alpha:1];
        
        self.staticLayer.borderColor = color.CGColor;

    }
    return _staticLayer;
}

-(CAGradientLayer *)staticShadowLayer{
    if (!_staticShadowLayer) {
        self.staticShadowLayer = [[CAGradientLayer alloc] init];
        self.staticShadowLayer.cornerRadius = IMAGEWIDTH;
        self.staticShadowLayer.frame = CGRectMake(0, 0, self.staticLayer.cornerRadius*2-1 , self.staticLayer.cornerRadius*2-1);
        //    layer1.borderWidth = 18;
        self.staticShadowLayer.position = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGTH/2.0);
        UIColor* backColor = [UIColor colorWithRed:248/255.0 green:220/255.0 blue:82/255.0 alpha:0.8];
        self.staticShadowLayer.colors = [NSArray arrayWithObjects:(id)backColor.CGColor,(id)backColor.CGColor ,nil];
        
    }
    return _staticShadowLayer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = YES;
}

-(void)initAnimation{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LoadingCenter"]];
    self.imgView.frame = CGRectMake(SCREENWIDTH/2 - IMAGEWIDTH/2, SCREENHEIGTH/2 - IMAGEWIDTH/2, IMAGEWIDTH, IMAGEWIDTH);
    self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2.0;
    self.imgView.layer.masksToBounds = YES;
    [self addSubview:self.imgView];
    
    [self startAnimation];
    
}


#pragma mark 动画
//开始动画
- (void)startAnimation
{
    [self.layer addSublayer:self.staticLayer];
    [self.layer addSublayer:self.staticShadowLayer];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 1;
    _animaTionGroup.removedOnCompletion = YES;
    _animaTionGroup.timingFunction = defaultCurve;
    
    _animaTionGroup.autoreverses = YES;
    _animaTionGroup.repeatCount = MAXFLOAT;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.5;
    scaleAnimation.toValue = @1.5;
    scaleAnimation.duration = 1;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 1;
    opencityAnimation.values = @[@0.6,@0.2,@0.2];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    opencityAnimation.autoreverses = YES;
    opencityAnimation.repeatCount = MAXFLOAT;
    
    NSArray *animations = @[scaleAnimation,opencityAnimation];
    
    _animaTionGroup.animations = animations;
    [self.staticLayer addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    [self.staticShadowLayer addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    
    [self bringSubviewToFront:self.imgView];
}

//点击事件的动画
-(void)click{
    
    self.getAddressTime = [[NSDate date] timeIntervalSince1970];
    
    CALayer *layer      = [[CALayer alloc] init];
    layer.cornerRadius  = [UIScreen mainScreen].bounds.size.width;
    layer.frame         = CGRectMake(0, 0, layer.cornerRadius*2 , layer.cornerRadius*2);
    layer.borderWidth   = 1;
    layer.position      = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGTH/2.0);
    
    layer.borderColor   = [UIColor redColor].CGColor;
    [self.layer addSublayer:layer];
    
    CAGradientLayer *layer1     = [[CAGradientLayer alloc] init];
    layer1.cornerRadius         = [UIScreen mainScreen].bounds.size.width;
    
    layer1.frame                = CGRectMake(0,
                                             0,
                                             layer.cornerRadius*2-1 ,
                                             layer.cornerRadius*2-1);
    
    layer1.position             = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGTH/2.0);
    
    UIColor *backColor                   = [UIColor colorWithRed:100/255.0
                                                  green:46/255.0
                                                   blue:97/255.0
                                                  alpha:0.8];
    
    layer1.colors               = [NSArray arrayWithObjects:
                                   (id)backColor.CGColor,
                                   [UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.8].CGColor ,
                                   nil];
    
    [self.layer addSublayer:layer1];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 2;
    _animaTionGroup.removedOnCompletion = YES;
    _animaTionGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.15;
    scaleAnimation.toValue = @1.5;
    scaleAnimation.duration = 2;
    scaleAnimation.removedOnCompletion = YES;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration  = 2;
    opencityAnimation.values    = @[@1.0,@0.5,@0.0];
    opencityAnimation.keyTimes  = @[@0.0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    
    NSArray *animations = @[scaleAnimation,opencityAnimation];
    
    _animaTionGroup.animations = animations;
    [layer  addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    [layer1 addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    
    [self performSelector:@selector(removeLayer:) withObject:layer afterDelay:2];
    [self performSelector:@selector(removeLayer:) withObject:layer1 afterDelay:2];
    
    [self performSelector:@selector(hideLayer:) withObject:layer afterDelay:1];
    [self performSelector:@selector(hideLayer:) withObject:layer1 afterDelay:1];
    
    [self bringSubviewToFront:self.imgView];
}

-(void)hideLayer:(CALayer*)layer{
    
    layer.hidden = YES;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(action) userInfo:nil repeats:NO];
}

- (void)removeLayer:(CALayer *)layer
{
    
    [layer removeFromSuperlayer];
    [layer removeAnimationForKey:@"groupAnnimation"];
    
}

//点击事件结束2秒后开始执行startAnimation
-(void)action{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];;
    if (currentTime - self.getAddressTime > 2) {
        [self startAnimation];
        [self.timer invalidate];
        self.timer = nil;
    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(action) userInfo:nil repeats:NO];
    }
}

-(void)stopAnimation{
    [self.layer removeAllAnimations];
    [_disPlayLink invalidate];
    _disPlayLink = nil;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.staticShadowLayer removeFromSuperlayer];
//    [self.staticShadowLayer removeAnimationForKey:@"groupAnnimation"];
//    [self.staticLayer removeFromSuperlayer];
//    [self.staticLayer removeAnimationForKey:@"groupAnnimation"];
//    
//    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(click)];
//    _disPlayLink.frameInterval = 40;
//    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//}

//- (void)delayAnimation
//{
//    [self startAnimation];
//}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.layer removeAllAnimations];
//    [_disPlayLink invalidate];
//    _disPlayLink = nil;
//}

@end
