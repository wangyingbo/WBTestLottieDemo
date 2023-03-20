//
//  YBTestLottieViewController.m
//  WBTestDemo
//
//  Created by yingbo5 on 2022/12/29.
//

#import "YBTestLottieViewController.h"
#import "Lottie-Swift.h"
#import "WBVideoLottieHelper.h"

#define FULL_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define FULL_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface YBTestLottieViewController ()
@property (nonatomic, strong) CompatibleAnimationView *animationView;
@end

@implementation YBTestLottieViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _testHelperFilePathAnimation];
}


#pragma mark - init UI


#pragma mark - private

- (void)_testLottieAddSubview {
    CGRect animationViewFrame = [self _getLottieAnimationFrame:[self _resetLottieAnimationView]];
    CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithFrame:animationViewFrame];
    animationView.translatesAutoresizingMaskIntoConstraints = true;
    CompatibleAnimation *animation = [[CompatibleAnimation alloc] initWithName:@"video_lottie_lucky_money_animate" bundle:[NSBundle mainBundle]];
    animationView.compatibleAnimation = animation;
    [self.view addSubview:animationView];
    self.animationView = animationView;
    animationView.layer.borderColor = [UIColor greenColor].CGColor;
    animationView.layer.borderWidth = 1.f;
    
    CompatibleAnimationKeypath *keypath = [[CompatibleAnimationKeypath alloc] initWithKeypath:@"animation_layer"];
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50.f, 50.f)];
    customView.backgroundColor = [UIColor redColor];
    
    AnimationSubview *subView = [[AnimationSubview alloc] init];
    [subView addSubview:customView];
    
    [animationView addSubview:subView forLayerAt:keypath];
    
    [animationView play];
}

- (BOOL)_resetLottieAnimationView {
    BOOL layoutLeft = NO;
    if (self.animationView) {
        if (CGRectGetMinX(self.animationView.frame) < 1) {
            layoutLeft = YES;
        }else {
            layoutLeft = NO;
        }
        [self.animationView removeFromSuperview];
        self.animationView = nil;
    }
    return layoutLeft;
}

- (CGRect)_getLottieAnimationFrame:(BOOL)isLeft {
    return CGRectMake((!isLeft?0:(FULL_SCREEN_WIDTH/2)), FULL_SCREEN_HEIGHT - FULL_SCREEN_WIDTH/2, FULL_SCREEN_WIDTH/2, FULL_SCREEN_WIDTH/2);
}

- (void)_testHelperLottieAddSubViews {
    CGRect animationViewFrame = [self _getLottieAnimationFrame:[self _resetLottieAnimationView]];
    CompatibleAnimation *animation = [self _getSwiftCompatibleAnimation];
    CompatibleAnimationView *lottileView = [[CompatibleAnimationView alloc] initWithCompatibleAnimation:animation];
    lottileView.animationProgress = 0;
    lottileView.animationSpeed = 1;
    lottileView.userInteractionEnabled = NO;
    lottileView.loopAnimation = YES;
    lottileView.clipsToBounds = NO;
    [self.view addSubview:lottileView];
    lottileView.frame = animationViewFrame;
    self.animationView = lottileView;
    lottileView.contentMode = UIViewContentModeScaleAspectFill;
    lottileView.layer.borderColor = [UIColor greenColor].CGColor;
    lottileView.layer.borderWidth = 1.f;
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50.f, 50.f)];
    customView.backgroundColor = [UIColor redColor];
    
    AnimationSubview *subView = [[AnimationSubview alloc] initWithFrame:CGRectMake(0, 0, 50.f, 50.f)];
    [subView addSubview:customView];
    [lottileView addSubview:subView toLayerNamed:@"animation_layer" applyTransform:YES];
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [lottileView play];
    });
}

static CompatibleAnimation *swiftLuckyMoneyAnimation = nil;
- (CompatibleAnimation *)_getSwiftCompatibleAnimation {
    if (swiftLuckyMoneyAnimation) {
        return swiftLuckyMoneyAnimation;
    }
    swiftLuckyMoneyAnimation = [[CompatibleAnimation alloc] initWithName:@"video_lottie_lucky_money_animate" bundle:[NSBundle mainBundle]];
    return swiftLuckyMoneyAnimation;
}

- (void)_testHelperFilePathAnimation {
    CGRect animationViewFrame = [self _getLottieAnimationFrame:[self _resetLottieAnimationView]];
    //测试1
//    CompatibleAnimation *animation = [[CompatibleAnimation alloc] initWithName:@"forward_redpacket" bundle:[NSBundle mainBundle]];
//    CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithCompatibleAnimation:animation];
    
    //测试2
    CompatibleAnimationView *animationView = [CompatibleAnimationView animationNamed:@"story_play_follow"];
    
    //测试3
//    CompatibleAnimationView *animationView = [CompatibleAnimationView animationNamed:@"data"];

    animationView.frame = animationViewFrame;
    [self.view addSubview:animationView];
    self.animationView = animationView;
    animationView.animationProgress = 0;
    animationView.animationSpeed = 1;
    animationView.userInteractionEnabled = NO;
    animationView.loopAnimation = YES;
    animationView.clipsToBounds = NO;
    animationView.contentMode = UIViewContentModeScaleAspectFill;
    animationView.layer.borderColor = [UIColor greenColor].CGColor;
    animationView.layer.borderWidth = 1.f;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animationView play];
    });
}

@end
