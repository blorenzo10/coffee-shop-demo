//
//  File.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 6/12/23.
//

import Foundation
import AppIntents
import WidgetKit

struct RepeatOrderIntent: AppIntent {
    static var title: LocalizedStringResource = "Repeat Last Coffee"

    init(){}
    
    func perform() async throws -> some IntentResult {
        OrdersManager.shared.repeatLastOrder()
        //WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
