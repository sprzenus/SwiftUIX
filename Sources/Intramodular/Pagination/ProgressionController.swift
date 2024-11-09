//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

public protocol ProgressionController {
    func scrollTo(_ id: AnyHashable)
    
    func moveToNext()
    func moveToPrevious()
}

// MARK: - Auxiliary

extension EnvironmentValues {
    struct ProgressionControllerEnvironmentKey: EnvironmentKey {
        static let defaultValue: ProgressionController? = nil
    }
    
    public var progressionController: ProgressionController? {
        get {
            self[ProgressionControllerEnvironmentKey.self]
        } set {
            self[ProgressionControllerEnvironmentKey.self] = newValue
        }
    }
}

// MARK: - API

/// A button that triggers a regression.
public struct PreviousButton<Label: View>: View {
    @Environment(\.progressionController) var progressionController
    
    private let action: @MainActor () -> Void
    private let label: Label
    
    public init(action: @escaping @MainActor () -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        Button(action: { self.progressionController?.moveToPrevious() }) {
            label
        }
    }
}

/// A button that triggers a progression.
public struct NextButton<Label: View>: View {
    @Environment(\.progressionController) var progressionController
    
    private let action: @MainActor () -> Void
    private let label: Label
    
    public init(action: @escaping @MainActor () -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        Button(action: { self.progressionController?.moveToNext() }) {
            label
        }
    }
}
