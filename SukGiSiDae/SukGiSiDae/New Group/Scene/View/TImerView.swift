//
//  TImerView.swift
//  SukGiSiDae
//
//  Created by kk on 6/10/23.
//

import SwiftUI
import Combine
import Foundation
 
struct TimerView: View {
    
    let date = Date()
    @State var timeRemaining : Int
    @State var isStart = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(convertSecondsToTime(timeInSeconds:timeRemaining))
                .font(.system(size: 50))
                .onReceive(timer) { _ in
                    if isStart {
                        timeRemaining -= 1
                    }
                }
        }.background(.purple)
    }
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds - hours*3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i", hours,minutes,seconds)
    }
    func calcRemain() {
        let calendar = Calendar.current
        let targetTime : Date = calendar.date(byAdding: .second, value: 3800, to: date, wrappingComponents: false) ?? Date()
        let remainSeconds = Int(targetTime.timeIntervalSince(date))
        self.timeRemaining = remainSeconds
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining: 180)
    }
}
