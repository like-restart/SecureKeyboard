//
//  LKSecureKeyboardRootView.m
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import "LKSecureKeyboardRootView.h"
#import "LKSecureKeyboardViewModel.h"//view model
#import "LKCodeTools.h"//tools

@implementation LKSecureKeyboardRootView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutTopView];
    }
    return self;
}

/*!
 * 创建键盘的头部视图
 */
- (void)layoutTopView
{
    UIView *backView = [[UIView alloc] init];
    backView.frame = self.frame;
    backView.backgroundColor = [UIColor colorWithHex:0x282828];
    [self addSubview:backView];
    
    //company icon
//    UIImageView *companyIconView = [[UIImageView alloc] init];
//    companyIconView.frame = CGRectMake(8*Standard, 10*Standard, 66*Standard, 21*Standard);
//    companyIconView.image = [UIImage imageNamed:@"secure_keyboard_company_icon.png"];
//    [self addSubview:companyIconView];
    
    //or
    
    //company title
    UILabel *companyLabel = [[UILabel alloc] init];
    companyLabel.frame = CGRectMake(8*Standard, 10*Standard, 66*Standard, 21*Standard);
    companyLabel.text = @"公司";
    companyLabel.font = [UIFont systemFontOfSize:15*Standard];
    companyLabel.textColor = [UIColor colorWithHex:0x49A5FF];
    [self addSubview:companyLabel];
    
    //secure icon
    UIImageView *secureIconView = [[UIImageView alloc] init];
    secureIconView.frame = CGRectMake(103*Standard, 11*Standard, 16*Standard, 18*Standard);
    secureIconView.image = [UIImage imageNamed:@"secure_keyboard_safe_icon.png"];
    [self addSubview:secureIconView];
    
    //secure title
    UILabel *secureTitleLabel = [[UILabel alloc] init];
    secureTitleLabel.frame = CGRectMake(127*Standard, 13*Standard, 139*Standard, 16*Standard);
    secureTitleLabel.text = @"安全输入键盘";
    secureTitleLabel.font = [LKCodeTools getContentFont:@"PingFangSC-Regular" withContentSize:15*Standard];
    secureTitleLabel.textColor = [UIColor colorWithHex:0x49A5FF];
    [self addSubview:secureTitleLabel];
    
    UIButton *hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hiddenButton.frame = CGRectMake(self.frame.size.width-43*Standard, 0, 43*Standard, 42*Standard);
    [hiddenButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *hiddenImage = [[UIImageView alloc] init];
    hiddenImage.frame = CGRectMake(16*Standard, 16*Standard, 13*Standard, 10*Standard);
    [hiddenImage setImage:[UIImage imageNamed:@"secure_keyboard_hidden_icon.png"]];
    [hiddenButton addSubview:hiddenImage];
    [self addSubview:hiddenButton];
}

#pragma mark - - event area - -
- (void)clickButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HIDDEN_SECURE_KEYBOARD_NOTIFICATION object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
