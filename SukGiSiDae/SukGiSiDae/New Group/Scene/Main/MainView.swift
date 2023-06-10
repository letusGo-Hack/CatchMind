//
//  LandingView.swift
//  SukGiSiDae
//
//  Created by kk on 6/10/23.
//


import SwiftUI

struct MainView: View {
    @StateObject var gameState = MyGameState()
    
    var body: some View {
        StartView()
            .environmentObject(gameState)
    }
}
