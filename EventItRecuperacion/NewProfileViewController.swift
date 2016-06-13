//
//  NewProfileViewController.swift
//  Event it
//
//  Created by Luis Felipe Salazar on 10/10/15.
//  Copyright © 2015 Luis Felipe Salazar. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class NewProfileViewController: UIViewController {
    
    var nombre : String = ""
    var apellido : String = ""
    var Correo : String = ""
    var Password : String = ""
    var urlfoto : String = ""
    

    @IBOutlet weak var textNombre: UITextField!
    @IBOutlet weak var textApellido: UITextField!
    @IBOutlet weak var textCorreo: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    @IBAction func Presionado(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.softitution.mx/registrarusuario.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(textNombre.text!)&b=\(textApellido.text!)&c=\("Masculino")&d=\(textCorreo.text!)&e=\(urlfoto)&f=\(contra.text)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        
        }
    }
    
    @IBOutlet var contra: UITextField!
    
    @IBOutlet weak var sexSelector: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let url  = NSURL(string: urlfoto),
            data = NSData(contentsOfURL: url)
        {
            profilePic.image = UIImage(data: data)
        }
        
        textNombre.text=nombre
        textApellido.text=apellido
        textCorreo.text=Correo
        
        // Do any additional setup after loading the view.
        (FBSDKProfile.enableUpdatesOnAccessTokenChange(true))
        navigationItem.title = "Registro de cuenta"
        
        textNombre.becomeFirstResponder()
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sexAction(sender: UISegmentedControl) {
        switch sexSelector.selectedSegmentIndex {
        case 0:
            EMPTY
        case 1:
            EMPTY
        default:
            break;
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
