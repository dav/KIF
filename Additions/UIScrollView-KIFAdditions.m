//
//  UIScrollView-KIFAdditions.m
//  KIF
//
//  Created by Eric Firestone on 5/22/11.
//  Copyright 2011 Square, Inc. All rights reserved.
//

#import "UIScrollView-KIFAdditions.h"
#import "UIApplication-KIFAdditions.h"
#import "UIView-KIFAdditions.h"


@implementation UIScrollView (KIFAdditions)

- (void)scrollViewToVisible:(UIView *)view animated:(BOOL)animated;
{
    BOOL needsUpdate = NO;
    CGRect frame = [self.window convertRect:self.frame fromView:self.superview];
    
    CGRect viewFrame = [self.window convertRect:view.frame fromView:view.superview];
    CGFloat viewMaxX = viewFrame.origin.x + viewFrame.size.width;
    CGFloat viewMaxY = viewFrame.origin.y + viewFrame.size.height;
    CGFloat scrollViewMaxX = frame.origin.x + frame.size.width;
    CGFloat scrollViewMaxY = frame.origin.y + frame.size.height;
    
    CGPoint offsetPoint = self.contentOffset;
    if (viewMaxX > scrollViewMaxX) {
        // The view is to the right of the view port, so scroll it just into view
        offsetPoint.x = frame.origin.x + viewFrame.size.width;
        needsUpdate = YES;
    } else if (viewMaxX < 0.0) {
        offsetPoint.x = viewFrame.origin.x;
        needsUpdate = YES;
    }
    
    if (viewMaxY > scrollViewMaxY) {
        // The view is below the view port, so scroll it just into view
        offsetPoint.y = frame.origin.y + viewFrame.size.height;
        needsUpdate = YES;
    } else if (viewMaxY < 0.0) {
        offsetPoint.y = viewFrame.origin.y;
        needsUpdate = YES;
    }
    
    if (needsUpdate) {
        offsetPoint = [self.window convertPoint:offsetPoint toView:self.superview];
        [self setContentOffset:offsetPoint animated:animated];
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.2, false);
    }
}

@end
