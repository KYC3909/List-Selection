//
//  AddUserFormViewModel.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import Foundation
import SwiftEntryKit

final class AddUserFormViewModel {
    
    private weak var addUserFormChildCoordinator : AddUserFormCoordinator?
    
    static var displayMode = EKAttributes.DisplayMode.inferred
    private var displayMode: EKAttributes.DisplayMode {
        return AddUserFormViewModel.displayMode
    }
    
    private let nextId: Int!
    init(_ nextId: Int,
         _ addUserFormChildCoordinator: AddUserFormCoordinator) {
        self.nextId = nextId
        self.addUserFormChildCoordinator = addUserFormChildCoordinator
    }

    lazy var attributes: EKAttributes = {
        var attributes = EKAttributes()
        attributes = .toast
        attributes.displayMode = displayMode
        attributes.windowLevel = .normal
        attributes.position = .bottom
        attributes.displayDuration = .infinity
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.65,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        attributes.exitAnimation = .init(
            translate: .init(
                duration: 0.65,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(
                    duration: 0.65,
                    spring: .init(damping: 1, initialVelocity: 0)
                )
            )
        )
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        attributes.entryBackground = .gradient(
            gradient: .init(
                colors: [Color.Netflix.light, Color.Netflix.dark],
                startPoint: .zero,
                endPoint: CGPoint(x: 1, y: 1)
            )
        )
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 3
            )
        )
        attributes.screenBackground = .color(color: .dimmedDarkBackground)
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.statusBar = .light
        attributes.positionConstraints.keyboardRelation = .bind(
            offset: .init(
                bottom: 0,
                screenEdgeResistance: 0
            )
        )
        attributes.positionConstraints.maxSize = .init(
            width: .constant(value: UIScreen.main.minEdge),
            height: .intrinsic
        )

        return attributes
    }()
    
    
    
    func showFormFor(_ style: FormStyle) {
        let titleStyle = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 16),
            color: style.textColor,
            displayMode: displayMode
        )
        let title = EKProperty.LabelContent(
            text: "Fill your personal details",
            style: titleStyle
        )
        let textFields = FormFieldPresetFactory.fields(
            by: [.fullName, .email, .mobile],
            style: style
        )
        let button = EKProperty.ButtonContent(
            label: .init(text: "Continue", style: style.buttonTitle),
            backgroundColor: style.buttonBackground,
            highlightedBackgroundColor: style.buttonBackground.with(alpha: 0.8),
            displayMode: displayMode) { [weak self] in
            
            let name = textFields[0].textContent
            let email = textFields[1].textContent
            let phone = textFields[2].textContent
            
            // Validation
            guard name.count > 0, email.count > 0, phone.count > 0 else {
                return
            }
            
            SwiftEntryKit.dismiss()

            let user = User(id: (self?.nextId ?? 0) + 1, name: name, email: email, phone: phone)
            self?.addUserFormChildCoordinator?.dismissViewController(user)
            
        }
        let contentView = EKFormMessageView(
            with: title,
            textFieldsContent: textFields,
            buttonContent: button
        )
        attributes.lifecycleEvents.didAppear = {
            contentView.becomeFirstResponder(with: 0)
        }
        SwiftEntryKit.display(entry: contentView, using: attributes, presentInsideKeyWindow: true)

    }
    deinit{
        debugPrint("AddUserFormViewModel")
    }
}
