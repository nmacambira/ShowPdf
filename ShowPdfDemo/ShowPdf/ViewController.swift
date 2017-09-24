//
//  ViewController.swift
//  ShowPdf
//
//  Created by Natalia Macambira on 23/09/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var documentInteractionController: UIDocumentInteractionController!
    var urlRequest: URLRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }    
    
    // MARK: - Actions
    
    @IBAction func loadPdfFromDisk(_ sender: UIButton) {
        
        if let pdfUrl = NMFileManager.getFile("pdfDisk.pdf"){
            documentInteractionController = UIDocumentInteractionController(url: pdfUrl)
            documentInteractionController.delegate = self
            documentInteractionController.presentPreview(animated: true)
        } else {
            print("Pdf file not found")
        }
    }
    
    @IBAction func loadPdfFromAppsFolder(_ sender: UIButton) {
       if let pdfUrl = Bundle.main.url(forResource: "pdfAppsFolder", withExtension: "pdf", subdirectory: nil, localization: nil)  {        
            urlRequest = URLRequest(url: pdfUrl)
            performSegue(withIdentifier: "showPdfOnWebView", sender: self)
            
        } else {
            print("Pdf file doesn't exist")
        }
    }
    
    @IBAction func loadPdfFromWeb(_ sender: UIButton) {
        if let pdfUrl = URL(string: "someURL/pdfWeb.pdf") {
            urlRequest = URLRequest(url: pdfUrl)
            performSegue(withIdentifier: "showPdfOnWebView", sender: self)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPdfOnWebView" {
            guard let urlRequest = self.urlRequest else { return }
            let destination = segue.destination as! WebViewController
            destination.urlRequest = urlRequest
        }
    }
}

extension ViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
