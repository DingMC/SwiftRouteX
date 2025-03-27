//
//  Routerable.swift
//  SwiftRouteX
//
//  Created by masun.ding on 2025/3/27.
//

import SwiftUI
import Combine

public class Router: ObservableObject {
    
    struct State{
        var navigationPath: [RouterPathView] = []
        var root: Binding<RouterPathView?>
    }
    
    @Published private(set) var state: State
    
    public init(root: Binding<RouterPathView?>) {
        state = State(root: root)
    }
    func view(_ path: RouterPathView) -> AnyView {
        return AnyView( path.view )
    }
}

@MainActor
extension Router{
    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
    var navigationPath: Binding<[RouterPathView]> {
        binding(keyPath: \.navigationPath)
    }
    var root: Binding<RouterPathView?> {
        state.root
    }
}

public extension Router {
    func push(_ view: some View){
        state.navigationPath.append(RouterPathView(view))
    }
    func replace(_ view: some View){
        if state.navigationPath.count == 0{
            return
        }
        state.navigationPath[state.navigationPath.count-1] = RouterPathView(view)
    }
    func pop(){
        if state.navigationPath.count == 0{
            return
        }
        state.navigationPath.removeLast()
    }
    //向前返回级
    func pop(to prev: Int = 1){
        let k = min(state.navigationPath.count-1, prev)
        state.navigationPath.removeLast(k)
    }
    
    //返回到某个页面
    func pop<T: View>(to type: T.Type){
        var newPath = [RouterPathView]()
        for item in state.navigationPath{
            if item.isView(type){
                newPath.append(item)
                break
            }
            newPath.append(item)
        }
        state.navigationPath = newPath
    }
    
    func popToRoot(){
        if state.navigationPath.count == 0{
            return
        }
        state.navigationPath = []
    }
    
    // 移除某个页面
    func remove<T: View>(of type: T.Type) {
        var newPath = [RouterPathView]()
        for (i, item) in state.navigationPath.enumerated(){
            if item.isView(type){
                state.navigationPath.remove(at: i)
                break
            }
        }
    }
    
    // 移除当前页面前到某个页面结束的页面（根据视图类型）
    func removePrev<T: View>(to type: T.Type) {
        var newPath = [RouterPathView]()
        for item in state.navigationPath{
            if item.isView(type){
                newPath.append(item)
                break
            }
            newPath.append(item)
        }
        if let last = state.navigationPath.last,
            let newLast = newPath.last, last != newLast {
            newPath.append(last)
        }
        state.navigationPath = newPath
    }
}





