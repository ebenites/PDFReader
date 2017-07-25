//
//  DetailViewController.swift
//  PDFReader
//
//  Created by user129308 on 7/24/17.
//  Copyright © 2017 PDFReader. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var webview: UIWebView!
    
    var nombrePDF:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitulo.text = nombrePDF!
        
        habilitarZoom()
        
        mostrarPDF()
    }

    func habilitarZoom(){
        webview.scalesPageToFit = true
    }
    
    func mostrarPDF(){
        
        // 1: Direccion del archivo PDF
        let fileURLWithPath = Bundle.main.path(forResource: nombrePDF!, ofType: "pdf", inDirectory: "PDF") // inDirectory es la carpeta donde esta os pdfs
        let urlPDF = URL(fileURLWithPath: fileURLWithPath!)
        
        // 2: Transformar archivo PDF en Data
        let dataPDF = try? Data(contentsOf: urlPDF)
        
        // 3: Mostrar Datos en el WebView
        webview.load(dataPDF!, mimeType: "application/pdf", textEncodingName: "utf-8", baseURL: urlPDF)
        
    }
    
}
