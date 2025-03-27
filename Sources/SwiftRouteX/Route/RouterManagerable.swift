//
//  RouterManagerable.swift
//  SwiftRouteX
//
//  Created by masun.ding on 2025/3/27.
//


import SwiftUI

public typealias RouterMap = Dictionary<String, Routerable.Type>

enum RouteError: Error{
    case unfound
}

public protocol RouterManagerable: AnyObject{
    var router: Router {get set}
    
    //路由表，可设置静态路由
    var routerList: RouterMap{get set}
    //路由模块表，初始化时调用registerModuleList方法自动完成注册
    var moduleList: [RouterModulable.Type]{get set}
    
}

public extension RouterManagerable{
    //路由模块表，初始化时调用registerModuleList方法自动完成注册
    func registerModuleList(){
        for item in self.moduleList{
            self.registerRouterModule(item)
        }
    }
    //路由模块按需注册
    func registeRouterModules(moduleList: [RouterModulable.Type]){
        for item in moduleList{
            self.registerRouterModule(item)
        }
    }
    //路由模块按需注册
    func registerRouterModule<T: RouterModulable>(_ type: T.Type){
        for item in type.routers{
            self.registerRouter(item)
        }
    }
    
    //路由注册，可以按需进行路由注册，实现动态路由
    func registerRouters(_ routers: [Routerable.Type]){
        for item in routers{
            self.registerRouter(item)
        }
    }
    
    //路由注册，可以按需进行路由注册，实现动态路由
    func registerRouter<T: Routerable>(_ type: T.Type){
        self.routerList[type.routerPath.pathName] = type
    }
    
    func buildView(_ path: String, param: Any? = nil)throws -> some View{
        guard let content = self.routerList[path] else{
            throw RouteError.unfound
        }
        return AnyView(content.routerBuildView(param))
    }
    
    //根据path跳转。被跳转的路由需要被设置到路由表内，静态，或动态注册均可
    func push(_ pathName: String, param: Any? = nil)throws{
        try self.router.push(self.buildView(pathName, param: param))
    }
    func push(_ path: RouterPath, param: Any? = nil)throws{
        try self.push(path.pathName, param: param)
    }
}

public extension RouterManagerable{
    func push(_ view: some View){
        self.router.push(view)
    }
    func replace(_ view: some View){
        self.router.replace(view)
    }
    func pop(){
        self.router.pop()
    }
    func pop(to prev: Int = 1){
        self.router.pop(to: prev)
    }
    func pop<T: View>(to type: T.Type){
        self.router.pop(to: type)
    }
    func popToRoot(){
       self.router.popToRoot()
    }
    func remove<T: View>(of type: T.Type) {
        self.router.remove(of: type)
    }
    func removePrev<T: View>(to type: T.Type) {
        self.router.removePrev(to: type)
    }
}
