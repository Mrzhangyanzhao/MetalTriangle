//
//  TriangleShaderType.h
//  MetalRenderColor
//
//  Created by yz on 2020/8/26.
//  Copyright © 2020 yz. All rights reserved.
//

#ifndef TriangleShaderType_h
#define TriangleShaderType_h

//缓存区的索引值 共享 shader 和 c 代码 为了确保Metal Shader缓存区索引能够匹配 Metal API Buffer 设置的集合调用
typedef enum TriVertexInputIndex{
    //顶点
    VertexInputIndexVertices     = 0,
    //视图大小
    VertexInputIndexViewportSize = 1,
}TriVertexInputIndex;

//结构体
//顶点/颜色
typedef struct{
    //像素空间位置
    // 像素中心点(100,100)
    vector_float4 position;
    
    // RGBA颜色
    vector_float4 color;
    
}TriVertex;

#endif /* TriangleShaderType_h */
