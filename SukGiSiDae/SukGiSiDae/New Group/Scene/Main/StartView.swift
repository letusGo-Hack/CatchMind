//
//  StartView.swift
//  SukGiSiDae
//
//  Created by 김지현 on 6/10/23.
//
import SwiftUI
import SwiftData

struct StartView: View {
    
    @EnvironmentObject var gameState: MyGameState
    @State private var isPresented = false
    var body: some View {
        ZStack {
            if isPresented {
                ContentView().environmentObject(gameState)
            } else {
                VStack {
                    Text("SUKGISIDAE")
                        .font(.system(size: 50, weight: .bold))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                    ZStack {
                        Button(action: {
                            self.isPresented.toggle()
                        } , label: {
                            Text("시작")
                                .font(.system(size: 30, weight: .bold))
                        })
                    }.background(
                        Image("startStone")
                    ).frame(width: 100, height: 100)
                    
                }.background(
                    Image("stoneBackground")
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                )
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

//#Preview {
//    StartView()
//}
