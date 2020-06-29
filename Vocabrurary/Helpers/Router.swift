//
//  Router.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 03.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol Routable: class {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, navigationBarIsHidden: Bool)
    func push(_ module: Presentable?)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func popToRootModule(animated: Bool)
    func popModule(animated: Bool)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
}


typealias RouterCompletions = [UIViewController : (() -> Void)?]

final class Router: NSObject {
    
    // MARK: - Private variables
    fileprivate weak var rootController: UINavigationController?
    fileprivate var completions: RouterCompletions
        
    deinit {
        print("Router deinit")
    }
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    var toPresent: UIViewController? {
        return rootController
    }
}

extension Router: Routable {
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.pushViewController(controller, animated: true)
    }
    
    func push(_ module: Presentable?, animated: Bool, navigationBarIsHidden: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.setNavigationBarHidden(navigationBarIsHidden, animated: animated)
        rootController?.pushViewController(controller, animated: true)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func popToRootModule(animated: Bool) {
        rootController?.popToRootViewController(animated: animated)
    }
    
    func popModule(animated: Bool) {
        rootController?.popViewController(animated: animated)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        setRootModule(module, hideBar: hideBar, animated: true)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool) {
        guard let controller = module?.toPresent else { return }

        rootController?.setViewControllers([controller], animated: animated)
        rootController?.isNavigationBarHidden = hideBar
    }
}
