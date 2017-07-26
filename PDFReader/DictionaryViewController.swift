//
//  DictionaryViewController.swift
//  PDFReader
//
//  Created by user129308 on 7/26/17.
//  Copyright © 2017 PDFReader. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var palabra:String?
    
    /*
     https://es.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=Lima
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Para ocultar el teclado cuandpo presionamos la tecla ENTER implementamos un Delegate
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func buscar(_ sender: Any) {
        if(!textField.text!.isEmpty){
            palabra = textField.text!
            print(palabra!)
            
            let palabraEncode = palabra!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            print(palabraEncode!)
            
            let url = URL(string: "https://es.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=\(palabraEncode!)")
            print("\(String(describing: url))")
            
            let tarea = URLSession.shared.dataTask(with: url!){
                (datos, respuesta, error) in // Funciones anónimas o Closures
                print(datos ?? "EMPTY")
                print("Respuesta: \(String(describing: respuesta))")
                print("Error: \(String(describing: error))")
                
                if(error == nil){
                    
                    do{
                        
                        let jsonObject = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(jsonObject)
                        
                        
                        let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                        print(json)
                        
                        let querySubJson = json["query"] as! [String:Any]
                        //print(querySubJson)
                        
                        let pagesSubJson = querySubJson["pages"] as! [String:Any]
                        //print(pagesSubJson)
                        
                        let pageIds = pagesSubJson.keys
                        
                        let firstpageId = pageIds.first!
                        
                        // https://github.com/SwiftyJSON/SwiftyJSON
                        //let json = try JSON(data: datos!)
                        //print(json)
 
                        var extractStringHtml:String
                        
                        if(firstpageId != "-1"){
                            let idSubJson = pagesSubJson[firstpageId] as! [String:Any]
                            //print(idSubJson)
                            
                            extractStringHtml = idSubJson["extract"] as! String
                        }else{
                            extractStringHtml = "<center><H1>Error 404:</H1> <b>Not Found</b></center>"
                        }
                        
                        print(extractStringHtml)
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.webView.loadHTMLString(extractStringHtml, baseURL: nil)
                            
                        })
                        
                    }catch{
                        print("Procesamiento JSON ha fallado!")
                    }
                    
                }else{
                    print("Error: \(error!)")
                }
                
            }
            
            tarea.resume()
        }
    }
    
}
