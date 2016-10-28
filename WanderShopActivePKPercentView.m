//
//  WanderShopActivePKPercentView.m
//
//  Created by caiyue on 2016/10/19.
//  Copyright © 2016年 caiyue. All rights reserved.
//

#import "WanderShopActivePKPercentView.h"


@interface PKShapeLayer : CAShapeLayer
@property   (nonatomic,assign)  CGFloat startAngle;//弧形平分点
@property   (nonatomic,assign)  CGFloat totalAngle;//当前弧形角度,以startAngle平分
@end

@implementation PKShapeLayer
@end


@interface WanderShopActivePKPercentView ()
@property   (nonatomic,strong)  PKShapeLayer    *backLayer;
@property   (nonatomic,strong)  PKShapeLayer    *leftLayer;//左边layer
@property   (nonatomic,strong)  PKShapeLayer    *rightLayer;//右边的layer
@property   (nonatomic,assign)  CGFloat         angle;//leftLayer 角度
@property   (nonatomic,assign)  CGFloat         radius;//半径
@property   (nonatomic,assign)  CGFloat         lineWidth;
@end

@implementation WanderShopActivePKPercentView

- (instancetype)initWithFrame:(CGRect)frame withLineWidth:(CGFloat)lineWidth
{
    if (self = [super initWithFrame:frame]) {
        _radius = CGRectGetWidth(frame)/2.0;
        _lineWidth =  lineWidth/2.0;
        [self configShapeLayer];
    }
    
    return self;
}

- (void)configShapeLayer{
    if (!_backgroundStrokeColor) {
        _backgroundStrokeColor = [UIColor whiteColor];
    }
    if (!_leftStrokeColor) {
        _leftStrokeColor = [UIColor whiteColor];
    }
    if (!_rightStrokeColor) {
        _rightStrokeColor = [UIColor whiteColor];
    }
    if (_radius <= 0) {
        _radius = 100;
    }
    if (_lineWidth <= 0) {
        _lineWidth = 20;
    }
    
    PKShapeLayer    *bgLayer = [self shapeLayer];
    bgLayer.strokeColor = _backgroundStrokeColor.CGColor;
    bgLayer.frame = self.bounds;
    bgLayer.lineWidth = 0;
    bgLayer.strokeStart = 0.0f;
    bgLayer.fillColor = [UIColor  colorWithHex:@"#041848"].CGColor;
    bgLayer.path  = [self createPathStartAngle:0 endAngle:M_PI*2 radius:_radius clockWise:YES];
    self.backLayer = bgLayer;
    
    
    //上部遮罩
    CALayer *upCoverLayer = [CALayer layer];
    upCoverLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetWidth(self.bounds));
    upCoverLayer.contents = (__bridge id)[UIImage imageNamed:@"fullcover"].CGImage;
    upCoverLayer.contentsGravity = kCAGravityResizeAspect;
    
    
    //下部遮罩
//    CALayer *downCoverLayer = [CALayer layer];
//    downCoverLayer.frame = CGRectMake(15, 60 , 75, 43);
//    downCoverLayer.contents = (__bridge id)[UIImage imageNamed:@"wanderShopActivityPKPercentViewCover_down"].CGImage;
//    downCoverLayer.contentsGravity = kCAGravityResizeAspect;
    
    //左边layer配置
    self.leftLayer = [self shapeLayer];
    self.leftLayer.strokeColor = [UIColor clearColor].CGColor; //初始状态没有颜色
    self.leftLayer.lineWidth = _lineWidth;
    self.leftLayer.totalAngle = 0;//初始时角度为0
    self.leftLayer.startAngle = M_PI;//180度位置
    self.leftLayer.path  = [self createPathStartAngle:0 endAngle:M_PI*2 radius:_radius - _lineWidth/2 clockWise:YES];
    
    
    //右边layer 配置
    self.rightLayer = [self shapeLayer];
    self.rightLayer.strokeColor = [UIColor clearColor].CGColor; //初始状态没有颜色
    self.rightLayer.lineWidth = _lineWidth;
    self.rightLayer.totalAngle = 0;//初始化角度为0，第一次会从两边动画
    self.rightLayer.startAngle = M_PI;//180度位置
    self.rightLayer.path  = [self createPathStartAngle:M_PI endAngle:M_PI*2 + M_PI radius:_radius - _lineWidth/2  clockWise:YES];//path的radius 是从圆点到line中部的距离
    
    
    //图片layer
    CALayer *imgLayer = [CALayer layer];
    imgLayer.frame = CGRectMake(_radius - _lineWidth -5 - _lineWidth / 4 , _radius - _lineWidth - 5  - _lineWidth / 4, (_radius - _lineWidth/2), (_radius - _lineWidth/2));//- 5 主要是还是图片比例不合适
    imgLayer.contents = (__bridge id)[UIImage imageNamed:@"wanderShopActivityPKPercentViewVSImage"].CGImage;
    imgLayer.contentsGravity = kCAGravityResizeAspect;
    [self.layer addSublayer:imgLayer];
    
    
    [self.layer addSublayer:bgLayer];
    [bgLayer addSublayer:imgLayer];
    [bgLayer addSublayer:self.rightLayer];
    [bgLayer addSublayer:self.leftLayer];
    [bgLayer addSublayer:upCoverLayer];
//    [bgLayer addSublayer:downCoverLayer];
}

- (void)setBackgroundStrokeColor:(UIColor *)backgroundStrokeColor
{
    _backgroundStrokeColor = backgroundStrokeColor;
    self.backLayer.strokeColor = _backgroundStrokeColor.CGColor;//立马改变颜色
}

- (void)setLeftStrokeColor:(UIColor *)leftStrokeColor
{
    _leftStrokeColor = leftStrokeColor;//动画时，改变颜色
}

- (void)setRightStrokeColor:(UIColor *)rightStrokeColor
{
    _rightStrokeColor = rightStrokeColor;//动画时，改变颜色
}

//设置角度
- (void)setAngle:(CGFloat)angle animationFromStartAngle:(BOOL)yon
{
    if (angle < 0 || angle > M_PI*2) {
        return;
    }
    
    [self addAimationWithAngle:angle  animationfromOrginStartAngle:yon];
}

- (void)addAimationWithAngle:(CGFloat)angle animationfromOrginStartAngle:(BOOL)fromStartAngle{
    //leftLayer
    CGFloat leftLayerOrginStrokeStartAngle = self.leftLayer.startAngle - (fromStartAngle?0:self.leftLayer.totalAngle/2);
    CGFloat leftLayerOrginStokeEndAngle = self.leftLayer.startAngle + (fromStartAngle?0:self.leftLayer.totalAngle/2);
    self.leftLayer.totalAngle = angle;
    CGFloat leftLayerStrokeStartAngle = self.leftLayer.startAngle - self.leftLayer.totalAngle/2;
    CGFloat leftLayerStokeEndAngle = self.leftLayer.startAngle + self.leftLayer.totalAngle/2;
    
    
    self.leftLayer.strokeColor = _leftStrokeColor.CGColor;
    CABasicAnimation    *leftStartAnimation = [self createAnimationOrginEndAngle:leftLayerOrginStrokeStartAngle ToAngle:leftLayerStrokeStartAngle forKey:@"strokeStart" forLayer:self.leftLayer];
    [self.leftLayer addAnimation:leftStartAnimation forKey:@"strokeStart"];
    CABasicAnimation    *leftEndAnimation = [self createAnimationOrginEndAngle:leftLayerOrginStokeEndAngle ToAngle:leftLayerStokeEndAngle forKey:@"strokeEnd" forLayer:self.leftLayer];
    [self.leftLayer addAnimation:leftEndAnimation forKey:@"strokeEnd"];
    
    
    //rightLayer
    CGFloat rightLayerOrginStrokeStartAngle = self.rightLayer.startAngle - (fromStartAngle?0:self.rightLayer.totalAngle/2);
    CGFloat rightLayerOrginStokeEndAngle = self.rightLayer.startAngle + (fromStartAngle?0:self.rightLayer.totalAngle/2);
    self.rightLayer.totalAngle = M_PI * 2 - angle;
    CGFloat rightLayerStrokeStartAngle = self.rightLayer.startAngle - self.rightLayer.totalAngle/2;
    CGFloat rightLayerStokeEndAngle = self.rightLayer.startAngle + self.rightLayer.totalAngle/2;
    
    self.rightLayer.strokeColor = _rightStrokeColor.CGColor;
    CABasicAnimation    *rightStartAnimation = [self createAnimationOrginEndAngle:rightLayerOrginStrokeStartAngle ToAngle:rightLayerStrokeStartAngle forKey:@"strokeStart" forLayer:self.rightLayer];
    [self.rightLayer addAnimation:rightStartAnimation forKey:@"strokeStart"];
    CABasicAnimation    *rightEndAnimation = [self createAnimationOrginEndAngle:rightLayerOrginStokeEndAngle ToAngle:rightLayerStokeEndAngle forKey:@"strokeEnd" forLayer:self.rightLayer];
    [self.rightLayer addAnimation:rightEndAnimation forKey:@"strokeEnd"];
}

//创建动画
- (CABasicAnimation *)createAnimationOrginEndAngle:(CGFloat)orginEndAngle  ToAngle:(CGFloat)endAngle  forKey:(NSString *)key  forLayer:(PKShapeLayer *)layer{
    CGFloat fromValue  = 0;
    CGFloat toValue = 0;
    
    fromValue = orginEndAngle / (M_PI * 2);
    toValue = endAngle / (M_PI * 2);
    
    if ([key isEqualToString:@"strokeEnd"]) {
        layer.strokeEnd = toValue;
    }else
        layer.strokeStart = toValue;
    
    // NSLog(@"%@,%@, fromAngle:%f,ToAngle:%f,fromValue:%f,toValue:%f,",string, key, orginEndAngle,endAngle,fromValue,toValue);
    CABasicAnimation *animaton = nil;
    animaton = [CABasicAnimation animationWithKeyPath:key];
    animaton.duration = _animationTime;
    animaton.fromValue = @(fromValue);
    animaton.toValue = @(toValue);
    animaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animaton.autoreverses = NO; //无自动动态倒退效果
    return animaton;
}

-( PKShapeLayer*)shapeLayer{
    PKShapeLayer *s = [PKShapeLayer layer];
    s.fillColor = [UIColor clearColor].CGColor;
    s.lineCap = kCALineCapRound;
    s.drawsAsynchronously = YES;
    return s;
}

///创建path
- (CGPathRef)createPathStartAngle:(CGFloat)startAngle  endAngle:(CGFloat)endAngle radius:(CGFloat)radius clockWise:(BOOL)yon{
    return  [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:radius  startAngle:startAngle endAngle:endAngle clockwise:yon].CGPath;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


