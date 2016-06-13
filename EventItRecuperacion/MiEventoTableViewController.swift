//
//  MiEventoTableViewController.swift
//  Event it
//
//  Created by Luis Felipe Salazar on 10/11/15.
//  Copyright © 2015 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class MiEventoTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let localNoti : UILocalNotification = UILocalNotification()
        
        localNoti.alertAction = "Texto Comida"
        
        localNoti.alertBody = "Es tu turno de pasar por la comida"
        
        localNoti.fireDate = NSDate(timeIntervalSinceNow: 5)
        
        localNoti.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNoti)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation){
            //muestra horario
            print("horario")
            self.navigationController!.navigationBar.hidden = true
            self.tabBarController!.tabBar.hidden = true
            //itinerario = UIImageView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
            //itinerario.image = UIImage(named: "itinerario")
            //tabla.alpha = 0.0
            //itinerario.alpha = 1.0
            //view.addSubview(itinerario)
            
            self.performSegueWithIdentifier("showItinerario", sender: self)
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation){
            //muestra view
            print("dsf")
            self.navigationController!.navigationBar.hidden = false
            self.tabBarController!.tabBar.hidden = false
            //itinerario.removeFromSuperview()
            //tabla.alpha = 1.0
        }
    }

    

}
