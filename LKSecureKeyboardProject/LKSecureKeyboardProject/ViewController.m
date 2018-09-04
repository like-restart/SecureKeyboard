//
//  ViewController.m
//  LKSecureKeyboardProject
//
//  Created by like on 2018/9/3.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import "ViewController.h"

#import "LKSecureKeyboardView.h"//secure keyboard view

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //test code
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    textView.inputView = [LKSecureKeyboardView loadSecureKeyboard];//关键代码:inputView为显示键盘的view,重新对此赋值新的UIView，则这个view则不再弹出系统键盘,而是弹出自己的view
    textView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:textView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
    textField.inputView = [LKSecureKeyboardView loadSecureKeyboard];
    textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:textField];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
