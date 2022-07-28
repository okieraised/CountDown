//
//  HideKeyboardExtension.swift
//  CountDown
//
//  Created by Tri Pham on 7/28/22.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

