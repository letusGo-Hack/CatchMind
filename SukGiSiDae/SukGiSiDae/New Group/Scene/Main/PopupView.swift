//
//  PopupView.swift
//  SukGiSiDae
//
//  Created by 김지현 on 6/10/23.
//

import SwiftUI

struct PopupView: View {

    @State var isAnswer: Bool = true
    @State var answer: String = "새싹"
    @State var successPerson: String = "찰리"

    var body: some View {
        VStack(spacing: .zero, content: {
            title
            guideAnswer
            image
            description
        })
        .padding(
            EdgeInsets(top: 50, leading: 100, bottom: 50, trailing: 100)
        )
        .multilineTextAlignment(.center)
        .background(.white)
        .shadow(radius: 10)
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}

private extension PopupView {
    var title: some View {
        Text(isAnswer ? "성공" : "실패")
            .font(.title)
            .padding()
    }

    var guideAnswer: some View {
        Text("정답은 \(answer)")
            .font(.body)
    }

    var image: some View {
        changeToImage(isAnswer)
            .aspectRatio(contentMode: .fill)
            .padding()
    }

    var description: some View {
        Text(
            isAnswer ?
            "\(successPerson)님이 맞혔습니다" :
            "아무도 맞히지 못했습니다"
        )
            .font(.caption)
            .padding(
                EdgeInsets(
                    top: 12,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                )
            )
    }

    private func changeToImage(_ isAnswer: Bool) -> Image? {
        if isAnswer {
            return Image("successIlust")
        }
        return nil
    }
}

#Preview {
    PopupView()
}
