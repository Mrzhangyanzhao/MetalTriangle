//
//  TriangleShaders.metal
//  MetalRenderColor
//
//  Created by yz on 2020/8/26.
//  Copyright © 2020 yz. All rights reserved.
//

#include <metal_stdlib>
//使用命名空间Metal
using namespace metal;
// 导入Metal shader 代码和执行Metal API命令的C代码之间共享的头
#import "TriangleShaderType.h"

//顶点着色器的输出和片元着色器的输入
//结构体
typedef struct {
    //处理空间的顶点数据
    float4 clipSpacePosition [[position]];
    //颜色
    float4 color;
    
}RasterizerData;

//顶点着色器
vertex RasterizerData vertexShader(uint vertexId[[vertex_id]],constant TriVertex *vertexs[[buffer(VertexInputIndexVertices)]],constant vector_uint2 *viewportSizePointer [[buffer(VertexInputIndexViewportSize)]]){
    /*
     处理顶点数据:
        1) 执行坐标系转换,将生成的顶点剪辑空间写入到返回值中.
        2) 将顶点颜色值传递给返回值
     */
    
    //定义out
    RasterizerData out;
    
    out.clipSpacePosition = vertexs[vertexId].position;
    
    //颜色。桥接片元着色器
    out.color = vertexs[vertexId].color;
    return out;
}

fragment float4 fragmentShader(RasterizerData in [[stage_in]])
{
    
    //返回输入的片元颜色
    return in.color;
}
