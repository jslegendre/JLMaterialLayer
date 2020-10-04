//
//  JLMaterialLayer.h
//  JLVisualEffectViewDemo
//
//  Created by Jeremy on 10/2/20.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLMaterialLayer : CALayer
@property (nonatomic) CGFloat blurRadius;
@property (nonatomic) CGFloat saturation;
@property (nonatomic) CGFloat colorBrightness;
@property (nonatomic) CGFloat adaptiveTintOpacity;
@property (nonatomic) CGFloat fillOpacity;
@property (nonatomic) CGColorRef fillColor;
@property (nonatomic) BOOL allowsGroupBlending;
@end

NS_ASSUME_NONNULL_END
