//
//  ViewController.swift
//  pedometer
//
//  Created by Kyle Gorter on 3/19/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        self.pedometer.startUpdates(from: midnightOfToday!) { (data, error) in
            DispatchQueue.main.async {
                if(error == nil){
                    self.steps.text = "\(data.numberOfSteps)"
                }
            }
        }
        
     

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

