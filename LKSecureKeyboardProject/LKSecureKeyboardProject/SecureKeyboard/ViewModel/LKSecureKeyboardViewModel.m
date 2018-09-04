//
//  LKSecureKeyboardViewModel.m
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import "LKSecureKeyboardViewModel.h"
#import "LKCodeTools.h"//tools

@interface LKSecureKeyboardViewModel ()
{
    __block BOOL isLower;//YES:lower  NO:upper
}
@end

@implementation LKSecureKeyboardViewModel

#pragma mark - - Init Objects and Controls - -
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.keysModel  = [[LKSecureKeyboardModel alloc] init];
        isLower = YES;
    }
    return self;
}

#pragma mark - - Deal With Keyboard Text - -
/*!
 * 三种键盘模式下的按键被触发调用此方法来进行逻辑处理
 *
 * @param keyboard_type KEYBOARD_TYPE
 * @param click_index buttond's index
 */
- (void)clickKeyboardWithType:(KEYBOARD_TYPE)keyboard_type withClickIndex:(NSInteger)click_index
{
    switch (keyboard_type) {
        case KEYBOARD_CHARACTER:
        {
            //正常按键的下标
            NSInteger charIndex = click_index - KEYBOARD_BUTTON_TAG_START;
            NSString *charStr = @"";
            if (isLower) {
                charStr = [self.keysModel.characterLowerArray objectAtIndex:charIndex];
            }else {
                charStr = [self.keysModel.characterUpperArray objectAtIndex:charIndex];
            }
            if ([@"to_upper" isEqualToString:charStr]) {//切换为大写字母键盘
                isLower = NO;
                if ([self.characterUpdateProtocol respondsToSelector:@selector(updateValueOfKeyboardWithIsLower:)]) {
                    [self.characterUpdateProtocol updateValueOfKeyboardWithIsLower:isLower];
                }
            }else if ([@"to_lower" isEqualToString:charStr]) {//切换为小写字母键盘
                isLower = YES;
                if ([self.characterUpdateProtocol respondsToSelector:@selector(updateValueOfKeyboardWithIsLower:)]) {
                    [self.characterUpdateProtocol updateValueOfKeyboardWithIsLower:isLower];
                }
            }else if ([@"delete" isEqualToString:charStr]) {//delete
                [self deleteCharFormControl];
            }else if ([@"123" isEqualToString:charStr]) {//切换为数字键盘
                if ([self.switchKeyboardProtocol respondsToSelector:@selector(switchKeyboardWithType:)]) {
                    [self.switchKeyboardProtocol switchKeyboardWithType:KEYBOARD_NUMBERS];
                }
            }else if ([@"+ * #" isEqualToString:charStr]) {//切换为字符键盘
                if ([self.switchKeyboardProtocol respondsToSelector:@selector(switchKeyboardWithType:)]) {
                    [self.switchKeyboardProtocol switchKeyboardWithType:KEYBOARD_SYMBOL];
                }
            }else {//正常录入字符，进行拼接
                [self appendCharToControlText:charStr];
            }
        }
            break;
        case KEYBOARD_NUMBERS:
        {
            NSString *charStr = [self.keysModel.numbersArray objectAtIndex:click_index - KEYBOARD_BUTTON_TAG_START];
            
            if ([@"delete" isEqualToString:charStr]) {//delete
                [self deleteCharFormControl];
            }else if ([@"abc" isEqualToString:charStr]) {//切换为数字键盘
                if ([self.switchKeyboardProtocol respondsToSelector:@selector(switchKeyboardWithType:)]) {
                    [self.switchKeyboardProtocol switchKeyboardWithType:KEYBOARD_CHARACTER];
                }
            }else {
                [self appendCharToControlText:charStr];
            }
        }
            break;
        case KEYBOARD_SYMBOL:
        {
            NSString *charStr = [self.keysModel.symbolArray objectAtIndex:click_index - KEYBOARD_BUTTON_TAG_START];
            
            if ([@"delete" isEqualToString:charStr]) {//delete
                [self deleteCharFormControl];
            }else if ([@"123" isEqualToString:charStr]) {//切换为数字键盘
                if ([self.switchKeyboardProtocol respondsToSelector:@selector(switchKeyboardWithType:)]) {
                    [self.switchKeyboardProtocol switchKeyboardWithType:KEYBOARD_NUMBERS];
                }
            }else if ([@"abc" isEqualToString:charStr]) {//切换为字母键盘
                if ([self.switchKeyboardProtocol respondsToSelector:@selector(switchKeyboardWithType:)]) {
                    [self.switchKeyboardProtocol switchKeyboardWithType:KEYBOARD_CHARACTER];
                }
            }else {
                [self appendCharToControlText:charStr];
            }
        }
            break;
            
        default:
            break;
    }
}

/*!
 * delete char
 */
- (void)deleteCharFormControl
{
    if (self.textView) {
        NSString *controlText = self.textView.text;
        if (controlText.length > 0) {
            controlText = [controlText substringToIndex:controlText.length-1];
        }
        self.textView.text = controlText;
    }else if (self.textField) {
        NSString *controlText = self.textField.text;
        if (controlText.length > 0) {
            controlText = [controlText substringToIndex:controlText.length-1];
        }
        self.textField.text = controlText;
    }
}

/*!
 * append char
 *
 * @param insertChar the text of control
 */
- (void)appendCharToControlText:(NSString *)insertChar
{
    if (self.textView) {
        NSString *controlText = self.textView.text;
        controlText = [controlText stringByAppendingString:insertChar];
        self.textView.text = controlText;
    }else if (self.textField) {
        NSString *controlText = self.textField.text;
        controlText = [controlText stringByAppendingString:insertChar];
        self.textField.text = controlText;
    }
}

#pragma mark - - Setter and Getter - -
- (UITextView *)textView
{
    _textView = nil;
    id responder = [LKCodeTools resignTheFirstResponder];
    if ([responder isKindOfClass:[UITextView class]]) {
        _textView = (UITextView *)responder;
    }
    return _textView;
}

- (UITextField *)textField
{
    _textField = nil;
    id responder = [LKCodeTools resignTheFirstResponder];
    if ([responder isKindOfClass:[UITextField class]]) {
        _textField = (UITextField *)responder;
    }
    return _textField;
}
@end
