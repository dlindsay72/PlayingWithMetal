//
//  Vertex.swift
//  PlayingWithMetal
//
//  Created by Dan Lindsay on 2017-02-24.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import Foundation

struct Vertex{
    
    var x,y,z: Float     // position data
    var r,g,b,a: Float   // color data
    
    func floatBuffer() -> [Float] {
        return [x,y,z,r,g,b,a]
    }
    
}
