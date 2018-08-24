//
//  JHLinkedTextView.h
//  JHKit
//
//  Created by HaoCold on 2018/8/23.
//  Copyright © 2018年 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHLinkedTextView : UITextView

- (void)setLinkedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font withTapEvent:(dispatch_block_t)block;

@end
