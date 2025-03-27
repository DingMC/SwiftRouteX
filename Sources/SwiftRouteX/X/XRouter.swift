//
//  XRouter.swift
//  SwiftRouteX
//
//  Created by masun.ding on 2025/3/27.
//

import SwiftUI

public protocol XRouterConfigable{
    var routerList: [Routerable.Type]{get set}
    var moduleList: [RouterModulable.Type]{get set}
}

public class XRouter: ObservableObject, RouterManagerable{
    
    @MainActor
    static let shared = XRouter()
    
    public var router: Router = Router(root: .constant(nil))
    
    public var routerList: RouterMap = [:]
    public var moduleList: [RouterModulable.Type] = []
    
}

public extension View{
    func useRouteX(_ config: any XRouterConfigable) -> some View{
        
        XRouter.shared.registerRouters(config.routerList)
        XRouter.shared.registeRouterModules(moduleList: config.moduleList)
        
        return XRoutingView(router: XRouter.shared.router) {
            self
        }.environmentObject(XRouter.shared)
    }
    
    func useRoute<T: RouterManagerable & ObservableObject>(_ manager: T) -> some View{
        XRoutingView(router: manager.router) {
            self
        }.environmentObject(manager)
    }

}
