//
//  SplashViewController.swift
//  CALHAX
//
//  Created by Nabeel Mamoon on 10/7/17.
//  Copyright © 2017 Nabeel Mamoon. All rights reserved.
//

import UIKit
import QuartzCore

class SplashViewController: UIViewController {

    var gradient : CAGradientLayer?;
    
    
    
    @IBOutlet weak var NEWPIC: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        
        
        
        var col = UIColor(hue: 0.275, saturation: 0.68, brightness: 0.97, alpha: 1.0)
        
        self.gradient?.colors = [ col.cgColor, col.cgColor]
        self.view.layer.insertSublayer(self.gradient!, at: 0)
        
        animateLayer()
        // Do any additional setup after loading the view.
    }
    
    func animateLayer(){
        
        var fromColors = self.gradient?.colors
        var toColors: [AnyObject] = [ UIColor.clear.cgColor, UIColor.clear.cgColor]
        self.gradient?.colors = toColors // You missed this line
        var animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        //var animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        print("three")
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 3.00
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        //animation.delegate = self as UIViewController
        
        self.gradient?.add(animation, forKey:"animateGradient")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NEWPIC.layer.masksToBounds = true
        NEWPIC.layer.cornerRadius = 80
        NEWPIC.image = #imageLiteral(resourceName: "LOGO.jpg")
        print("NOW")
        let when = DispatchTime.now() + 3.0 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            print("DISPATCH")
            self.performSegue(withIdentifier: "SplashToMain", sender: self)
            //self.Comments.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
