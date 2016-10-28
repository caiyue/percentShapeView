//
//  WanderShopActivePKPercentView.h
//
//  Created by caiyue on 2016/10/19.
//  Copyright © 2016年 caiyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"

@interface WanderShopActivePKPercentView : UIView
- (nonnull instancetype)initWithFrame:(CGRect)frame withLineWidth:(CGFloat)lineWidth;
@property   (nonatomic,strong,nonnull)  UIColor *leftStrokeColor;
@property   (nonatomic,strong,nonnull)  UIColor *rightStrokeColor;
@property   (nonatomic,assign,nonnull)  UIColor *backgroundStrokeColor;
@property   (nonatomic,assign)  CGFloat animationTime;
///angle (0-M_PI *2)
- (void)setAngle:(CGFloat)angle animationFromStartAngle:(BOOL)yon;
@property   (nonatomic,assign)  int type;

@end
