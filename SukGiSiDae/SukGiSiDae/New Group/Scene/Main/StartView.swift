//
//  StartView.swift
//  SukGiSiDae
//
//  Created by 김지현 on 6/10/23.
//

import SwiftUI

struct StartView: View {

    var body: some View {
        ZStack {
            Image("stoneBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

            ZStack {
                Button(action: {print("Button1")}){
                    ZStack {
                        Image("startStone")
                        Text("시작")
                            .font(.system(size: 90))
                    }
                }
                .foregroundColor(.black)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

#Preview {
    StartView()
}
