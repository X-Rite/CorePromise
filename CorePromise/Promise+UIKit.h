/*
 *
 *  Copyright 2016 X-Rite, Incorporated. All rights reserved.
 *
 *
 *  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 *  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 *  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 *  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 *  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 *  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import <CorePromise/Promise.h>
#import <UIKit/UIKit.h>

@interface UIView (Promise)

/* ValueType is a BOOL ( finished ) */
+ (Promise<NSNumber*>*)promiseAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations;

/* ValueType is a BOOL ( finished ) */
+ (Promise<NSNumber*>*)promiseAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;

/* ValueType is a UIView - the view that was animated */
- (Promise<UIView*>*)promiseSpringAnimationWithMass:(CGFloat)mass stiffness:(CGFloat)stiffness damping:(CGFloat)damping initialVelocity:(CGFloat)initialVelocity forKeyPath:(NSString*)keyPath fromValue:(NSValue*)fromValue toValue:(NSValue*)toValue;

@end
