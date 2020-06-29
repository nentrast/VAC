//
//  WordsListViewController.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 01.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit
import FirebaseMessaging

protocol WordsListViewControllerInput: BasetableViewProtocol {
    
}

class WordsListViewController: UIViewController, WordsListViewControllerInput {
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("Deinit CollectionWordsViewController")
    }
    
    var presenter: WordsListPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.configure(tableView: tableView)
        
        
        let token = Messaging.messaging().fcmToken
         print("FCM token: \(token ?? "")")
    }
}

extension WordsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}


extension WordsListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (presenter?.interactor.hasStarted ?? false) ? presenter?.interactor : nil
    }
}
