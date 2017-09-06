//
//  NumberPad.m
//  NumberPad
//
//  Created by Jay on 2017/8/23.
//  Copyright © 2017年 jay. All rights reserved.
//

#import "NumberPad.h"

#define KeyboardLayerColor DEF_RGBA_COLOR(180, 180, 180, 1.0)
#define DEF_RGBA_COLOR(_red, _green, _blue, _alpha) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:(_alpha)]


@implementation NumberPad

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width / 3;
        CGFloat height = frame.size.height / 4;
        NSArray * array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0",@""];
        for (int i = 1; i < array.count + 1; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(((i - 1) % 3) * width, ((i - 1) / 3) * height, width, height);
            button.tag = i;
            [button setTitle:array[i - 1] forState:UIControlStateNormal];
            button.titleLabel.font =  [UIFont fontWithName:@"Georgia" size:25];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[self nf_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [button setBackgroundImage:[self nf_imageWithColor:[UIColor colorWithRed:231/255.0 green:232/255.0 blue:238/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(handler:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 10 || i == 12) {
                [button setBackgroundImage:[self nf_imageWithColor:[UIColor colorWithRed:231/255.0 green:232/255.0 blue:238/255.0 alpha:1.0]] forState:UIControlStateNormal];
                [button setBackgroundImage:[self nf_imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
            }
            if (i == 12) {
                [button setImage:[UIImage imageNamed:@"keyboard_delete"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
            }
            button.layer.borderColor = KeyboardLayerColor.CGColor;
            button.layer.borderWidth = 0.5;
            [self addSubview:button];
        }
    }
    return self;
}

-(void)handler:(UIButton *)sender
{
    NSLog(@"tag:%ld",(long)sender.tag);
    NSString *str = nil;
    if (sender.tag == 10) {
        str = @".";
    } else if (sender.tag == 11){
        str = @"0";
    }else if (sender.tag == 12){
        str = @"";
        [self deleteOneStringToTextField];
    }
    else {
        str = [NSString stringWithFormat:@"%ld",sender.tag];
    }
    
    //
    [self appendContentToTextField:str];

}

/**
 *  删除光标前面的字符
 */
- (void)deleteOneStringToTextField {
    NSMutableString *source = [_keyTextField.text mutableCopy];
    if ([source length] != 0) {
        // 1.获取光标所在位置
        UITextRange *selectedRange = [_keyTextField selectedTextRange];
        NSInteger offset = [_keyTextField offsetFromPosition:_keyTextField.beginningOfDocument toPosition:selectedRange.end];
        // 2.光标是否置于编辑框开始
        if (offset != 0) {
            NSRange backward = NSMakeRange(offset - 1, 1);
            [source deleteCharactersInRange:backward];
            _keyTextField.text = source;
            // 3.删除字符后，移动光标到新的位置
            UITextPosition *newPos = [_keyTextField positionFromPosition:_keyTextField.beginningOfDocument offset:offset - 2];
            _keyTextField.selectedTextRange = [_keyTextField textRangeFromPosition:newPos toPosition:newPos];
        }
    }
}

/**
 *  添加字符到编辑框末尾
 *
 *  @param appendString 添加的字符内容
 */
- (void)appendContentToTextField:(NSString *)appendString {
    
    // 1.获取光标所在位置
    UITextRange *selectedRange = [_keyTextField selectedTextRange];
    NSInteger offset = [_keyTextField offsetFromPosition:_keyTextField.beginningOfDocument toPosition:selectedRange.end];
    
    // 2.在光标当前位置后一个插入数字
    NSMutableString *contentString =  [[NSMutableString alloc] initWithString:_keyTextField.text];
    [contentString insertString:appendString atIndex:offset];
    
    // 3.添加字符后，移动光标到新的位置
    _keyTextField.text = contentString;
    UITextPosition *newPos = [_keyTextField positionFromPosition:_keyTextField.beginningOfDocument offset:offset + 1];
    _keyTextField.selectedTextRange = [_keyTextField textRangeFromPosition:newPos toPosition:newPos];
}

- (void)setKeyTextField:(UITextField *)keyTextField {
    _keyTextField = keyTextField;
}

- (UIImage *)nf_imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
