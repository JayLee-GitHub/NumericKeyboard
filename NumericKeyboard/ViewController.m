//
//  ViewController.m
//  NumericKeyboard
//
//  Created by Jay on 2017/9/6.
//  Copyright © 2017年 jay. All rights reserved.
//

#import "ViewController.h"
#import "NumberPad.h"


#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define DEF_RGBA_COLOR(_red, _green, _blue, _alpha) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:(_alpha)]

/**
 *  屏幕适配比例
 */
#define SCREEN_SIZE_SCALE DEF_SCREEN_WIDTH / 375
#define BackgroundColor DEF_RGBA_COLOR(231, 232, 238, 1.0)


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *Tf;

@end

@implementation ViewController

//如果使用了遮挡键盘IQKeyboardManager这个第三方，需要这些代码
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:YES];
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    [[IQKeyboardManager sharedManager] setEnable:NO];
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
//    
//    [self.amountTf becomeFirstResponder];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = BackgroundColor;
    
    //获取焦点
    [self.Tf becomeFirstResponder];
    
    //隐藏系统键盘
    self.Tf.inputView = [[UIView alloc] init];
    self.Tf.inputView.hidden = YES;
    
    //使用方法
    CGFloat padHeight = 240 * SCREEN_SIZE_SCALE;
    NumberPad *pad = [[NumberPad alloc] initWithFrame:CGRectMake(0, DEF_SCREEN_HEIGHT- padHeight,DEF_SCREEN_WIDTH,padHeight)];
    pad.keyTextField = self.Tf;
    [self.view addSubview:pad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
