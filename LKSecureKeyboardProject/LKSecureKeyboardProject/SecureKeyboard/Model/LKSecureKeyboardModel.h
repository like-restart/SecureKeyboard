//
//  LKSecureKeyboardModel.h
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKSecureKeyboardModel : NSObject
@property (strong, nonatomic) NSArray *characterLowerArray;//小写字母键盘按键数组
@property (strong, nonatomic) NSArray *characterUpperArray;//大写字母键盘按键数组
@property (strong, nonatomic) NSArray *numbersArray;//数字键盘按键数组
@property (strong, nonatomic) NSArray *symbolArray;//符号键盘按键数组
@end
