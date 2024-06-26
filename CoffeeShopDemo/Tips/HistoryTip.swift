//
//  HistoryTip.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 24/9/23.
//

import Foundation
import TipKit

struct HistoryTip: Tip {
    
    /// Parameters-Rules
    @Parameter
    static var alreadyDiscovered: Bool = false
    @Parameter
    static var needToShowTip: Bool = false
    /// Event-Rules
    static let orderPlaced = Event(id: "order-placed")
    
    
    var title: Text {
        Text("Access your order history!")
    }
    
    var message: Text? {
        Text("You can quickly repeat any order you want")
    }
    
    var asset: Image? {
        Image(systemName: "clock.arrow.circlepath")
    }
    
    var options: [TipOption] {
        [MaxDisplayCount(2)]
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.orderPlaced) {
                $0.donations.donatedWithin(.minutes(1)).count > 0
            },
            
            #Rule(Self.$alreadyDiscovered) {
                $0 == false
            },
            
            #Rule(Self.$needToShowTip) {
                $0 == true
            }
        ]
    }
}
