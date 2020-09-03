//
//  CoordinatorEngine.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 03.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

    protocol Presentable: class {
        var toPresent: UIViewController? { get }
    }

    extension UIViewController: Presentable {
        var toPresent: UIViewController? {
            return self
        }
    }

    protocol Coordinatable: class {
        var flowCompletion: (() -> Void)? { get set }
        func start()
    }

    protocol CoordinatorDelegate: class {
        func coordinator(didAttached coordinator: Coordinatable)
        func coordinator(didDetached coordinator: Coordinatable)
    }

    protocol CoordinatorEngineProtocol: class {
        var childs: [Coordinatable] { get set }
        var router: Routable { get set }
            
        func attachChild(_ child: Coordinatable)
        func detachChild(_ child: Coordinatable)
        
        func didAttachedChild(_ coordinator: Coordinatable)
        func didDetachChidl(_ coordinator: Coordinatable)
    }

    extension CoordinatorEngineProtocol {
        func didAttachedChild(_ coordinator: Coordinatable) { }
        func didDetachChidl(_ coordinator: Coordinatable) { }
    }

    class CoordinatorEngine: NSObject, CoordinatorEngineProtocol {
        var childs: [Coordinatable] = []
        var router: Routable
        
        init(router: Routable) {
            self.router = router
            super.init()
        }
        
        func attachChild(_ child: Coordinatable) {
            guard !childs.contains(where: { $0 === child}) else {
                return
            }
            
            childs.append(child)
            didAttachedChild(child)
            child.start()
        }
        
        func detachChild(_ child: Coordinatable) {
            guard !childs.isEmpty, let index = childs.firstIndex(where: { $0 === child }) else {
                return
            }
            
            didDetachChidl(child)
            childs.remove(at: index)
        }
    }
