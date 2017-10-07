//
//  StartViewController.swift
//  CALHAX
//
//  Created by Nabeel Mamoon on 10/7/17.
//  Copyright © 2017 Nabeel Mamoon. All rights reserved.
//

import UIKit
import QuartzCore


class StartViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var OutPutBox: UITextView!
    
    @IBOutlet weak var AppName: UILabel!
    
    @IBOutlet weak var TextBox: UITextView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    
    @IBOutlet weak var inputbutton: UIButton!
    
    @IBOutlet weak var outputbutton: UIButton!
    
    var gradient : CAGradientLayer?;
    
    var typing = false
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        OutPutBox.layer.masksToBounds = true
     
        TextBox.layer.masksToBounds = true
        TextBox.delegate = self
        TextBox.layer.borderColor = UIColor.green.cgColor
        TextBox.layer.borderWidth = 2.0
     
        
        
        
        OutPutBox.layer.borderColor = UIColor.green.cgColor
        OutPutBox.layer.borderWidth = 2.0
        
        
        OutPutBox.layer.cornerRadius = 10
        OutPutBox.isEditable = false
        TextBox.layer.cornerRadius = 10
        inputbutton.layer.cornerRadius = 10
        inputbutton.backgroundColor = UIColor(hue: 0.2306, saturation: 0.26, brightness: 0.99, alpha: 1.0)
        outputbutton.layer.cornerRadius = 10
        outputbutton.backgroundColor = UIColor(hue: 0.2306, saturation: 0.26, brightness: 0.99, alpha: 1.0)
        
        
        TitleLabel.layer.masksToBounds = true
        TitleLabel.layer.cornerRadius = 10
        TitleLabel.backgroundColor = UIColor(hue: 0.2306, saturation: 0.26, brightness: 0.99, alpha: 1.0)
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        
        
        
        var col = UIColor(hue: 0.275, saturation: 0.68, brightness: 0.97, alpha: 1.0)
        
        self.gradient?.colors = [ col.cgColor, col.cgColor]
        self.view.layer.insertSublayer(self.gradient!, at: 0)
        
        animateLayer()

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
        animation.duration = 2.00
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        //animation.delegate = self as UIViewController
        
        self.gradient?.add(animation, forKey:"animateGradient")
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //PostBox.text = ""
        if !typing {
            print("AAAA")
            TextBox.becomeFirstResponder()
            //print("here")
            outputbutton.backgroundColor = UIColor.green
        }
        else {
            //print("here")
            print("BBB")
            TextBox.becomeFirstResponder()
        }
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func OutputPressed(_ sender: UIButton) {
        
        TextBox.endEditing(true)
        outputbutton.backgroundColor = UIColor(hue: 0.2306, saturation: 0.26, brightness: 0.99, alpha: 1.0)
        
        var textToSimplify = TextBox.text
        
        
        
        let parameters = ["link": "http://techcrunch.com/2015/04/06/john-oliver-just-changed-the-surveillance-reform-debate"] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "www.thisismylink.com/postName.php")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                    var text = json["return"] as! String
                    self.OutPutBox.text = text
                    
                    
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
        
        
        
        
        
        
        
        
        
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
