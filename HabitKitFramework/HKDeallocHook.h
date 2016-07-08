//
//  HKDeallocHook.h
//  HabitKit
//
//  Created by Alex Zimin on 07/07/16.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKDeallocHook : NSObject

@property (copy, nonatomic) dispatch_block_t callback;
+ (instancetype)attachTo:(id)target callback:(dispatch_block_t)block;

@end

@interface UISegmentedControlObserver: NSObject

@property (copy, nonatomic) dispatch_block_t callback;
+ (instancetype)attachTo:(id)target callback:(dispatch_block_t)block;

@end
