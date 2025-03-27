//
//  RouterPathView.swift
//  SwiftRouteX
//
//  Created by masun.ding on 2025/3/26.
//

import SwiftUI

public struct RouterPathView: Hashable, Identifiable{
    public let id = UUID()
    
    public var view: any View
    private var viewType: Any.Type
    
    public init<V: View>(_ view: V){
        self.view = view
        self.viewType = V.self
    }
    public static func == (lhs: RouterPathView, rhs: RouterPathView) -> Bool {
        return lhs.viewType == rhs.viewType
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: view.self))
    }
    public func isView<V: View>(_ type: V.Type)->Bool{
        return self.viewType == type
    }
}
