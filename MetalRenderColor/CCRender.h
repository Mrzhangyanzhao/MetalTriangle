//
//  CCRender.h
//  MetalRenderColor
//
//  Created by yz on 2020/8/25.
//  Copyright © 2020 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MetalKit;
NS_ASSUME_NONNULL_BEGIN

@interface CCRender : NSObject<MTKViewDelegate>

-(id)initWithMetalKitView:(MTKView *)mktView;
@end

NS_ASSUME_NONNULL_END
