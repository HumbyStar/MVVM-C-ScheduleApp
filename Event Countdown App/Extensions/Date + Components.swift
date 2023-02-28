//
//  Date + Components.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 06/02/23.
//

import Foundation

extension Date {
    func timeRemaining(until endDate: Date) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to: endDate)
    }
    
    //From representa a data inicial para assim existir a contagem do tempo restante.
    //O argumento self é a data ATUAL. A Contagem do tempo restante será realizada a partir de self(data atual) a endDate (data final)
}
