//
//  EventoViewController.swift
//  Event it
//
//  Created by Luis Felipe Salazar on 10/11/15.
//  Copyright © 2015 Luis Felipe Salazar. All rights reserved.
//

import UIKit
import MapKit

class EventoViewController: UIViewController, MKMapViewDelegate {
    
    var nombre = "Nombre"
    var lugar = "Lugar del evento"
    var location = "location"
    var descripcion = "Descripcion"
    var imagen = "nombre de la imagen"
    var fecha = "fecha evento"
    var costo = 0
    var latitude = 25.663883
    var longitude = -100.419892

    @IBOutlet weak var fechaEvento: UILabel!
    @IBOutlet weak var imagenEvento: UIImageView!
    @IBOutlet weak var descripcionEvento: UITextView!
    @IBOutlet weak var lugarEvento: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = nombre
        fechaEvento.text = fecha
        imagenEvento.image = UIImage(named: imagen)
        descripcionEvento.text = descripcion
        lugarEvento.setTitle(lugar, forState: UIControlState.Normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registrarse(sender: AnyObject) {
    }

    @IBAction func eventoTap(sender: AnyObject) {
        /*
        var lat1 : NSString = self.latitude
        var lng1 : NSString = self.longitude
        */
        let latitute:CLLocationDegrees =  latitude
        let longitute:CLLocationDegrees =  longitude
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.nombre)"
        mapItem.openInMapsWithLaunchOptions(options)
        
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
