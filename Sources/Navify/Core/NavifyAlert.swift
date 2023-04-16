//
//  Alert.swift
//  
//
//  Created by Adrian Suthold on 13.04.23.
//

import SwiftUI

public struct NavifyAlert {
    
    // MARK: - Properties
    var isPresenting: Bool
    var option: AlertOption
    var title: String
    var message: String
    var content: AnyView
    
    // MARK: - Body
    public init<T: View>(
        isPresenting: Bool = false,
        option: AlertOption = .alert,
        title: String,
        message: String = "",
        content: @escaping () -> T = { EmptyView() }
    ) {
        self.isPresenting = isPresenting
        self.option = option
        self.title = title
        self.message = message
        self.content = AnyView(content())
    }
    
}
