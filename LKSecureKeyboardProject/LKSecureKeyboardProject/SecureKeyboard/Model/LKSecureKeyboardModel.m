//
//  LKSecureKeyboardModel.m
//  LKSecureKeyboardProject
//
//  Created by like on 2018/6/1.
//  Copyright © 2018年 No Company. All rights reserved.
//

#import "LKSecureKeyboardModel.h"

@implementation LKSecureKeyboardModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.characterLowerArray = [NSArray arrayWithObjects:@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"to_upper",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"delete",@"123",@".",@",",@"?",@"!",@"@",@"+ * #", nil];
        
        self.characterUpperArray = [NSArray arrayWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"to_lower",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"delete",@"123",@".",@",",@"?",@"!",@"@",@"+ * #", nil];
        
        self.numbersArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"abc", @"0", @"delete", nil];
        
        self.symbolArray = [NSArray arrayWithObjects:@"*", @"#", @"$", @"%", @"^", @"&", @"(", @")", @"\'", @"\"", @"=", @"_", @":", @";", @"~", @"|", @"丶", @"ㆍ", @"+", @"-", @"<", @">", @"\\", @"/", @"[", @"]", @"{", @"}", @"delete", @"123", @".", @",", @"?", @"!", @"@", @"abc", nil];
    }
    return self;
}

@end
