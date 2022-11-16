//
//  ToastMessageView.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import SwiftEntryKit

final class ToastMessageView {
    
    static var displayMode = EKAttributes.DisplayMode.inferred
    private var displayMode: EKAttributes.DisplayMode {
        return AddUserFormViewModel.displayMode
    }
    
    init() { }

    lazy var attributes: EKAttributes = {
        var attributes = EKAttributes()
        
        attributes = .bottomFloat
        attributes.displayMode = displayMode
        attributes.hapticFeedbackType = .success
        attributes.entryBackground = .color(color: .musicBackground)
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
    
    
    func showAlertFor(_ error: String) {
        let title = EKProperty.LabelContent(
            text: "Error!",
            style: .init(
                font: MainFont.medium.with(size: 15),
                color: .black,
                displayMode: displayMode
            ),
            accessibilityIdentifier: "title"
        )
        let description = EKProperty.LabelContent(
            text: error,
            style: .init(
                font: MainFont.light.with(size: 13),
                color: .black,
                displayMode: displayMode
            ),
            accessibilityIdentifier: "description"
        )
        let image = EKProperty.ImageContent(
            imageName: "ic_info_outline",
            displayMode: displayMode,
            size: CGSize(width: 35, height: 35),
            contentMode: .scaleAspectFit,
            accessibilityIdentifier: "image"
        )
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: title,
            description: description
        )
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)

    }
    deinit{
        debugPrint("ToastMessageView")
    }
}
