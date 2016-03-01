/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 Alexander Cohen
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
 */

#import <CorePromise/CPPromise.h>

@interface NSURLSession (CPPromise)

- (CPPromise<NSData*>*)promiseWithURL:(NSURL*)URL;
- (CPPromise<NSData*>*)promiseWithURLRequest:(NSURLRequest*)request;

+ (CPPromise<NSData*>*)promiseWithURL:(NSURL*)URL;
+ (CPPromise<NSData*>*)promiseWithURLRequest:(NSURLRequest*)request;

@end

@interface NSTimer (CPPromise)

+ (CPPromise*)promiseScheduledTimerWithTimeInterval:(NSTimeInterval)ti;

@end

@interface NSFileHandle (CPPromise)

- (CPPromise<NSData*>*)promiseRead;
- (CPPromise<NSData*>*)promiseReadToEndOfFile;
- (CPPromise<NSFileHandle*>*)promiseWaitForData;

@end

@interface NSNotificationCenter (CPPromise)

- (CPPromise<NSNotification*>*)promiseObserveOnce:(NSString*)notificationName;
- (CPPromise<NSNotification*>*)promiseObserveOnce:(NSString*)notificationName object:(id)object;

@end