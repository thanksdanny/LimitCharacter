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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
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

- (void)keyboardWillShow {
    
}

- (void)keyboardWillHide {
    
}


@end
