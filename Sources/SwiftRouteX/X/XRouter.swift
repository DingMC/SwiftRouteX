//
//  XRouter.swift
//  SwiftRouteX
//
//  Created by masun.ding on 2025/3/27.
//

import SwiftUI

public extension View{
    @ViewBuilder
    func useRouteX<T: RouterManagerable & ObservableObject>(_ manager: T) -> some View{
        XRoutingView(router: manager.router) {
            self
        }.environmentObject(manager.router)
    }
}
