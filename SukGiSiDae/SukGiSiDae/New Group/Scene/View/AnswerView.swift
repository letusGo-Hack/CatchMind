//
//  AnswerView.swift
//  SukGiSiDae
//
//  Created by kk on 6/10/23.
//

import SwiftUI

struct AnswerView: View {
      
    @State var strAnswer: String = ""
    
    var body: some View {
        VStack {
            Text("답 : \(strAnswer)")
                .font(.system(size: 50))
        }.background(.yellow)
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(strAnswer: "여우")
    }
}

