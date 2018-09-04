//
//  LKSecureKeyboardView.m
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import "LKSecureKeyboardView.h"
#import "LKSecureKeyboardViewModel.h"//view model

#import "LKCodeTools.h"//tools

@interface LKSecureKeyboardView () <SecureKeyboardSwitchProtocol>
{
    BOOL isSecureKeyboard;//YES:use the secure NO:don't use the secure
}
@property (strong, nonatomic) LKSecureKeyboardViewModel *keyboardViewModel;
@end

static LKSecureKeyboardView *secureKeyboardView = nil;
@implementation LKSecureKeyboardView
/**
 get the secure keyboard object

 @return LKSecureKeyboardView
 */
+ (LKSecureKeyboardView *)loadSecureKeyboard
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!secureKeyboardView) {
            secureKeyboardView = [[LKSecureKeyboardView alloc] init];
            
            [[NSNotificationCenter defaultCenter] addObserver:secureKeyboardView selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:secureKeyboardView selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
            
            //register notification - 键盘右上角的关闭按钮
            [[NSNotificationCenter defaultCenter] addObserver:secureKeyboardView selector:@selector(hiddenSecureKeyboard) name:HIDDEN_SECURE_KEYBOARD_NOTIFICATION object:nil];
        }
    });
    return secureKeyboardView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, MainScreenHeight-259*Standard-bottomXHeight, MainScreenWidth, 259*Standard+bottomXHeight);
    }
    return self;
}

#pragma mark - - Switch Keyboard Protocol - -
- (void)switchKeyboardWithType:(KEYBOARD_TYPE)keyboard_type
{
    switch (keyboard_type) {
        case KEYBOARD_CHARACTER:
        {
            [self.characterView setHidden:NO];
            [self.symbolView setHidden:YES];
            [self.numberView setHidden:YES];
        }
            break;
        case KEYBOARD_NUMBERS:
        {
            [self.characterView setHidden:YES];
            [self.symbolView setHidden:YES];
            [self.numberView setHidden:NO];
        }
            break;
        case KEYBOARD_SYMBOL:
        {
            [self.characterView setHidden:YES];
            [self.symbolView setHidden:NO];
            [self.numberView setHidden:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - - UIKeyboad Notification Methods - -
/*！
 * SecureKeyboard will be hide, set secureKeyboardView to nil
 */
- (void)keyboardWillHide:(NSNotification*)aNotification
{
    //if YES
    if (isSecureKeyboard) {
        if (self.keyboardViewModel.textField) {
            self.keyboardViewModel.textField = nil;
        }else if (self.keyboardViewModel.textView) {
            self.keyboardViewModel.textView = nil;
        }
        //restore NO
        isSecureKeyboard = NO;
    }
}

/*!
 * SecureKeyboard will be show, get the control.keyboardType and set the secureKeyboard's type
 */
-(void)keyboardWillShow:(NSNotification*)aNotification
{
    //set YES
    isSecureKeyboard = YES;
    if (self.keyboardViewModel.textView) {
        if (UIKeyboardTypePhonePad == self.keyboardViewModel.textView.keyboardType) {
            [self switchKeyboardWithType:KEYBOARD_NUMBERS];
        }else {
            [self switchKeyboardWithType:KEYBOARD_CHARACTER];
        }
    }else if (self.keyboardViewModel.textField) {
        if (UIKeyboardTypePhonePad == self.keyboardViewModel.textField.keyboardType) {
            [self switchKeyboardWithType:KEYBOARD_NUMBERS];
        }else {
            [self switchKeyboardWithType:KEYBOARD_CHARACTER];
        }
    }
}

/*!
 * click the close button and hidden secure keyboard view
 */
- (void)hiddenSecureKeyboard
{
    if (self.keyboardViewModel.textField) {
        [self.keyboardViewModel.textField resignFirstResponder];
    }else if (self.keyboardViewModel.textView) {
        [self.keyboardViewModel.textView resignFirstResponder];
    }
}


#pragma mark - - Setter and Getter - -
- (LKCharacterKeyboardView *)characterView
{
    if (!_characterView) {
        _characterView = [[LKCharacterKeyboardView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _characterView.keyboardViewModel = self.keyboardViewModel;
        [_characterView setHidden:YES];
        [self addSubview:_characterView];
    }
    return _characterView;
}

- (LKSymbolKeyboardView *)symbolView
{
    if (!_symbolView) {
        _symbolView = [[LKSymbolKeyboardView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _symbolView.keyboardViewModel = self.keyboardViewModel;
        [_symbolView setHidden:YES];
        [self addSubview:_symbolView];
    }
    return _symbolView;
}

- (LKNumberKeyboardView *)numberView
{
    if (!_numberView) {
        _numberView = [[LKNumberKeyboardView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _numberView.keyboardViewModel = self.keyboardViewModel;
        [_numberView setHidden:YES];
        [self addSubview:_numberView];
    }
    return _numberView;
}

- (LKSecureKeyboardViewModel *)keyboardViewModel
{
    if (!_keyboardViewModel) {
        _keyboardViewModel = [[LKSecureKeyboardViewModel alloc] init];
        _keyboardViewModel.switchKeyboardProtocol = self;
    }
    return _keyboardViewModel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
