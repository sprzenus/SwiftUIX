//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

/// A control which pops a view in a navigation stack.
@MainActor
public struct PopNavigationButton<Label: View>: View {
    private let action: @MainActor () -> Void
    private let label: Label
    
    public init(action: @escaping @MainActor () -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        EnvironmentValueAccessView(\.navigator) { navigator in
            Button {
                action()
                navigator?.pop()
            } label: {
                label
            }
        }
        ._resolveAppKitOrUIKitViewControllerIfAvailable()
    }
}
