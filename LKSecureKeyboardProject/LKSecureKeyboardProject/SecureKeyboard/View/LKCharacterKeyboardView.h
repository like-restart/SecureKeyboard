//
//  LKCharacterKeyboardView.h
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//  字符键盘

#import <UIKit/UIKit.h>
#import "LKSecureKeyboardRootView.h"//root
#import "LKSecureKeyboardViewModel.h"//view model

@interface LKCharacterKeyboardView : LKSecureKeyboardRootView

@property (nonatomic, readwrite, strong) LKSecureKeyboardViewModel *keyboardViewModel;

@end
