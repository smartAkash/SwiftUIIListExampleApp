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
                                      CommonDataModel.init(title: "Search", icon: "searchAtLandingPage", iconPosition: .left),
                                      CommonDataModel.init(title: "Connect", icon: "umbagog", iconPosition: .right),
                ]
                CustomSegmentedPickerView(buttonTitlesArray: arrayOfSegment,tabHeight: 50, buttonTapAction: { dataModel in
                    debugPrint(dataModel.title)
                }).colorMultiply(.orange)
        }
    }

}
