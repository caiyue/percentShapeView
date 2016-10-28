//
//  WanderShopActivityPKProgessView.m
//
//  Created by caiyue on 2016/10/24.
//  Copyright © 2016年 caiyue. All rights reserved.
//

#import "WanderShopActivityPKProgessView.h"
#import "UIColor+Hex.h"

@interface WanderShopActivityPKProgessView ()
@property   (nonatomic,strong)  UIView  *progressView;
@end

@implementation WanderShopActivityPKProgessView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHex:@"#0B67E5"];
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews{
    UIView  *p = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGRectGetHeight(self.frame))];
    p.backgroundColor = [UIColor colorWithHex:@"E91F63"];
    [self addSubview:p];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImageView.image = [UIImage imageNamed:@"wanderShopActivityPKProgressBackgroundImage"];
    [self addSubview:bgImageView];
    self.progressView = p;
}

- (void)setProgress:(CGFloat)progress{
    if (_progress != progress) {
        _progress = progress;
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            self.progressView.frame = CGRectMake(0, 0, progress * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        } completion:^(BOOL finished) {
            
        }];
        
        //
        
        
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
