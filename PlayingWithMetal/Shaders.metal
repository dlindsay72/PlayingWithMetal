//
//  Shaders.metal
//  PlayingWithMetal
//
//  Created by Dan Lindsay on 2017-02-24.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    packed_float3 position;
    packed_float4 color;
};

struct VertexOut{
    float4 position [[position]];  //1
    float4 color;
};

vertex VertexOut basic_vertex(
    const device VertexIn* vertex_array [[ buffer(0) ]],   // 2
    unsigned int vid [[ vertex_id ]]) {
    
    VertexIn VertexIn = vertex_array[vid];                 // 3
    
    VertexOut VertexOut;
    VertexOut.position = float4(VertexIn.position,1);
    VertexOut.color = VertexIn.color;                       // 4
    
    return VertexOut;
}

fragment half4 basic_fragment(VertexOut interpolated [[stage_in]]) {  //1
    return half4(interpolated.color[0], interpolated.color[1], interpolated.color[2], interpolated.color[3]); //2
}

