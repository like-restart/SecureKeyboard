//
//  LKSecureKeyboardButton.h
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#define SECURE_KEYBOARD_VALUE_TAG 1100
#define SECURE_KEYBOARD_ICON_TAG 1200

#import <UIKit/UIKit.h>


/**
 keyboard click block

 @param index the index of button
 */
typedef void(^ClickKeyboardBlock)(NSInteger index);

@interface LKSecureKeyboardButton : UIButton
@property (copy, nonatomic) ClickKeyboardBlock clickKeyboardBlock;
@end
