// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Combine

@MainActor
public class RouterX: ObservableObject {
    
    enum Route{
        case navigation
        case sheet
        case fullScreen
        case modal
    }

    struct State{
//        var navigationPath: [ANRouterPathView] = []
//        var presentingSheet: ANRouterPathView? = nil
//        var presentingFullScreen: ANRouterPathView? = nil
//        var presentingModal: ANRouterPathView? = nil
//        var root: Binding<ANRouterPathView?>
//        
//        var isPresenting: Bool {
//            presentingSheet != nil || presentingFullScreen != nil || presentingModal != nil
//        }
    }
    
    @Published private(set) var state: State
    
    public init(state: State) {
        self.state = state
    }
    
//    public init(root: Binding<ANRouterPathView?>) {
//        state = State(root: root)
//    }
//    
//    func view(path: ANRouterPathView, route: Route) -> AnyView {
//        return path.view
//    }
}
