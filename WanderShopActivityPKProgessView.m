//
//  WanderShopActivityPKProgessView.m
//
//  Created by caiyue on 2016/10/24.
//  Copyright © 2016年 caiyue. All rights reserved.
//

#import "WanderShopActivityPKProgessView.h"
#import "UIColor+Hex.h"

@interface WanderShopActivityPKProgessView ()
@property   (nonatomic,strong)  UIView  *progressViewLeft;
@property   (nonatomic,strong)  UIView  *progressViewRight;
@end

@implementation WanderShopActivityPKProgessView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews{
    UIView  *pLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGRectGetHeight(self.frame))];
    pLeft.backgroundColor = [UIColor colorWithHex:@"#E91F63"];
    [self addSubview:pLeft];
    self.progressViewLeft = pLeft;
    
    UIView  *pRight = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame), 0, 0, CGRectGetHeight(self.frame))];
    pRight.backgroundColor = [UIColor colorWithHex:@"#0B67E5"];
    [self addSubview:pRight];
    self.progressViewRight = pRight;
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImageView.image = [UIImage imageNamed:@"wanderShopActivityPKProgressBackgroundImage"];
    [self addSubview:bgImageView];
}

- (void)setProgress:(CGFloat)progress{
    [self setProgress:progress startFromEdge:YES];
}

- (void)setProgress:(CGFloat)progress startFromEdge:(BOOL)yon{
    if (_progress != progress) {
        if (progress > 1) {//重置为1
            progress = 1;
        }
        _progress = progress;
        if (yon) {
            [self reset];
        }
        if (_animationTime <= 0) {
            _animationTime = 0.5;
        }
        [UIView animateWithDuration:_animationTime delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.progressViewLeft.frame = CGRectMake(0, 0, progress * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:_animationTime delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.progressViewRight.frame = CGRectMake(progress*CGRectGetWidth(self.frame), 0, (1-progress) * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        } completion:^(BOOL finished) {
        }];
    }
}

//reset
- (void)reset{
    self.progressViewLeft.frame = CGRectMake(0, 0, 0, CGRectGetHeight(self.frame));
    self.progressViewRight.frame = CGRectMake(CGRectGetWidth(self.frame), 0, 0, CGRectGetHeight(self.frame));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
