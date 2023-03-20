//
//  WBVideoLottieHelper.h
//  WBVideoKit
//
//  Created by yingbo5 on 2022/12/21.
//

#import <Foundation/Foundation.h>
#import "Lottie-Swift.h"

// 官方文档：http://airbnb.io/lottie/#/ios
// Adding subViews: http://airbnb.io/lottie/#/ios?id=adding-subviews
// Animation Keypaths: http://airbnb.io/lottie/#/ios?id=animation-keypaths
// issues: https://github.com/airbnb/lottie-ios/issues/1206
// issues: https://github.com/airbnb/lottie-ios/pull/1587
// issues: https://github.com/airbnb/lottie-ios/issues/1091
// swift lottie-iOS 3.5.0是使用-addSubview:forLayerAt方法不崩溃的最后一个版本；从4.0.0及以后得版本，会crash；
// swift 使用demo: https://github.com/banxin/Swift_Lottie_Demo


NS_ASSUME_NONNULL_BEGIN

@interface WBVideoLottieHelper : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end


typedef void (^WBLOTAnimationCompletionBlock)(BOOL animationFinished);

@protocol LOTAnimationViewTransferProtocol <NSObject>
@property (nonatomic, assign) CGFloat animationProgress;
@property (nonatomic, assign) BOOL loopAnimation;
@property (nonatomic, strong, nonnull) id sceneModel;
@property (nonatomic, readonly) BOOL isAnimationPlaying;
@property (nonatomic, copy, nullable) WBLOTAnimationCompletionBlock completionBlock;

+ (instancetype)animationNamed:(NSString *)name;

+ (instancetype)animationWithFilePath:(nonnull NSString *)filePath;

- (instancetype)initWithCompatibleAnimation:(CompatibleAnimation *)compatibleAnimation;

/**
 仅swift版本lottie可调用此方法；
 因为swift版本lottie没有completionBlock属性，此方法仅用来需要设置.completionBlock属性时使用，普通场景直接调用-play即可；
 */
- (void)swift_play;

- (void)play;

- (void)pause;

- (void)stop;

- (void)playWithCompletion:(nullable WBLOTAnimationCompletionBlock)completion;

- (void)addSubview:(nonnull id)view toLayerNamed:(nonnull NSString *)layer applyTransform:(BOOL)applyTransform;

- (void)playToProgress:(CGFloat)toProgress withCompletion:(nullable WBLOTAnimationCompletionBlock)completion;

@end


@interface CompatibleAnimationView (WBVideoExtension)<LOTAnimationViewTransferProtocol>

- (void)addSubview:(AnimationSubview * _Nonnull)view toLayerNamed:(NSString *)layer applyTransform:(BOOL)applyTransform;

@end


NS_ASSUME_NONNULL_END
