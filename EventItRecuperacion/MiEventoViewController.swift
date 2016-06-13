//
//  MiEventoViewController.swift
//  Event it
//
//  Created by Luis Felipe Salazar on 10/11/15.
//  Copyright © 2015 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class MiEventoViewController: UIViewController {
    
    @IBOutlet weak var itinerario: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        itinerario.alpha = 0.0
        
        
        let localNoti : UILocalNotification = UILocalNotification()
        
        localNoti.alertAction = "Texto Comida"
        
        localNoti.alertBody = "Es tu turno de pasar por la comida"
        
        localNoti.fireDate = NSDate(timeIntervalSinceNow: 10)
        
        localNoti.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNoti)
        
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
            self.navigationController!.navigationBar.hidden = true
            self.tabBarController!.tabBar.hidden = true
            itinerario.alpha = 1.0
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation){
            //muestra view
            print("dsf")
            self.navigationController!.navigationBar.hidden = false
            self.tabBarController!.tabBar.hidden = false
            
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
