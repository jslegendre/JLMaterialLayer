//
//  JLMaterialLayer.m
//  JLVisualEffectViewDemo
//
//  Created by Jeremy on 10/2/20.
//

#import "JLMaterialLayer.h"
#import <AppKit/AppKit.h>
#import <QuartzCore/QuartzCore.h>

extern NSString* const kCAFilterGaussianBlur;
extern NSString* const kCAFilterColorSaturate;
extern NSString* const kCAFilterColorBrightness;

@interface CAFilter : NSObject
+(id)filterWithType:(NSString *)filterType;
-(void)setValue:(id)value forKey:(NSString *)key ;
-(BOOL)isEnabled;
-(void)setEnabled:(BOOL)enabled;
-(id)valueForKey:(NSString *)key;
@end

@interface CABackdropLayer : CALayer
@property (assign) BOOL windowServerAware;
@property (assign) BOOL allowsSubstituteColor;
@property (copy) NSString * groupNamespace;
@property (copy) NSString * groupName;
@property (assign) double scale;

-(void)setWindowServerAware:(BOOL)windowServerAware;
-(BOOL)windowServerAware;
-(BOOL)allowsSubstituteColor;
-(void)setAllowsSubstituteColor:(BOOL)allowsSubstituteColor;
-(void)setScale:(double)scale;
-(double)scale;
-(void)setBleedAmount:(double)bleedAmount;
-(double)bleedAmount;
-(void)setGroupName:(NSString *)groupName;
-(NSString *)groupName;
-(void)setGroupNamespace:(NSString *)groupNamespace;
-(NSString *)groupNamespace;
@end

@interface CAChameleonLayer : CALayer
@end


@interface JLMaterialLayer ()
@property (strong) CAFilter *blurFilter;
@property (strong) CAFilter *saturationFilter;
@property (strong) CAFilter *colorBrightnessFilter;
@property (strong) CABackdropLayer *backdropLayer;
@property (strong) CAChameleonLayer *chameleonLayer;
@property (strong) CALayer *fillLayer;
@property (strong) CALayer *materialLayer;
@end

@implementation JLMaterialLayer

- (instancetype)init {
    self = [super init];

    _fillOpacity = 0.0;
    _adaptiveTintOpacity = 0.05;
    _blurRadius = 10;
    _saturation = 1;
    _colorBrightness = 0;
    _fillColor = CGColorGetConstantColor(kCGColorBlack);
    
    self.blurFilter = [CAFilter filterWithType:kCAFilterGaussianBlur];
    [self.blurFilter setValue:[NSNumber numberWithBool:TRUE] forKey:@"inputNormalizeEdges"];
    [self.blurFilter setValue:[NSNumber numberWithFloat:_blurRadius] forKey:@"inputRadius"];
    
    self.saturationFilter = [CAFilter filterWithType:kCAFilterColorSaturate];
    [self.saturationFilter setValue:[NSNumber numberWithFloat:_saturation] forKey:@"inputAmount"];
    
    self.colorBrightnessFilter = [CAFilter filterWithType:kCAFilterColorBrightness];
    [self.colorBrightnessFilter setValue:[NSNumber numberWithFloat:_colorBrightness] forKey:@"inputAmount"];
    
    self.backdropLayer = [CABackdropLayer layer];
    self.backdropLayer.name = @"backdrop";
    self.backdropLayer.masksToBounds = YES;
    self.backdropLayer.windowServerAware = YES;
    self.backdropLayer.allowsSubstituteColor = YES;
    self.backdropLayer.groupNamespace = @"hostingNamespacedContext";
    self.backdropLayer.groupName = @"NSCGSWindowBehindWindowCaptureBackdropGroup";
    self.backdropLayer.filters = @[ self.blurFilter, self.saturationFilter, self.colorBrightnessFilter ];
    self.backdropLayer.scale = .5;
    self.backdropLayer.bleedAmount = .8;
    [self.backdropLayer setValue:[NSNumber numberWithBool:NO] forKey:@"allowsGroupBlending"];
    self.backdropLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    
    self.fillLayer = [CALayer layer];
    self.fillLayer.masksToBounds = YES;
    self.fillLayer.backgroundColor = CGColorGetConstantColor(kCGColorBlack);
    self.fillLayer.opacity = _fillOpacity;
    self.fillLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    
    self.chameleonLayer = [CAChameleonLayer layer];
    self.chameleonLayer.masksToBounds = YES;
    [self.chameleonLayer setValue:[NSNumber numberWithBool:NO] forKey:@"allowsGroupBlending"];
    self.chameleonLayer.opacity = _adaptiveTintOpacity;
    self.chameleonLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;

    self.allowsGroupOpacity = YES;
    self.allowsGroupBlending = NO;
    self.opaque = NO;
    self.masksToBounds = YES;
    self.sublayers = @[ self.backdropLayer, self.fillLayer, self.chameleonLayer ];

    return self;
}

- (void)setBlurRadius:(CGFloat)radius {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.blurFilter = [CAFilter filterWithType:kCAFilterGaussianBlur];
    [self.blurFilter setValue:[NSNumber numberWithBool:TRUE] forKey:@"inputNormalizeEdges"];
    [self.blurFilter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
    self.backdropLayer.filters = @[ self.blurFilter, self.saturationFilter, self.colorBrightnessFilter ];
    _blurRadius = radius;
    [CATransaction commit];
}

- (void)setSaturation:(CGFloat)amount {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.saturationFilter = [CAFilter filterWithType:kCAFilterColorSaturate];
    [self.saturationFilter setValue:[NSNumber numberWithFloat:amount] forKey:@"inputAmount"];
    self.backdropLayer.filters = @[ self.blurFilter, self.saturationFilter, self.colorBrightnessFilter ];
    _saturation = amount;
    [CATransaction commit];
}

- (void)setColorBrightness:(CGFloat)colorBrightness {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorBrightnessFilter = [CAFilter filterWithType:kCAFilterColorBrightness];
    [self.colorBrightnessFilter setValue:[NSNumber numberWithFloat:colorBrightness] forKey:@"inputAmount"];
    self.backdropLayer.filters = @[ self.blurFilter, self.saturationFilter, self.colorBrightnessFilter];
    _colorBrightness = colorBrightness;
    [CATransaction commit];
}

- (void)setFillColor:(CGColorRef)color {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.fillLayer.backgroundColor = color;
    _fillColor = color;
    [CATransaction commit];
}

- (void)setFillOpacity:(CGFloat)amount {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.fillLayer setOpacity:amount];
    _fillOpacity = amount;
    [CATransaction commit];
}

- (void)setAdaptiveTintOpacity:(CGFloat)amount {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.chameleonLayer setOpacity:amount];
    _adaptiveTintOpacity = amount;
    [CATransaction commit];
}
@end
