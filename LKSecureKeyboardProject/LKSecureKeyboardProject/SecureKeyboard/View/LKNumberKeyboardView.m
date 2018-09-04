//
//  LKNumberKeyboardView.m
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import "LKNumberKeyboardView.h"
#import "LKSecureKeyboardButton.h"//button
#import "LKCodeTools.h"//tools

@implementation LKNumberKeyboardView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/*!
 * update number keyboard
 */
- (void)updateValueOfKeyboard
{
    __weak typeof(self) weakSelf = self;
    __block CGFloat keyButton_x = 6*Standard;
    __block CGFloat keyButton_y = 49*Standard;
    [self.keyboardViewModel.keysModel.numbersArray enumerateObjectsUsingBlock:^(__kindof NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //get button, judge is there
        LKSecureKeyboardButton *keyButton = [strongSelf viewWithTag:KEYBOARD_BUTTON_TAG_START+idx];
        if (keyButton) {//update value
            UILabel *valueLabel = (UILabel *)[keyButton viewWithTag:SECURE_KEYBOARD_VALUE_TAG];
            if (valueLabel) {
                [valueLabel setText:obj];
            }
        }else {
            //set the value of x.y
            CGFloat width = 117*Standard;
            CGFloat height = 46*Standard;
            if ([obj isEqualToString:@"4"]) {//换行
                keyButton_y = keyButton_y+46*Standard+7*Standard;
                keyButton_x = 6*Standard;
            }
            if ([obj isEqualToString:@"7"]) {//换行
                keyButton_y = keyButton_y+46*Standard+7*Standard;
                keyButton_x = 6*Standard;
            }
            if ([[obj lowercaseString] isEqualToString:@"abc"]) {
                keyButton_y = keyButton_y+46*Standard+7*Standard;
                keyButton_x = 6*Standard;
            }
            
            keyButton = [[LKSecureKeyboardButton alloc] initWithFrame:CGRectMake(keyButton_x, keyButton_y, width, height)];
            keyButton.tag = KEYBOARD_BUTTON_TAG_START+idx;
            //set value
            UILabel *valueLabel = (UILabel *)[keyButton viewWithTag:SECURE_KEYBOARD_VALUE_TAG];
            if (valueLabel) {
                [valueLabel setHidden:NO];
                [valueLabel setText:obj];
            }
            
            //set special background color
            UIImageView *iconImageView = (UIImageView *)[keyButton viewWithTag:SECURE_KEYBOARD_ICON_TAG];
            if ([obj isEqualToString:@"abc"]) {
                keyButton.backgroundColor = [UIColor colorWithHex:0x8B8B8C];
            }else if ([obj isEqualToString:@"delete"]) {
                [valueLabel setHidden:YES];
                [iconImageView setHidden:NO];
                if (iconImageView) {
                    [iconImageView setImage:[UIImage imageNamed:@"secure_keyboard_delete_normal.png"]];
                }
                keyButton.backgroundColor = [UIColor colorWithHex:0x8B8B8C];
            }
            
            //block
            [keyButton setClickKeyboardBlock:^(NSInteger index) {
                //push to viewModel
                [strongSelf.keyboardViewModel clickKeyboardWithType:KEYBOARD_NUMBERS withClickIndex:index];
            }];
            [strongSelf addSubview:keyButton];
            
            keyButton_x = keyButton_x+(117+6)*Standard;
        }
    }];
}

#pragma mark - - Setter and Getter - -
- (void)setKeyboardViewModel:(LKSecureKeyboardViewModel *)keyboardViewModel
{
    _keyboardViewModel = keyboardViewModel;
    [self updateValueOfKeyboard];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
