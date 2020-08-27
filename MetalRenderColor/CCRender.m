//
//  CCRender.m
//  MetalRenderColor
//
//  Created by yz on 2020/8/25.
//  Copyright © 2020 yz. All rights reserved.
//

#import "CCRender.h"

@implementation CCRender
{
    id<MTLDevice>_device;//metal 设备(GPU)
    id<MTLCommandQueue>_commandQueue;//命令队列
}
typedef struct {
    float red,green,blue,alpha;
}Color;
-(id)initWithMetalKitView:(MTKView *)mktView{
    self  = [super init];
    if (self) {
        _device = mktView.device;
        _commandQueue = [_device newCommandQueue];
    }
    return self;
}

-(Color)makeFancyColor{
    //增加颜色 、减少颜色标记
    static BOOL growing = YES;
    //颜色通道(0~3)
    static NSUInteger primaryChannel = 0;
    //3.颜色通道数组colorChannels(颜色值)
    static float      colorChannels[] = {1.0, 0.0, 0.0, 1.0};
    //4.颜色调整步长
    const float DynamicColorRate = 0.015;
    if (growing) {
        //动态信道索引（1，2，3，0）通道间的切换
        NSInteger dynamicChannelIndex = (primaryChannel + 1) % 3;
        //修改对应通道的颜色值 调整0.015
        colorChannels[dynamicChannelIndex] += DynamicColorRate;
        //当颜色通道值 = 1.0时
        if (colorChannels[dynamicChannelIndex] >= 1.0) {
            //设置为no
            growing = NO;
            //将颜色通道修改为动态颜色通道
            primaryChannel = dynamicChannelIndex;
        }
    }else{
        //获取动态颜色通道
        NSUInteger dynamicChannelIndex = (primaryChannel+2)%3;
        
        //将当前颜色的值 减去0.015
        colorChannels[dynamicChannelIndex] -= DynamicColorRate;
        
        //当颜色值小于等于0.0
        if(colorChannels[dynamicChannelIndex] <= 0.0)
        {
            //又调整为颜色增加
            growing = YES;
        }
    }
    //创建颜色
    Color color;
    
    //修改颜色的RGBA的值
    color.red   = colorChannels[0];
    color.green = colorChannels[1];
    color.blue  = colorChannels[2];
    color.alpha = colorChannels[3];
    
    //返回颜色
    return color;
}

//每当视图渲染时调用

-(void)drawInMTKView:(nonnull MTKView *)view {
    //获取颜色
    Color color = [self makeFancyColor];
    //清除背景色
    view.clearColor = MTLClearColorMake(color.red, color.green, color.blue, color.alpha);
    
    
    //获取命令缓存区（目的将渲染对象加入进去）
    id<MTLCommandBuffer>commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"MyCommandBuffer";
    
    //从视图中获取渲染描述符
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    if (renderPassDescriptor != nil) {
        //创建命令编译器commandEncoder
        id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"MyRenderEncoder";
        [renderEncoder endEncoding];
        /*
         当编码器结束之后,命令缓存区就会接受到2个命令.
         1) present
         2) commit
         因为GPU是不会直接绘制到屏幕上,因此你不给出去指令.是不会有任何内容渲染到屏幕上.
        */
        //添加一个最后的命令来显示清除的可绘制的屏幕
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    //提交GPU 执行命令
    [commandBuffer commit];
    
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}


@end
