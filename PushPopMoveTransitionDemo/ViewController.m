//
//  ViewController.m
//  PushPopMoveTransitionDemo
//
//  Created by huangyibiao on 15/12/18.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "DetailController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
  [self.img1 addGestureRecognizer:tap];
  
  tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
  [self.img2 addGestureRecognizer:tap];
}

- (void)onTap:(UITapGestureRecognizer *)sender {
  DetailController *vc = [[DetailController alloc] init];
  vc.image = [(UIImageView *)sender.view image];
  
  if (sender.view == self.img1) {
    self.isImg1 = YES;
  } else {
    self.isImg1 = NO;
  }
  self.navigationController.delegate = vc;
  [self.navigationController pushViewController:vc animated:YES];
}

@end
