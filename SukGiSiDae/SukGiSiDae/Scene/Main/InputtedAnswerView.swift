//
//  InputtedAnswerView.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI

struct InputtedAnswerView: View {
    @Binding var inputtedAnswer: String
    
    var body: some View {
        ZStack {
            Image(.wordStone)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.brown)
            
            Text(inputtedAnswer)
                .foregroundStyle(.black)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .frame(width: 50, height: 50)
        }
    }
}

#Preview {
    InputtedAnswerView(inputtedAnswer: .constant("가"))
}
