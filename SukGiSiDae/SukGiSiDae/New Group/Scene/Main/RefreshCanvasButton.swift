//
//  BrushColorPicker.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI

struct RefreshCanvasButton: View {
    @ObservedObject var canvas: Canvas
      
    var body: some View {
        Button {
            canvas.reset()
        } label: {
            Image(.refresh)
        }
    }
}
