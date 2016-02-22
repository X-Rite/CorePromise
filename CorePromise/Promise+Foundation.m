//
//  Promise+Foundation.m
//  Promises
//
//  Created by Alexander Cohen on 2016-02-22.
//  Copyright © 2016 X-Rite, Inc. All rights reserved.
//

#import "Promise+Foundation.h"
#import "Promise.h"

@implementation NSURLSession (Promise)

+ (Promise*)promiseWithURL:(NSURL*)URL
{
    return [[NSURLSession sharedSession] promiseWithURL:URL];
}

+ (Promise*)promiseWithURLRequest:(NSURLRequest*)request
{
    return [[NSURLSession sharedSession] promiseWithURLRequest:request];
}

- (Promise*)promiseWithURL:(NSURL*)URL
{
    Promise* p = [Promise pendingPromise];
    
    [[self dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [p markStateWithValue: error ? error : data];
        }];
    }] resume];
    
    return p;
}

- (Promise*)promiseWithURLRequest:(NSURLRequest*)request
{
    Promise* p = [Promise pendingPromise];
    
    [[self dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [p markStateWithValue: error ? error : data];
        }];
    }] resume];
    
    return p;
}

@end

@implementation NSTimer (Promise)

+ (Promise*)promiseScheduledTimerWithTimeInterval:(NSTimeInterval)ti
{
    Promise* p = [Promise pendingPromise];
    [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(_promise_timer_fired:) userInfo:p repeats:NO];
    return p;
}

+ (void)_promise_timer_fired:(NSTimer*)timer
{
    Promise* p = timer.userInfo;
    [p markStateWithValue:nil];
}

@end
