//
//  SwiftUIIListExampleAppApp.swift
//  SwiftUIIListExampleApp
//
//  Created by Akash on 05/10/21.
//

import SwiftUI

@main
struct SwiftUIIListExampleAppApp: App {
    var body: some Scene {
        WindowGroup {
                let arrayOfSegment = [CommonDataModel.init(title: "Jobs"),
                                      CommonDataModel.init(title: "Search", icon: "searchAtLandingPage", iconPosition: .left, isSelected: true),
                                      CommonDataModel.init(title: "Connect", icon: "umbagog", iconPosition: .right),
//                                      CommonDataModel.init(title: "Connect", icon: "umbagog", iconPosition: .right),

                ]
                CustomSegmentedPickerView(buttonTitlesArray: arrayOfSegment,tabHeight: 50, buttonTapAction: { dataModel in
                    debugPrint(dataModel.title)
                }).colorMultiply(.orange)
        }
    }

}
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
