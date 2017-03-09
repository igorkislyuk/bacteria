//
//  BacteriaSwift.swift
//  BacteriaSwift
//
//  Created by Igor on 09/03/2017.
//  Copyright © 2017 Igor Kislyuk. All rights reserved.
//

import Bacteria

public extension UIViewController {
    
    @discardableResult public func withDuration(_ time: TimeInterval) -> UIViewController {
        return self.withDuration()(time)!
    }
    
    public func presentTransition(_ type:BCTTransitionType) -> UIViewController {
        return self.presentTransition()(type)!
    }
    
    public func dismissTransition(_ type:BCTTransitionType) -> UIViewController {
        return self.dismissTransition()(type)!
    }
    
    public func fromDirection(_ direction: BCTDirectionType) -> UIViewController {
        return self.fromDirection()(direction)!
    }
    
    public func toDirection(_ direction: BCTDirectionType) -> UIViewController {
        return self.toDirection()(direction)!
    }
    
    public func popFrom(_ view: UIView) -> UIViewController {
        return self.popFrom()(view)!
    }
    
    public func popTo(_ view: UIView) -> UIViewController {
        return self.popTo()(view)!
    }
    
    public func fromScale(_ x: CGFloat, _ y: CGFloat) -> UIViewController {
        return self.fromScale()(x, y)!
    }
    
    public func toScale(_ x: CGFloat, _ y: CGFloat) -> UIViewController {
        return self.toScale()(x, y)!
    }
    
    public func fromPoint(_ location: CGPoint) -> UIViewController {
        return self.fromPoint()(location)!
    }
    
    public func toPoint(_ location: CGPoint) -> UIViewController {
        return self.toPoint()(location)!
    }
}
