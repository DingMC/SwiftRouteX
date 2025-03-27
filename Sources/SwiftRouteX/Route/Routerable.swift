//
//  Routerable.swift
//  SwiftRouteX
//
//  Created by masun.ding on 2025/3/27.
//

import SwiftUI

public protocol RouterPath {
    var pathName: String { get }
}

public protocol Routerable{
    static var routerPath: any RouterPath{get}
    static func routerBuildView(_ param: Any?) -> any View
}
