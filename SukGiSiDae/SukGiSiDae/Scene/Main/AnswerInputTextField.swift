//
//  AnswerInputView.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI

struct AnswerInputTextField: View {
    @Binding var inputtedAnswer: String
    
    var body: some View {
        TextField("정답을 입력해주세요.", text: $inputtedAnswer)
            .frame(height: 50)
            .padding([.leading, .trailing])
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
            )
            .padding()
        
    }
}

#Preview {
    AnswerInputTextField(inputtedAnswer: .constant(""))
}
