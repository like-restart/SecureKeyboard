//
//  LKSecureKeyboardViewModel.h
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LKSecureKeyboardModel.h"//model

#define KEYBOARD_BUTTON_TAG_START 100
#define HIDDEN_SECURE_KEYBOARD_NOTIFICATION @"HIDDEN_SECURE_KEYBOARD_NOTIFICATION"
/*!
 * 键盘的三种类型及键盘上关键按钮的类型
 */
typedef NS_OPTIONS(NSUInteger, KEYBOARD_TYPE)
{
    /*!字母按键*/
    KEYBOARD_CHARACTER = 1000,
    /*!字母键盘-大小写转换*/
    KEYBOARD_CHARACTER_TEXT_TRANSFORM = 1001,
    /*!字母键盘-删除按键*/
    KEYBOARD_CHARACTER_DELETE = 1002,
    /*!字母键盘-数字转换按键*/
    KEYBOARD_CHARACTER_NUMBERS_TRANSFORM = 1003,
    /*!字母键盘-字符转换按键*/
    KEYBOARD_CHARACTER_SYMBOL_TRANSFORM = 1004,
    
    /*!数字按键*/
    KEYBOARD_NUMBERS = 2000,
    /*!数字键盘-字母转换按键*/
    KEYBOARD_NUMBERS_CHARACTER_TRANSFORM = 2001,
    /*!数字键盘-删除按键*/
    KEYBOARD_NUMBERS_DELETE = 2002,
    
    /*!字符按键*/
    KEYBOARD_SYMBOL = 3000,
    /*!字符键盘-删除按键*/
    KEYBOARD_SYMBOL_DELETE = 3001,
    /*!字符键盘-数字转换按键*/
    KEYBOARD_SYMBOL_NUMBERS_TRANSFORM = 3002,
    /*!字符键盘-字母转换按键*/
    KEYBOARD_SYMBOL_CHARACTER_TRANSFORM = 3003,
};

@protocol SecureKeyboardUpdateProtocol <NSObject>
/*!
 * update character and number and symbol keyboard
 *
 * @param isLower YES:Lower   NO:upper (applicable to character keyboard)
 */
- (void)updateValueOfKeyboardWithIsLower:(BOOL)isLower;
@end

/*!
 * 三种键盘模式互相切换代理
 */
@protocol SecureKeyboardSwitchProtocol <NSObject>
/*!
 * To switch the keyboard
 *
 * @param keyboard_type KEYBOARD_TYPE
 */
- (void)switchKeyboardWithType:(KEYBOARD_TYPE)keyboard_type;
@end

@interface LKSecureKeyboardViewModel : NSObject
@property (strong, nonatomic) LKSecureKeyboardModel *keysModel;
//能够触发安全键盘的控件
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UITextView *textView;

//代理变量
@property (nonatomic, readwrite, assign) id<SecureKeyboardUpdateProtocol> characterUpdateProtocol;

//键盘切换代理变量
@property (nonatomic, readwrite, assign) id<SecureKeyboardSwitchProtocol> switchKeyboardProtocol;
/*!
 * 三种键盘模式下的按键被触发调用此方法来进行逻辑处理
 *
 * @param keyboard_type KEYBOARD_TYPE
 * @param click_index buttond's index
 */
- (void)clickKeyboardWithType:(KEYBOARD_TYPE)keyboard_type withClickIndex:(NSInteger)click_index;
@end
