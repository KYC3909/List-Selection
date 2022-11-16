//
//  Storyboard Instantiate.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import UIKit

protocol StoryboardInstantiate : UIViewController {
    static func instantiateFrom(_ storyboard: StoryboardName) -> Self
}

extension StoryboardInstantiate {

    static func instantiateFrom(_ storyboard: StoryboardName) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        let id = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
