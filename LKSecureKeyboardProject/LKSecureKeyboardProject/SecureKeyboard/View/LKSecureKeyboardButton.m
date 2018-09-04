//
//  LKSecureKeyboardButton.m
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import "LKSecureKeyboardButton.h"
#import "LKCodeTools.h"//tools
#import <AudioToolbox/AudioServices.h>//按键声音

@implementation LKSecureKeyboardButton

/*!
 * init keyboard according to type
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUsualButton];
    }
    return self;
}

/*!
 * 创建单个键盘按钮
 */
- (void)layoutUsualButton
{
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    textLabel.tag = SECURE_KEYBOARD_VALUE_TAG;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [LKCodeTools getContentFont:@"PingFangSC-Regular" withContentSize:25*Standard];
    textLabel.textColor = [UIColor colorWithHex:0xFFFFFF];
    [self addSubview:textLabel];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.frame = CGRectMake((self.frame.size.width-20*Standard)/2, (self.frame.size.height-18*Standard)/2, 20*Standard, 18*Standard);
    iconImageView.tag = SECURE_KEYBOARD_ICON_TAG;
    [self addSubview:iconImageView];
    
    self.backgroundColor = [UIColor colorWithHex:0x686868];
    //set corner
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    
    [self addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(clickButtonDownAction:) forControlEvents:UIControlEventTouchDown];
}


#pragma mark - - event area - -
- (void)clickButtonAction:(id)sender
{
    UIButton *upButton = (UIButton *)sender;
    //recovery the normal color
    if ([upButton.backgroundColor isEqual:[UIColor colorWithHex:0x434343]]) {
        [upButton setBackgroundColor:[UIColor colorWithHex:0x686868]];
    }else if ([upButton.backgroundColor isEqual:[UIColor colorWithHex:0x767676]]) {
        [upButton setBackgroundColor:[UIColor colorWithHex:0x434343]];
    }else if ([upButton.backgroundColor isEqual:[UIColor colorWithHex:0x686868]]) {
        [upButton setBackgroundColor:[UIColor colorWithHex:0x8B8B8C]];
    }
    
    [self setDeleteIcon:upButton withHighlighted:NO];
    
    AudioServicesPlaySystemSound(1105);
    if (self.clickKeyboardBlock) {
        self.clickKeyboardBlock([sender tag]);
    }
}

- (void)clickButtonDownAction:(id)sender
{
    UIButton *downButton = (UIButton *)sender;
    //change the Highlighted
    if ([downButton.backgroundColor isEqual:[UIColor colorWithHex:0x686868]]) {
        [downButton setBackgroundColor:[UIColor colorWithHex:0x434343]];
    }else if ([downButton.backgroundColor isEqual:[UIColor colorWithHex:0x434343]]) {
        [downButton setBackgroundColor:[UIColor colorWithHex:0x767676]];
    }else if ([downButton.backgroundColor isEqual:[UIColor colorWithHex:0x8B8B8C]]) {
        [downButton setBackgroundColor:[UIColor colorWithHex:0x686868]];
    }
    [self setDeleteIcon:downButton withHighlighted:YES];
}


/*!
 * change the button icon according to the value of delete
 *
 * @param downButton click button
 * @param isHighlighted YES | NO
 */
- (void)setDeleteIcon:(UIButton *)downButton withHighlighted:(BOOL)isHighlighted
{
    UILabel *textLabel = [downButton viewWithTag:SECURE_KEYBOARD_VALUE_TAG];
    if (textLabel && [textLabel.text isEqualToString:@"delete"]) {
        UIImageView *iconImageView = (UIImageView *)[downButton viewWithTag:SECURE_KEYBOARD_ICON_TAG];
        if (iconImageView) {
            [iconImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"secure_keyboard_delete_%@.png",isHighlighted?@"highlighted":@"normal"]]];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
