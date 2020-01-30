//
//  UIStoryboard+Names.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"
    
    var filename: String {
        return rawValue
    }
}

extension UIStoryboard {
    convenience init(name: StoryboardName) {
        self.init(name: name.filename, bundle: Bundle.main)
    }
    
    public func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
