//
//  FriendsViewController.swift
//  vkontakte
//
//  Created by Аня on 06.04.2022.
//

import UIKit
import Kingfisher

class FriendsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        view.addGestureRecognizer(recognizer)
        
        photoCurent.kf.setImage(with: URL(string: allPhotos[countCurentPhoto].photo))

    }
    
    @IBOutlet weak var photoCurent: UIImageView!
    
    var allPhotos:[Photos] = []
    var countCurentPhoto = 0
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(
                duration: 0.5,
                curve: .easeInOut,
                animations: {
                    self.photoCurent.alpha = 0.5
                    self.photoCurent.transform = .init(scaleX: 1.5, y: 1.5)
            })
            interactiveAnimator.pauseAnimation()
            
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = abs(translation.x / 100)
            self.photoCurent.transform = CGAffineTransform(translationX: translation.x, y: 0)
            
        case .ended:
            interactiveAnimator.stopAnimation(true)
            if recognizer.translation(in: self.view).x < 0 {
                if  countCurentPhoto < allPhotos.count - 1  {
                    self.countCurentPhoto += 1
                }
            } else {
                if countCurentPhoto != 0 {
                    self.countCurentPhoto -= 1
                }
            }
            interactiveAnimator.addAnimations {
                self.photoCurent.transform = .identity
                self.photoCurent.alpha = 1
            }
            interactiveAnimator?.startAnimation()
            
        default: break
        }
        photoCurent.kf.setImage(with: URL(string: allPhotos[countCurentPhoto].photo))
    }
    
}
