//
//  TriangleRender.h
//  MetalRenderColor
//
//  Created by yz on 2020/8/26.
//  Copyright © 2020 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MetalKit;
NS_ASSUME_NONNULL_BEGIN

@interface TriangleRender : NSObject<MTKViewDelegate>
-(id)initMetalMtkView:(MTKView *)mtkView;
@end

NS_ASSUME_NONNULL_END
