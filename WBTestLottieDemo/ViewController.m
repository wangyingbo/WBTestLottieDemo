//
//  ViewController.m
//  WBTestLottieDemo
//
//  Created by yingbo5 on 2023/3/20.
//

#import "ViewController.h"
#import "YBTestLottieViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    YBTestLottieViewController *lottieVC = [[YBTestLottieViewController alloc] init];
    [self.navigationController pushViewController:lottieVC animated:YES];
}

@end
