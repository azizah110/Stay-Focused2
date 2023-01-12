//
//  BlankPage.swift
//  Stay Focused2
//
//  Created by Sara bayan alharbi on 12/06/1444 AH.
//

import SwiftUI

struct BlankPage: View {
    @State var isVoiceOverPressed = true
    @State var accessibilityInputLabels = ["Start Timer", "Go To Goals"]
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BlankPage_Previews: PreviewProvider {
    static var previews: some View {
        BlankPage()
    }
}
