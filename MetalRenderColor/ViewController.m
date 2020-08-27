//
//  ViewController.m
//  MetalRenderColor
//
//  Created by yz on 2020/8/25.
//  Copyright © 2020 yz. All rights reserved.
//

#import "ViewController.h"
#import "CCRender.h"
#import "TriangleRender.h"
@import MetalKit;
@interface ViewController ()
{
    MTKView *_mtkView;
    CCRender *_render;
    TriangleRender *_triangleRender;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建mtkView
    _mtkView = [[MTKView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height-20) device:MTLCreateSystemDefaultDevice()];
    [self.view addSubview:_mtkView];
   
    
    if (!_mtkView.device) {
        NSLog(@"Metal is not supported on this device");
        return;
    }
    
    ///*****渲染颜色
    //创建ccrender
//    _render = [[CCRender alloc]initWithMetalKitView:_mtkView];
//    if (!_render) {
//        NSLog(@"Renderer failed initialization");
//        return;
//    }
//    _mtkView.delegate = _render;
    
    // 渲染三角形
    _triangleRender = [[TriangleRender alloc]initMetalMtkView:_mtkView];
    _mtkView.delegate = _triangleRender;
    [_triangleRender mtkView:_mtkView drawableSizeWillChange:_mtkView.drawableSize];
    
    
    // Do any additional setup after loading the view.
}


@end
