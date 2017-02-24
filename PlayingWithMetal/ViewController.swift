//
//  ViewController.swift
//  PlayingWithMetal
//
//  Created by Dan Lindsay on 2017-02-24.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import Metal


class ViewController: UIViewController {
    
    var device: MTLDevice!
    var metalLayer: CAMetalLayer!
    
    var pipelineState: MTLRenderPipelineState!
    var commandQueue: MTLCommandQueue!
    var timer: CADisplayLink!
    
    var objectToDraw: Triangle!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        device = MTLCreateSystemDefaultDevice()
        metalLayer = CAMetalLayer()
        
        metalLayer.device = device
        metalLayer.pixelFormat = .bgra8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.layer.frame
        
        view.layer.addSublayer(metalLayer)
        
        objectToDraw = Triangle(device: device)
        
        let defaultLibrary = device.newDefaultLibrary()!
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        
        commandQueue = device.makeCommandQueue()
        
        timer = CADisplayLink(target: self, selector: #selector(ViewController.gameloop))
        timer.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        
        
    }
    
    func gameloop() {
        autoreleasepool {
            self.render()
        }
    }
    
    func render() {
        
        guard let drawable = metalLayer?.nextDrawable() else { return }
        objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, clearColor: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

