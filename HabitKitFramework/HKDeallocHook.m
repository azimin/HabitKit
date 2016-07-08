//
//  HKDeallocHook.m
//  HabitKit
//
//  Created by Alex Zimin on 07/07/16.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//
// From http://stackoverflow.com/questions/14708905/how-do-i-access-the-dealloc-method-in-a-class-category

@import ObjectiveC.runtime;

#import "HKDeallocHook.h"

static void *kDeallocHookAssociation = &kDeallocHookAssociation;
static void *kDeallocHookAssociation2 = &kDeallocHookAssociation2;

@implementation HKDeallocHook

+ (id)attachTo:(id)target callback:(dispatch_block_t)block
{
  HKDeallocHook *hook = [[HKDeallocHook alloc] initWithCallback: block];
  
  // The trick is that associations are released when your target
  // object gets deallocated, so our DeallocHook object will get
  // deallocated right after your object
  objc_setAssociatedObject(target, kDeallocHookAssociation, hook, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  return hook;
}


- (id)initWithCallback:(dispatch_block_t)block
{
  self = [super init];
  
  if (self != nil)
  {
    // Here we just copy the callback for later
    self.callback = block;
  }
  return self;
}


- (void)dealloc
{
  // And we place our callback within the -dealloc method
  // of your helper class.
  if (self.callback != nil)
  dispatch_async(dispatch_get_main_queue(), self.callback);
}

@end

@implementation UISegmentedControlObserver

+ (instancetype)attachTo:(id)target
{
  UISegmentedControlObserver *hook = [UISegmentedControlObserver new];
  
  // The trick is that associations are released when your target
  // object gets deallocated, so our DeallocHook object will get
  // deallocated right after your object
  objc_setAssociatedObject(target, kDeallocHookAssociation2, hook, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  return hook;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
  NSLog(@"%@", object);
}

- (void)dealloc
{
  NSLog(@"SWAG");
}

@end
