//
//  ViewController.swift
//  GR Tutorial
//
//  Created by Uladzislau Daratsiuk on 2018-02-13.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fileImage: UIImageView!
    @IBOutlet weak var trashImage: UIImageView!
    
    var fileViewOrgin: CGPoint!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPanGesture(view: fileImage)
        fileViewOrgin = fileImage.frame.origin
        view.bringSubview(toFront: fileImage)
     
    }

  
    
    func addPanGesture(view: UIView){
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        
        
    }
    
    //Refactor
    
    @objc func handlePan(sender: UIPanGestureRecognizer){
        
        let fileView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            
            fileView.center = CGPoint(x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            
        case .ended:
            if fileView.frame.intersects(trashImage.frame){
                deleteImage(view: fileImage)
            }else {
                returnOriginPos(view: fileImage)
            }
        default:
            break
        }
        
        
    }
    
    func deleteImage(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }
    
    
    func returnOriginPos(view:UIView){
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileViewOrgin
        })
        
    }

}

