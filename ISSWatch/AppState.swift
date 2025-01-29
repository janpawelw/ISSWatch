//
//  AppState.swift
//  ISSWatch
//
//  Created by John Paul on 29/01/2025.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isShowingMenu = false
    
    func showMenu() {
        isShowingMenu  = true
    }
    
    func hideMenu() {
        isShowingMenu = false
    }
    
    func toggleMenu() {
        isShowingMenu = !isShowingMenu
    }
}
