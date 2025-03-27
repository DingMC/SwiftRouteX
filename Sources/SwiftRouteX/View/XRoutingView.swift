//
//  XRoutingView.swift
//  SwiftRouteX
//
//  Created by masun.ding on 2025/3/27.
//
import SwiftUI

public struct XRoutingView<Content: View>: View {
    
    @StateObject var router: XRouter
    private let content: Content
    
    public init(router: XRouter, @ViewBuilder content: @escaping () -> Content) {
        _router = StateObject(wrappedValue: router)
        self.content = content()
    }
    
    public var body: some View {
        NavigationStack(path: router.router.navigationPath) {
            content
                .navigationDestination(for: RouterPathView.self) { path in
                    router.router.view(path)
                }
        }
    }
}
