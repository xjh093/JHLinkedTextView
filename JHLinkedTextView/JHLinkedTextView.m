//
//  JHLinkedTextView.m
//  JHKit
//
//  Created by HaoCold on 2018/8/23.
//  Copyright © 2018年 HaoCold. All rights reserved.
//

#import "JHLinkedTextView.h"

@interface JHLinkedTextView()<UITextViewDelegate>
@property (nonatomic,  strong) NSMutableDictionary *blockDic;

@end

@implementation JHLinkedTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.editable = NO;
        self.scrollEnabled = NO;
        _blockDic = @{}.mutableCopy;
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
    if (newSuperview) {
        [newSuperview addSubview:[[UIView alloc] init]];
    }
}

- (void)setLinkedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font withTapEvent:(dispatch_block_t)block{
    
    if (!font) {
        font = self.font;
    }
    [self setAttributedText:text color:color font:font];
    
    NSMutableAttributedString *mattStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [mattStr addAttribute:NSLinkAttributeName value:[text stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] range:[mattStr.string rangeOfString:text]];
    
    self.attributedText = mattStr;
    
    CGRect frame = self.frame;
    frame.size = [self sizeThatFits:self.bounds.size];
    self.frame = frame;
    
    if (text && block) {
        [_blockDic setValue:block forKey:text];
    }
}

- (void)setText:(NSString *)text{
    [super setText:text];
    
    [self setAttributedText:text color:self.textColor font:self.font];
}

- (void)setTextColor:(UIColor *)textColor{
    [super setTextColor:textColor];
    
    [self setAttributedText:self.text color:textColor font:self.font];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    
    [self setAttributedText:self.text color:self.textColor font:font];
}

- (void)setAttributedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    if (text && color && font) {
        NSAttributedString *attributedString = self.attributedText?:[[NSAttributedString alloc] initWithString:self.text?:@""];
        if (attributedString.length > 0) {
            NSMutableAttributedString *mattStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
            
            [mattStr addAttribute:NSForegroundColorAttributeName value:color range:[attributedString.string rangeOfString:text]];
    
            [mattStr addAttribute:NSFontAttributeName value:font range:[attributedString.string rangeOfString:text]];
            
            self.attributedText = mattStr;
        }
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    [self canInvoke:URL];
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    [self canInvoke:URL];
    return NO;
}

- (void)canInvoke:(NSURL *)URL
{
    dispatch_block_t block = [_blockDic valueForKey:[URL.absoluteString stringByRemovingPercentEncoding]];
    if (block) {
        block();
    }
}

@end
