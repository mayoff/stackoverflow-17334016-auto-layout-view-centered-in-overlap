#import "SpacerView.h"

@implementation SpacerView

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor colorWithSRGBRed:.9 green:.9 blue:.8 alpha:1] setFill];
    [NSBezierPath fillRect:dirtyRect];
}

@end
