//
//  AppDelegate.m
//  JLMaterialLayerDemo
//
//  Created by Jeremy on 10/2/20.
//

#import "AppDelegate.h"
#import "JLMaterialLayer.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@property (strong) JLMaterialLayer *materialLayer;
@property (strong) IBOutlet NSSlider *blurRadiusSlider;
@property (strong) IBOutlet NSTextField *blurRadiusValue;
@property (strong) IBOutlet NSSlider *saturationSlider;
@property (strong) IBOutlet NSTextField *saturationValue;
@property (strong) IBOutlet NSSlider *colorBrightnessSlider;
@property (strong) IBOutlet NSTextField *colorBrightnessValue;
@property (strong) IBOutlet NSSlider *adaptiveTintOpacitySlider;
@property (strong) IBOutlet NSTextField *adaptiveTintValue;
@property (strong) IBOutlet NSSlider *windowPassthrough;
@property (strong) IBOutlet NSTextField *windowPassthroughValue;
@property (strong) IBOutlet NSColorWell *colorWell;
@property (strong) IBOutlet NSTextField *colorValue;
@property (strong) IBOutlet NSSlider *fillLayerOpacitySlider;
@property (strong) IBOutlet NSTextField *fillLayerOpacityValue;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.window.opaque = NO;
    self.window.movableByWindowBackground = YES;

    NSColor *winColor = self.window.backgroundColor;
    winColor = [winColor colorWithAlphaComponent:0.5];
    self.window.backgroundColor = winColor;

    self.materialLayer = [JLMaterialLayer layer];
    self.materialLayer.frame = self.window.contentView.bounds;
    self.materialLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    [self.window.contentView.layer addSublayer:self.materialLayer];

    self.blurRadiusSlider.floatValue = self.materialLayer.blurRadius;
    self.blurRadiusValue.stringValue = [NSString stringWithFormat:@"%.2f", self.materialLayer.blurRadius];

    self.saturationSlider.floatValue = self.materialLayer.saturation;
    self.saturationValue.stringValue = [NSString stringWithFormat:@"%.2f", self.materialLayer.saturation];

    self.colorBrightnessSlider.floatValue = self.materialLayer.colorBrightness;
    self.colorBrightnessValue.stringValue = [NSString stringWithFormat:@"%.2f", self.materialLayer.colorBrightness];

    self.adaptiveTintOpacitySlider.floatValue = self.materialLayer.adaptiveTintOpacity;
    self.adaptiveTintValue.stringValue = [NSString stringWithFormat:@"%.2f", self.materialLayer.adaptiveTintOpacity];

    self.windowPassthrough.floatValue = self.window.backgroundColor.alphaComponent;
    self.windowPassthroughValue.stringValue = [NSString stringWithFormat:@"%.2f", self.window.backgroundColor.alphaComponent];

    self.colorWell.color = [NSColor colorWithCGColor:self.materialLayer.fillColor];

    self.fillLayerOpacitySlider.floatValue = self.materialLayer.fillOpacity;
    self.fillLayerOpacityValue.stringValue = [NSString stringWithFormat:@"%.2f", self.materialLayer.fillOpacity];
}

- (IBAction)updateBlurRadius:(NSSlider *)sender {
    self.materialLayer.blurRadius = sender.floatValue;
    self.blurRadiusValue.stringValue = [NSString stringWithFormat:@"%.2f", sender.floatValue];
}

- (IBAction)updateSaturation:(NSSlider *)sender {
    self.materialLayer.saturation = sender.floatValue;
    self.saturationValue.stringValue = [NSString stringWithFormat:@"%.2f", sender.floatValue];
}

- (IBAction)updateColorBrightness:(NSSlider *)sender {
    self.materialLayer.colorBrightness = sender.floatValue;
    self.colorBrightnessValue.stringValue = [NSString stringWithFormat:@"%.2f", sender.floatValue];
}

- (IBAction)updateAdaptiveTint:(NSSlider *)sender {
    self.materialLayer.adaptiveTintOpacity = sender.floatValue;
    self.adaptiveTintValue.stringValue = [NSString stringWithFormat:@"%.2f", sender.floatValue];
}

- (IBAction)updateWindowPassthrough:(NSSlider *)sender {
    NSColor *winColor = self.window.backgroundColor;
    winColor = [winColor colorWithAlphaComponent:sender.floatValue];
    self.window.backgroundColor = winColor;
    self.windowPassthroughValue.stringValue = [NSString stringWithFormat:@"%.2f", sender.floatValue];
}

- (IBAction)colorSelected:(NSColorWell *)sender {
    self.materialLayer.fillColor = sender.color.CGColor;
    NSString *rgbString = [NSString stringWithFormat:@"R: %.2f G: %.2F B: %.2f",
                           sender.color.redComponent,
                           sender.color.greenComponent,
                           sender.color.blueComponent];
    
    self.colorValue.stringValue = rgbString;
}

- (IBAction)upadteFillOpacity:(NSSlider *)sender {
    self.materialLayer.fillOpacity = sender.floatValue;
    self.fillLayerOpacityValue.stringValue = [NSString stringWithFormat:@"%.2f", sender.floatValue];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
