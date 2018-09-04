//
//  LKCharacterKeyboardView.m
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import "LKCharacterKeyboardView.h"
#import "LKSecureKeyboardButton.h"//button
#import "LKCodeTools.h"//tools

@interface LKCharacterKeyboardView () <SecureKeyboardUpdateProtocol>

@end

@implementation LKCharacterKeyboardView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*!
 * update character keyboard
 *
 * @param isLower YES:Lower   NO:upper
 */
- (void)updateValueOfKeyboardWithIsLower:(BOOL)isLower
{
    __weak typeof(self) weakSelf = self;
    NSArray *tmpArray = nil;
    if (isLower) {
        tmpArray = [NSArray arrayWithArray:self.keyboardViewModel.keysModel.characterLowerArray];
    }else {
        tmpArray = [NSArray arrayWithArray:self.keyboardViewModel.keysModel.characterUpperArray];
    }
    __block CGFloat keyButton_x = 3*Standard;
    __block CGFloat keyButton_y = 49*Standard;
    [tmpArray enumerateObjectsUsingBlock:^(__kindof NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //get button, judge is there
        LKSecureKeyboardButton *keyButton = [strongSelf viewWithTag:KEYBOARD_BUTTON_TAG_START+idx];
        if (keyButton) {//update value
            UILabel *valueLabel = (UILabel *)[keyButton viewWithTag:SECURE_KEYBOARD_VALUE_TAG];
            if (valueLabel) {
                [valueLabel setText:obj];
            }
            UIImageView *iconImageView = (UIImageView *)[keyButton viewWithTag:SECURE_KEYBOARD_ICON_TAG];
            if ([obj isEqualToString:@"to_upper"]) {
                if (iconImageView) {
                    [iconImageView setImage:[UIImage imageNamed:@"secure_keyboard_upper_normal.png"]];
                }
                keyButton.backgroundColor = [UIColor colorWithHex:0x434343];
            }else if ([obj isEqualToString:@"to_lower"]) {
                if (iconImageView) {
                    [iconImageView setImage:[UIImage imageNamed:@"secure_keyboard_upper_highlighted.png"]];
                }
                keyButton.backgroundColor = [UIColor colorWithHex:0x767676];
            }
        }else {
            //set the value of x.y
            CGFloat width = 32*Standard;
            CGFloat height = 42*Standard;
            if ([[obj lowercaseString] isEqualToString:@"a"]) {//换行
                keyButton_y = keyButton_y+42*Standard+12*Standard;
                keyButton_x = 22*Standard;
            }
            if ([obj isEqualToString:@"to_upper"] || [obj isEqualToString:@"to_lower"]) {
                keyButton_x = 3*Standard;
                keyButton_y = keyButton_y+42*Standard+12*Standard;
                width = 42*Standard;
            }
            if ([[obj lowercaseString] isEqualToString:@"z"]) {//x坐标特殊处理
                keyButton_x = 59*Standard;
            }
            if ([obj isEqualToString:@"delete"]) {//x坐标特殊处理
                keyButton_x = strongSelf.frame.size.width-(42+3)*Standard;
                width = 42*Standard;
            }
            if ([obj isEqualToString:@"123"]) {//最后一行间隔为10
                keyButton_x = 3*Standard;
                keyButton_y = keyButton_y+42*Standard+10*Standard;
                width = 85*Standard;
            }
            if ([obj isEqualToString:@"."]) {//x坐标特殊处理
                keyButton_x = 97*Standard;
            }
            if (idx == tmpArray.count-1) {//the last one
                keyButton_x = strongSelf.frame.size.width-(88+3)*Standard;
                width = 88*Standard;
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
            [iconImageView setHidden:YES];
            if ([obj isEqualToString:@"to_upper"]) {
                keyButton.backgroundColor = [UIColor colorWithHex:0x434343];
                [valueLabel setHidden:YES];
                [iconImageView setHidden:NO];
                if (iconImageView) {
                    [iconImageView setImage:[UIImage imageNamed:@"secure_keyboard_upper_normal.png"]];
                }
            }else if ([obj isEqualToString:@"to_lower"]) {
                [valueLabel setHidden:YES];
                [iconImageView setHidden:NO];
                if (iconImageView) {
                    [iconImageView setImage:[UIImage imageNamed:@"secure_keyboard_upper_highlighted.png"]];
                }
                keyButton.backgroundColor = [UIColor colorWithHex:0x767676];
            }else if ([obj isEqualToString:@"delete"]) {
                [valueLabel setHidden:YES];
                [iconImageView setHidden:NO];
                if (iconImageView) {
                    [iconImageView setImage:[UIImage imageNamed:@"secure_keyboard_delete_normal.png"]];
                }
                keyButton.backgroundColor = [UIColor colorWithHex:0x434343];
            }else if ([obj isEqualToString:@"123"] || idx == tmpArray.count-1) {
                keyButton.backgroundColor = [UIColor colorWithHex:0x434343];
            }
            
            //set special font size
            if ([obj isEqualToString:@"123"]) {
                [valueLabel setFont:[LKCodeTools getContentFont:@"PingFangSC-Regular" withContentSize:20*Standard]];
            }else if (idx >= 29 && idx <= 33) {
                [valueLabel setFont:[LKCodeTools getContentFont:@"PingFangSC-Regular" withContentSize:18*Standard]];
            }else if (idx == tmpArray.count-1) {
                [valueLabel setFont:[LKCodeTools getContentFont:@"PingFangSC-Regular" withContentSize:16*Standard]];
            }
            //block
            [keyButton setClickKeyboardBlock:^(NSInteger index) {
                //push to viewModel
                [strongSelf.keyboardViewModel clickKeyboardWithType:KEYBOARD_CHARACTER withClickIndex:index];
            }];
            [strongSelf addSubview:keyButton];
            
            if (idx <= 9 || (idx >= 29 && idx <= 33)) {//x坐标特殊处理
                keyButton_x = keyButton_x+(32+5)*Standard;
            }else {
                keyButton_x = keyButton_x+(32+6)*Standard;
            }
        }
    }];
}

#pragma mark - - Setter and Getter - -
- (void)setKeyboardViewModel:(LKSecureKeyboardViewModel *)keyboardViewModel
{
    _keyboardViewModel = keyboardViewModel;
    _keyboardViewModel.characterUpdateProtocol = self;
    [self updateValueOfKeyboardWithIsLower:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
