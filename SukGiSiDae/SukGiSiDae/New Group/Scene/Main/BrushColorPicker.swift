//
//  BrushColorPicker.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI

struct BrushColorPicker: View {
    @State private var brushColor: Color = .black
      
    var body: some View {
        Image(.changeColorBrush)
            .renderingMode(.template)
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundStyle(brushColor)
            .overlay {
                ColorPicker("", selection: $brushColor)
                    .labelsHidden()
                    .opacity(0.015)
                    
            }
    }
}

#Preview {
    BrushColorPicker()
}
