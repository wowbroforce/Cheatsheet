//
//  UIViewController+Extensions.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 9/4/18.
//  Copyright © 2018 Prokhor Kharchenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    public var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).mapToVoid()
        return ControlEvent(events: source)
    }
    
    public var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    public var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    public var viewWillDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    public var viewDidDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    public var viewWillLayoutSubviews: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillLayoutSubviews)).mapToVoid()
        return ControlEvent(events: source)
    }
    public var viewDidLayoutSubviews: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLayoutSubviews)).mapToVoid()
        return ControlEvent(events: source)
    }
    
    public var willMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.methodInvoked(#selector(Base.willMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    public var didMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.methodInvoked(#selector(Base.didMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    
    public var didReceiveMemoryWarning: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.didReceiveMemoryWarning)).mapToVoid()
        return ControlEvent(events: source)
    }
    
    /// Rx observable, triggered when the ViewController appearance state changes (true if the View is being displayed, false otherwise)
    public var isVisible: Observable<Bool> {
        let viewDidAppearObservable = self.base.rx.viewDidAppear.transform(to: true)
        let viewWillDisappearObservable = self.base.rx.viewWillDisappear.transform(to: false)
        return .merge(viewDidAppearObservable, viewWillDisappearObservable)
    }
    
    /// Rx observable, triggered when the ViewController is being dismissed
    public var isDismissing: ControlEvent<Bool> {
        let source = self.sentMessage(#selector(Base.dismiss)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}
