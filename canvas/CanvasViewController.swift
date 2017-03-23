//
//  CanvasViewController.swift
//  canvas
//
//  Created by Shumba Brown on 3/23/17.
//  Copyright © 2017 Shumba Brown. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var tray: UIView!
    var trayOriginalCenter: CGPoint!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var trayDownOffset: CGFloat!
    var newFaceOriginalCenter = CGPoint()
    var newFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.trayDownOffset = 170.0
        self.trayUp = tray.center
        self.trayDown = CGPoint(x: tray.center.x ,y: tray.center.y + trayDownOffset)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        var velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = tray.center
            tray.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            print("Gesture began")
        } else if sender.state == .changed {
            print("Gesture is changing")
        } else if sender.state == .ended {
            print("Gesture ended")
            if velocity.y < 0 {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: [], animations: {
                    self.tray.center = self.trayUp

                }, completion: nil)
                
            }
            else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.tray.center = self.trayDown
                    
                }, completion: nil)
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        var newFaceOriginalCenter = CGPoint()
        
        
        if sender.state == .began {
            
            
            var faceSelected = sender.view as! UIImageView
            self.newFace = UIImageView(image: faceSelected.image)
            self.newFace.isUserInteractionEnabled = true
            self.topView.addSubview(self.newFace)
            self.newFace.center = faceSelected.center
            self.newFace.center.y += tray.frame.origin.y
            self.newFaceOriginalCenter = self.newFace.center
            self.newFace.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            self.newFace.addGestureRecognizer(panGestureRecognizer)
            //newFaceOriginalCenter.y = newFace.center.y
        }
        if sender.state == .changed {
            let translation = sender.translation(in: view)
            self.newFace.center = CGPoint(x: self.newFaceOriginalCenter.x + translation.x, y: self.newFaceOriginalCenter.y + translation.y)

        }
    }
    
    func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            self.newFace = sender.view as! UIImageView
            self.newFaceOriginalCenter = self.newFace.center
            print("Gesture began")
        } else if sender.state == .changed {
            self.newFace.center = CGPoint(x: self.newFaceOriginalCenter.x + translation.x, y: self.newFaceOriginalCenter.y + translation.y)

            print("Gesture is changing")
        } else if sender.state == .ended {
            print("Gesture ended")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
