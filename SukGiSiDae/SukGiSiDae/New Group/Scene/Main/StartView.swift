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
            Image("startStone")
            Text("시작")
                .font(.headline)
        }.padding()
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
