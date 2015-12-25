//
//  UINavigationBar+BarBackground.m
//  CMNavigationBarBg
//
//  Created by shuwang on 15/12/24.
//  Copyright © 2015年 chermon. All rights reserved.
//

#import "UINavigationBar+BarBackground.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BarBackground)
static char overlayKey;

-(UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

-(void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)bar_backgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc]init];
        self.overlay.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20);
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    
    self.overlay.backgroundColor = backgroundColor;

}
@end
