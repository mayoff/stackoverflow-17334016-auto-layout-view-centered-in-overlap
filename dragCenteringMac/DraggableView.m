#import "DraggableView.h"

@implementation DraggableView {
    CGPoint anchorPoint;
}

@synthesize yConstraint = _yConstraint;

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor greenColor] setFill];
    [NSBezierPath fillRect:dirtyRect];
}

- (void)mouseDown:(NSEvent *)theEvent {
    anchorPoint = theEvent.locationInWindow;
}

- (void)mouseDragged:(NSEvent *)theEvent {
    CGPoint point = theEvent.locationInWindow;
    self.yConstraint.constant -= point.y - anchorPoint.y;
    anchorPoint = point;
}

@end
