  //
//  EventTableViewController.swift
//  Event it
//
//  Created by Luis Felipe Salazar on 10/10/15.
//  Copyright © 2015 Luis Felipe Salazar. All rights reserved.
//

import UIKit


class EventTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var tableEvents: UITableView!
    
    @IBOutlet weak var eventsSearchBar: UISearchBar!
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var imageView : UIImageView?
    var data: NSData?

    
    var values:NSArray = []

    
    var searchActive : Bool = false
    //var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    
    var eventos:[NSArray] = []
    var cuentas:[NSArray] = []
    
    var idEventos = [1, 2]
    var nombreEventos = ["Epic Hack", "Area"]
    var lugarEventos = [" Avenida Ignacio Morones Prieto 4500 Pte.,Jesús M. Garza,66238 San Pedro Garza García, N.L.", " RECINTO GRAND #2411 Ave. Eugenio Garza Sada 2411, dentro de Paseo Tec Col. Roma, Monterrey, N.L."]
    var latitudeEventos = [25.663883, 25.655018]
    var longitudeEventos = [-100.419892, -100.293282]
    var descripcionEventos = ["Te invitamos a participar a la primera edición de Epic Hack realizado en la Universidad de Monterrey, en esta ocasión queremos romper estereotipos, normalmente a un Hackathon asisten solo personas relacionadas a una carrera de TI, nosotros creemos que una carrera no determina un talento, así que si tienes una idea de proyecto pero no sabes nada de programación no te preocupes, estas en el lugar indicado. El Epic Hack se llevará a cabo los días 10 y 11 de octubre del presente año, con una duración de 30 horas. Este evento estará lleno de sorpresas, comenzaremos con un chapter en donde dos lideres en tecnología nos inspiraran a crear nuestros sueños, después tendremos 24 horas continuas de hacking e innovación, comida y convivencia con personas increíbles y por si fuera poco hasta te retaremos en una competencia de videojuegos", "Es el espacio para profesionistas, estudiantes y emprendedores de medios interactivos y creativos.\n\nJOIN\nEl evento es una permanente invitación a ser parte de la comunidad e involucrarse de manera activa participando en colaboración con el resto de los asistentes.\n\nFIND\nA través de cada actividad proporcionamos herramientas que impulsan la innovación y despiertan el deseo de descubrimiento\n\nGO\n“Call to action” con el que reconocemos a los asistentes como agentes de innovación y los enviamos a obtener nuevos y mejores resultados."]
    var imagenEvento = ["epicHack", "area"]
    var fechasEvento = ["10 y 11 de Octubre","23 y 24 de Octubre"]
    var costoEvento = [0, 450]
    
    var nombre = "Nombre"
    var lugar = "Lugar del evento"
    var location = "location"

    var descripcion = "Descripcion"
    var imagen = "nombre de la imagen"
    var fecha = "fecha evento"
    var costo = 0
    var latitude = 25.663883
    var longitude = -100.419892

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!) // not required when using UITableViewController
        get()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableEvents.delegate = self
        tableEvents.dataSource = self
        eventsSearchBar.delegate = self
    }
    func refresh(sender:AnyObject)
    {
        get()
        self.refreshControl!.endRefreshing()
    }

    func get(){
        let url = NSURL(string: "http://softitution.mx/obtener.php")
        let data = NSData(contentsOfURL: url!)
        values = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        tableView.reloadData()
        
        return
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(searchActive) {
            return filtered.count
        }
        return values.count;
        
    }
    
    //Search functions
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
        eventsSearchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        eventsSearchBar.showsCancelButton = false
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        eventsSearchBar.showsCancelButton = false
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        eventsSearchBar.showsCancelButton = false
        
        self.view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = nombreEventos.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let maindata = values[indexPath.row]
        print(values.count)
        if(searchActive){
        } else {
            var foto :UIImageView
            var myURL: String
            myURL=(maindata["fotoprofile"] as? String)!
            print(myURL)
           if let url  = NSURL(string: myURL),data = NSData(contentsOfURL: url)
            {
               imageView!.image = UIImage(data: data)
            }
            profile.image = UIImage(data: NSData(contentsOfURL: NSURL(string: myURL)!)!)
           cell.imageView?.image = imageView?.image
            cell.textLabel?.text = maindata["Nombre"] as?String
            cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 20)
           // cell.imageView?.image = UIImage(named: <#T##String#>)
            
            
        }


        return cell
    }
    
    override func viewDidLayoutSubviews() {
        if data != nil {
            imageView!.image = UIImage(data:data!)
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let maindata = values[indexPath.row]
        let lat :Double = (maindata["latitud"] as! NSString).doubleValue
        let lon :Double = (maindata["longitud"] as! NSString).doubleValue
        let foto=maindata["fotocover"] as! NSString
        
      /* if let url  = NSURL(string: foto as String),
            data = NSData(contentsOfURL: url)
        {
            self.imageView!.image = UIImage(data: data)
        }*/
        
        nombre = (maindata["Nombre"] as? String)!
        lugar = (maindata["Lugar"] as? String)!
        latitude = lat
        longitude = lon
        descripcion = (maindata["Description"] as? String)!
        //imagen = imagenEvento[row]
        fecha = (maindata["Fecha"]as? String)!
        costo = 0

        self.performSegueWithIdentifier("eventSegue", sender: self)
    }

    
    override func shouldAutorotate() -> Bool {
        if (UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown) {
                return true
        }
        else {
            return false
        }
    }
    

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let orientations = UIInterfaceOrientationMask.Portrait
        
        return (UIInterfaceOrientationMask.Portrait)
        
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "eventSegue"){
            
            //Pass Album and Title to next View
            let controller: EventoViewController = segue.destinationViewController as! EventoViewController
            controller.nombre = nombre
            controller.lugar = lugar
            //controller.location = location
            controller.latitude = latitude
            controller.longitude = longitude
            controller.descripcion = descripcion
            controller.imagen = imagen
            controller.fecha = fecha
            controller.costo = costo
        }
    }
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.imageView!.image = UIImage(data: data)
            }
        }
    }
    

}
