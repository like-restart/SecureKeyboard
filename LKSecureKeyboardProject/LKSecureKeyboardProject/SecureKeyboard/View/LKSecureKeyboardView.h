//
//  LKSecureKeyboardView.h
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKSymbolKeyboardView.h"//symbol
#import "LKCharacterKeyboardView.h"//character
#import "LKNumberKeyboardView.h"//number

@interface LKSecureKeyboardView : UIView
@property (strong, nonatomic) LKSymbolKeyboardView *symbolView;
@property (strong, nonatomic) LKCharacterKeyboardView *characterView;
@property (strong, nonatomic) LKNumberKeyboardView *numberView;

/**
 get the secure keyboard object
 
 @return LKSecureKeyboardView
 */
+ (LKSecureKeyboardView *)loadSecureKeyboard;

@end
