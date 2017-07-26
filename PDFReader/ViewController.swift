//
//  ViewController.swift
//  PDFReader
//
//  Created by user129308 on 7/23/17.
//  Copyright © 2017 PDFReader. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //var nombres = ["Lidia", "Erick", "Fernando", "Danilo", "Scoly", "Khalessi", "Olga", "Teofilo", "Ruth", "Santos", "Robert", "Jody", "Pablo", "Luis", "David", "Jaime", "Samuel", "Isabel", "Larry"]
    
    var nombres = ["pdf1", "pdf2", "pdf3", "pdf1", "pdf2", "pdf3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nombres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"Cell")
        celda.textLabel?.text = nombres[indexPath.row]
        celda.imageView?.image = UIImage(named: "pdf.png")
        
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Usamos el segue definido en el Main.storyboard y le pasamos el dato indexPth.row
        self.performSegue(withIdentifier: "pantalla2Segue", sender: indexPath.row)
    }
    
    // Preparamos el Sugue, recibe el segue y un sender que es el dato
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pantalla2Segue" {
            let idPDF = sender as! Int
            let detailViewController:DetailViewController = segue.destination as! DetailViewController
            
            detailViewController.nombrePDF = nombres[idPDF]
        }
    }
    
    // to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            nombres.remove(at: indexPath.row) // Primero se elimina del array, luego del tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.reloadData() // Mejor usamos deleteRows
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // to support custom title button delete
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
}

