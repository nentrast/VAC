//
//  CollectionWordsViewController.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 01.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol CollectionWordsViewControllerInput: class {
    func scroll(to indexPath: IndexPath, animated: Bool)
}


class CollectionWordsViewController: UIViewController, CollectionWordsViewControllerInput {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
        
    var presenter: CollectionWordsPresenterInput?
    
    deinit {
        print("Deinit CollectionWordsViewController")
    }
    
    init() {
        super.init(nibName: String(describing: CollectionWordsViewController.self), bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    

    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
//
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
//
//        let percentThreshold: CGFloat = 0.3
//
//        let translation = sender.translation(in: view)
//        let verticalMovement = translation.y / view.bounds.height
//        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
//        let downwardMovementPercent = fminf(downwardMovement, 1.0)
//        let progress = CGFloat(downwardMovementPercent)
//
//        guard let interactor = interactor else { return }
//
//        switch sender.state {
//        case .began:
//            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
//        case .changed:
//            interactor.shouldFinish = progress > percentThreshold
//            interactor.update(progress)
//        case .cancelled:
//            interactor.hasStarted = false
//            interactor.cancel()
//        case .ended:
//            interactor.hasStarted = false
//            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
//        default:
//            break
//        }
    }
//
//    func showHelperCircle(){
//        let center = CGPoint(x: view.bounds.width * 0.5, y: 100)
//        let small = CGSize(width: 30, height: 30)
//        let circle = UIView(frame: CGRect(origin: center, size: small))
//        circle.layer.cornerRadius = circle.frame.width/2
//        circle.backgroundColor = UIColor.white
//        circle.layer.shadowOpacity = 0.8
//        circle.layer.shadowOffset = CGSize()
//        view.addSubview(circle)
//        UIView.animate(
//            withDuration: 0.5,
//            delay: 0.25,
//            options: [],
//            animations: {
//                circle.frame.origin.y += 200
//                circle.layer.opacity = 0
//            },
//            completion: { _ in
//                circle.removeFromSuperview()
//            }
//        )
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        showHelperCircle()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = String(describing: CardCollectionViewCell.self)
        collectionView.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
        presenter?.cofigureUI(collectionView: collectionView)
        
        let centeredFlowLayout = ParallaxCollectionViewLayout()

        DispatchQueue.main.async {
            self.collectionView.setCollectionViewLayout(centeredFlowLayout, animated: false)
        }

        centeredFlowLayout.itemSize = CGSize(
            width: view.bounds.width * 0.7,
            height: view.bounds.height * 0.7 * 0.7
        )
            
        centeredFlowLayout.minimumLineSpacing = 20
    }

    func scroll(to indexPath: IndexPath, animated: Bool) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }
    
    @IBAction func showPrevious(_ sender: UIButton) {
        guard let visibleIndexPath = collectionView.indexPathsForVisibleItems.sorted(by: { $0 < $1 }).first else {
            return
        }
        
        collectionView.scrollToItem(at: visibleIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func showNext(_ sender: UIButton) {
        guard let visibleIndexPath = collectionView.indexPathsForVisibleItems.sorted(by: { $0 < $1 }).last else {
            return 
        }
        collectionView.scrollToItem(at: visibleIndexPath, at: .centeredHorizontally, animated: true)
    }
}


extension CollectionWordsViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}

extension CollectionWordsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
