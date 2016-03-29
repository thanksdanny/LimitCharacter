//
//  ViewController.m
//  Limit Character
//
//  Created by Danny Ho on 3/27/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIView *bottomUIView;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetTextView.delegate = self;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.tweetTextView.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - textview Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *myTextViewStr = self.tweetTextView.text;
    self.characterCountLabel.text = [NSString stringWithFormat:@"%lu", (140 - myTextViewStr.length)];
    if (range.length > 140) {
        return NO;
    }
    NSUInteger newLength = myTextViewStr.length + range.length;
    
    return newLength < 140;
}

- (void)keyboardWillShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSLog(@"%@", userInfo);
    // 获取键盘信息
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    // 获得默认动画显示的时间间隔
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    // 设置动画，调整整个textView的frame
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.tweetTextView.frame = newTextViewFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)note {
    
}

@end
