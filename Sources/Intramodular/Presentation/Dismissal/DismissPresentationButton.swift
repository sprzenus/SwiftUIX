//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

/// A control which dismisses an active presentation when triggered.
@MainActor
public struct DismissPresentationButton<Label: View>: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.presentationManager) private var presentationManager
    @Environment(\.presenter) private var presenter
    
    public typealias Action = @MainActor () -> Void
    
    private let action: Action
    private let label: Label
    
    public init(action: @escaping Action, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        Button(action: dismiss, label: { label })
    }
    
    public func dismiss() {
        defer {
            action()
        }
        
        if presentationManager.isPresented {
            if let presenter = presenter, presentationManager is Binding<PresentationMode> {
                presenter.dismissTopmost()
            } else {
                presentationManager.dismiss()
                
                if presentationMode.isPresented {
                    presentationMode.dismiss()
                }
            }
        } else {
            presentationMode.dismiss()
        }
    }
}

extension DismissPresentationButton where Label == Image {
    @available(OSX 11.0, *)
    public init(action: @escaping () -> Void) {
        self.init(action: action) {
            Image(systemName: .xmarkCircleFill)
        }
    }
}

extension DismissPresentationButton where Label == Text {
    public init<S: StringProtocol>(_ title: S, action: @escaping Action) {
        self.init(action: action) {
            Text(title)
        }
    }
}
