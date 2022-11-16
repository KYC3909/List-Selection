//
//  LoadingView.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import SwiftEntryKit

final class LoadingView {
    static var displayMode = EKAttributes.DisplayMode.inferred
    private var displayMode: EKAttributes.DisplayMode {
        return AddUserFormViewModel.displayMode
    }

    init() { }

    lazy var attributes: EKAttributes = {
        attributes = .topNote
        attributes.displayMode = displayMode
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.popBehavior = .animated(animation: .translation)
        attributes.statusBar = .light
        
        attributes.entryBackground = .gradient(
            gradient: .init(
                colors: [Color.BlueGradient.dark, Color.BlueGradient.light],
                startPoint: .zero,
                endPoint: CGPoint(x: 1, y: 1)
            )
        )
        attributes.entryInteraction = .delayExit(by: 3)
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        attributes.statusBar = .dark
        attributes.positionConstraints.maxSize = .init(
            width: .constant(value: UIScreen.main.minEdge),
            height: .intrinsic
        )

        return attributes
    }()
    
    func hideLoadingView() {
        SwiftEntryKit.dismiss()
    }
    
    func showLoadingView() {
        let text = "Refreshing data, Please wait!"
        let style = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 14),
            color: .white,
            alignment: .center,
            displayMode: displayMode
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        let contentView = EKProcessingNoteMessageView(
            with: labelContent,
            activityIndicator: .white
        )
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }

}
