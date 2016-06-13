//
//  ItinerarioViewController.swift
//  Event it
//
//  Created by Luis Felipe Salazar on 10/11/15.
//  Copyright © 2015 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class ItinerarioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation){
            //muestra horario
            print("horario")
            //self.navigationController!.navigationBar.hidden = true
            //self.tabBarController!.tabBar.hidden = true
            //itinerario = UIImageView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
            //itinerario.image = UIImage(named: "itinerario")
            //tabla.alpha = 0.0
            //itinerario.alpha = 1.0
            //view.addSubview(itinerario)
            
            //self.performSegueWithIdentifier("showItinerario", sender: self)
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation){
            //muestra view
            //print("dsf")
            //self.navigationController!.navigationBar.hidden = false
            //self.tabBarController!.tabBar.hidden = false
            //itinerario.removeFromSuperview()
            //tabla.alpha = 1.0
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
