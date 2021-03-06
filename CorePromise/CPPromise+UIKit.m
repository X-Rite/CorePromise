/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2017 Alexander Cohen
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Totally inspired by https://github.com/mxcl/PromiseKit
 *
 */

#import "CPPromise+UIKit.h"
#import "CPPromise.h"

@interface UIViewAnimationPromise : CPPromise
@end

@implementation UIViewAnimationPromise
@end

@implementation UIView (Promise)

+ (CPPromise*)promiseAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations
{
    return [CPPromise promiseWithBlock:^(CPPromiseFulfiller fulfill, CPPromiseRejecter reject) {
        [self animateWithDuration:duration delay:delay options:options animations:animations completion:^(BOOL finished) {
            fulfill( @(finished) );
        }];
    }];
}

+ (CPPromise*)promiseAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations
{
    return [CPPromise promiseWithBlock:^(CPPromiseFulfiller fulfill, CPPromiseRejecter reject) {
        [self animateWithDuration:duration animations:animations completion:^(BOOL finished) {
            fulfill( @(finished) );
        }];
    }];
}

- (CPPromise*)promiseSpringAnimationWithMass:(CGFloat)mass stiffness:(CGFloat)stiffness damping:(CGFloat)damping initialVelocity:(CGFloat)initialVelocity forKeyPath:(NSString*)keyPath fromValue:(NSValue*)fromValue toValue:(NSValue*)toValue
{
    CASpringAnimation* spring = [CASpringAnimation animationWithKeyPath:keyPath];
    spring.mass = mass;
    spring.stiffness = stiffness;
    spring.damping = damping;
    spring.initialVelocity = initialVelocity;
    spring.fromValue = fromValue ? fromValue : [self.layer valueForKeyPath:keyPath];
    spring.toValue = toValue;
    spring.duration = spring.settlingDuration;
    
    // tell the model where it actually ends up ( this is so the layer does not bounce back to the original position )
    [self.layer setValue:toValue forKeyPath:keyPath];
    
    return [UIViewAnimationPromise promiseWithBlock:^(CPPromiseFulfiller fulfill, CPPromiseRejecter reject) {

        [CATransaction begin];
        
        [CATransaction setCompletionBlock:^{
            fulfill(self);
        }];
        
        [self.layer addAnimation:spring forKey:@"promise_spring"];
        
        [CATransaction commit];
    }];

}

@end
