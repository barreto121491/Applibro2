//
//  ViewController.swift
//  AppLibros2
//
//  Created by Arturo Barreto Villafán on 11/29/15.
//  Copyright © 2015 Arturo Barreto Villafán. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titu: UILabel!
    @IBOutlet weak var claveIntroducida: UITextField!
    
    @IBOutlet weak var portada: UILabel!
    
    @IBOutlet weak var autor: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        claveIntroducida.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   let urlh = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    
    func sincrono(){
        let ISBN = claveIntroducida.text!
        let urlh = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urlh+ISBN)
        let datos : NSData? = NSData(contentsOfURL: url!)
        if datos == nil{
            let alercontroller = UIAlertController(title: nil, message: "Error en la Red", preferredStyle: UIAlertControllerStyle.Alert)
            alercontroller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: nil))
            
            self.presentViewController(alercontroller, animated: true, completion: nil)
            
        }
        else{
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableContainers)
                let dico = json as! NSDictionary
                   let dico1 = dico["ISBN:"+ISBN]
                if (dico1 != nil && dico1 is NSDictionary){
                    let dico2  = dico1 as! NSDictionary
                print(dico2["title"])
                titu.text = dico2["title"] as! NSString as String
                if (dico2["cover"] == nil){
                    portada.text = "no hay portada"
                    
                }
                else{
                    portada.text = dico2["cover"] as! NSString as String
                }
                // digo que dico3 es un array por los corchetes que nos muestra en el json
                let dico3 = dico2["authors"] as! NSArray
                
               // recorremos el arreglo buscando la posiciion de "name " que corresponde al nombre
                for (var i = 0; i < dico3.count; i++ ){
                    let autores = dico3[i] as! NSDictionary
                    print(autores["name"])
                    autor.text = autores["name"] as! NSString as String
                    
                    print(dico3[i])
                    
                }
              
                }
                else{
                    let alercontroller = UIAlertController(title: nil, message: "No Existe ese Libro", preferredStyle: UIAlertControllerStyle.Alert)
                    alercontroller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: nil))
                    
                    self.presentViewController(alercontroller, animated: true, completion: nil)
                }
                
            }
            catch _ {
               
                
            }
        }
        
        
        
        
        
    }
    func comprobar(texto : UITextField){
        if texto.text == ""{
            let alercontroller = UIAlertController(title: nil, message: "Escriba un Numero", preferredStyle: UIAlertControllerStyle.Alert)
            alercontroller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: nil))
            
            self.presentViewController(alercontroller, animated: true, completion: nil)
            
        }
        else{
            sincrono()
        }
        
        
        
    }



    @IBAction func Busqueda(sender: UITextField) {
        comprobar(sender)
        
            }
    @IBAction func limpiar(sender: AnyObject) {
        claveIntroducida.text = ""
        titu.text  = ""
        autor.text = ""
        portada.text = ""
        
    }
}

