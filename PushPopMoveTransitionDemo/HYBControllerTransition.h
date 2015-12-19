//
//  HYBControllerTransition.h
//  PushPopMoveTransitionDemo
//
//  Created by huangyibiao on 15/12/18.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HYBControllerTransitionType) {
  kControllerTransitionPush = 1 << 1,
  kControllerTransitionPop = 1 << 2
};

@interface HYBControllerTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(HYBControllerTransitionType)transitionType
                          duration:(NSTimeInterval)duration;

@end
