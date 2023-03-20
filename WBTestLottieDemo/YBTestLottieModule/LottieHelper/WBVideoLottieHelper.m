//
//  WBVideoLottieHelper.m
//  WBVideoKit
//
//  Created by yingbo5 on 2022/12/21.
//

#import "WBVideoLottieHelper.h"
#import <objc/runtime.h>

static WBVideoLottieHelper *instance = nil;

@implementation WBVideoLottieHelper


+ (CompatibleAnimationView *)animationNamed:(NSString *)name {
    CompatibleAnimation *animation = [[CompatibleAnimation alloc] initWithName:name bundle:[NSBundle mainBundle]];
    CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithCompatibleAnimation:animation];
//    animationView.compatibleAnimation = animation;
//    animationView.contentMode = UIViewContentModeScaleAspectFit;
//    animationView.loopAnimationCount = INT32_MAX;
//    animationView.animationSpeed = 1;
//    animationView.userInteractionEnabled = NO;
    return animationView;
}

@end

@implementation CompatibleAnimationView (WBVideoExtension)

- (CGFloat)animationProgress {
    return self.currentProgress;
}

- (void)setAnimationProgress:(CGFloat)animationProgress {
    [self setCurrentProgress:animationProgress];
}

- (BOOL)loopAnimation {
    return ABS(self.loopAnimationCount - 1) < 1E-4 ? NO: YES;;
}

- (void)setLoopAnimation:(BOOL)loopAnimation {
    [self setLoopAnimationCount:loopAnimation?INT32_MAX:1];
}

- (CompatibleAnimation *)sceneModel {
    return self.compatibleAnimation;
}

- (void)setSceneModel:(CompatibleAnimation *)sceneModel {
    if ([sceneModel isKindOfClass:[CompatibleAnimation class]]) {
        [self setCompatibleAnimation:sceneModel];
    }
}

- (WBLOTAnimationCompletionBlock)completionBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCompletionBlock:(WBLOTAnimationCompletionBlock)completionBlock {
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)swift_play {
    [self playWithCompletion:self.completionBlock];
}

+ (instancetype)animationNamed:(NSString *)name {
    CompatibleAnimationView *animationView = [WBVideoLottieHelper animationNamed:name];
    animationView.translatesAutoresizingMaskIntoConstraints = true;
    return animationView;
}

+ (instancetype)animationWithFilePath:(NSString *)filePath {
    
//    CompatibleAnimation *compatibleAnimation = [[CompatibleAnimation alloc] initWithPath:filePath];
//    CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithCompatibleAnimation:compatibleAnimation];
//    animationView.translatesAutoresizingMaskIntoConstraints = true;
//    return animationView;
    return nil;
}

- (instancetype)initWithCompatibleAnimation:(CompatibleAnimation *)compatibleAnimation {
    if(self = [self initWithFrame:CGRectZero]) {
        self.translatesAutoresizingMaskIntoConstraints = true;
        self.compatibleAnimation = compatibleAnimation;
    }
    return self;
}

- (void)addSubview:(AnimationSubview * _Nonnull)view toLayerNamed:(NSString *)layer applyTransform:(BOOL)applyTransform {
    CompatibleAnimationKeypath *keyPath = [[CompatibleAnimationKeypath alloc] initWithKeypath:layer];
    [self addSubview:view forLayerAt:keyPath];
}

- (void)playToProgress:(CGFloat)toProgress withCompletion:(WBLOTAnimationCompletionBlock)completion {
    [self playFromProgress:0.f toProgress:toProgress completion:completion];
}

@end
