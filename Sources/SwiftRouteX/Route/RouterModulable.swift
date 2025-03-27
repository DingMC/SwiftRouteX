//
//  RouterModulable.swift
//  SwiftRouteX
//
//  Created by masun.ding on 2025/3/27.
//

public protocol RouterModulable{
    static var routers: [Routerable.Type]{get}    
}
