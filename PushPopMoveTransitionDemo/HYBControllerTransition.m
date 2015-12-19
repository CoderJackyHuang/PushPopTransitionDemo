//
//  HYBControllerTransition.m
//  PushPopMoveTransitionDemo
//
//  Created by huangyibiao on 15/12/18.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "HYBControllerTransition.h"
#import "ViewController.h"
#import "DetailController.h"

@interface HYBControllerTransition ()

@property (nonatomic, assign) HYBControllerTransitionType transitionType;
@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation HYBControllerTransition

- (instancetype)init {
  if (self = [super init]) {
    self.transitionType = kControllerTransitionPush;
  }
  
  return self;
}

+ (instancetype)transitionWithType:(HYBControllerTransitionType)transitionType
                          duration:(NSTimeInterval)duration {
  HYBControllerTransition *transition = [[HYBControllerTransition alloc] init];
  transition.transitionType = transitionType;
  transition.duration = duration;
  
  return transition;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  switch (self.transitionType) {
    case kControllerTransitionPush: {
      [self push:transitionContext];
      break;
    }
    case kControllerTransitionPop: {
      [self pop:transitionContext];
      break;
    }
    default: {
      break;
    }
  }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return self.duration;
}

- (void)animationEnded:(BOOL)transitionCompleted {
  NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Private
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
  DetailController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *containerView = [transitionContext containerView];
 
  UIView *toImageView = toVC.isImg1 ? toVC.img1 : toVC.img2;
  
  UIView *tempView = containerView.subviews.lastObject;
  
  // 第一个view是fromVC.view
  // 第二个view是push进来时所生成的toImageView截图
  for (UIView *view in containerView.subviews) {
    NSLog(@"%@", view);
    if (fromVC.view == view) {
      NSLog(@"YES");
    }
  }
  
  toImageView.hidden = YES;
  tempView.hidden = NO;
  // 必须保证将toVC.view放在最上面，也就是第一个位置
  [containerView insertSubview:toVC.view atIndex:0];

  [UIView animateWithDuration:self.duration
                        delay:0.0
       usingSpringWithDamping:0.55
        initialSpringVelocity:1/ 0.55
                      options:0
                   animations:^{
                     fromVC.view.alpha = 0.0;
                     tempView.frame = [toImageView convertRect:toImageView.bounds toView:containerView];
  } completion:^(BOOL finished) {
    tempView.hidden = NO;
    toImageView.hidden = NO;
    [tempView removeFromSuperview];
    
    [transitionContext completeTransition:YES];
    
    for (UIView *view in containerView.subviews) {
      NSLog(@"%@", view);
      if (toVC.view == view) {
        NSLog(@"YES");
      }
    }
  }];
}

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
  ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  DetailController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *containerView = [transitionContext containerView];
  
  UIView *fromImageView = fromVC.isImg1 ? fromVC.img1 : fromVC.img2;
  UIView *tempView = [fromImageView snapshotViewAfterScreenUpdates:NO];
  tempView.frame = [fromImageView convertRect:fromImageView.bounds toView:containerView];
 
  UIView *toImageView = toVC.imgView;
  
  fromImageView.hidden = YES;
  toVC.view.alpha = 0.0;
  toImageView.hidden = YES;
  
  [containerView addSubview:toVC.view];
  [containerView addSubview:tempView];
  
  [UIView animateWithDuration:self.duration
                        delay:0.0
       usingSpringWithDamping:0.55
        initialSpringVelocity:1/ 0.55
                      options:0
                   animations:^{
                     toVC.view.alpha = 1.0;
                     tempView.frame = [toImageView convertRect:toImageView.bounds toView:containerView];
                   } completion:^(BOOL finished) {
                     tempView.hidden = YES;
                     toImageView.hidden = NO;

                     [transitionContext completeTransition:YES];
                   }];
}
@end
