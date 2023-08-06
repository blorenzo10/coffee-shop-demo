//
//  OrderAttributes.swift
//  Coffee Shop Widget
//
//  Created by Bruno Lorenzo on 10/7/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CoffeeShopWidgetLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderAttributes.self) { context in
            // Lock screen/banner UI goes here
            LiveActivityView(state: context.state)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.status.description)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.status.description)")
            } minimal: {
                Text(context.state.status.description)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct LiveActivityView: View {
    
    let state: OrderAttributes.ContentState
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "cup.and.saucer")
                ProgressView(value: state.status.rawValue, total: 3)
                    .tint(.black)
                    .background(Color.brown)
                Image(systemName: "cup.and.saucer.fill")
            }
            .padding(16)
            
            Text("\(state.status.description)")
                .font(.system(size: 18, weight: .semibold))
                .padding(.bottom)
            Spacer()
        }
        .background(Color.brown.opacity(0.6))
    }
}

extension OrderAttributes {
    fileprivate static var preview: OrderAttributes {
        return OrderAttributes(orderNumber: 1)
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderAttributes.preview
                .previewContext(.init(status: .inQueue), viewKind: .content)
            
            OrderAttributes.preview
                .previewContext(.init(status: .aboutToTake), viewKind: .content)
            
            OrderAttributes.preview
                .previewContext(.init(status: .making), viewKind: .content)
            
            OrderAttributes.preview
                .previewContext(.init(status: .ready), viewKind: .content)
        }
    }
}
