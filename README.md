# ShowPdf

Show Pdf from Xcode folder (Bundle), from disk and from web using UIWebView or UIDocumentInteractionController

 
## Show pdf with UIDocumentInteractionController

```swift

clas ViewController: UIViewController {
    var documentInteractionController: UIDocumentInteractionController!

    func loadPdfWihDocumentInteractionController() {

        //Pdf from Xcode folder (Bundle)
        if let bundleUrl = Bundle.main.url(forResource: "documentName", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            documentInteractionController = UIDocumentInteractionController(url: pdfUrl)
            documentInteractionController.delegate = self
            documentInteractionController.presentPreview(animated: true)
        }

        OR

        //Pdf from from disk
        let fileName = "documentName.pdf"
        let fileManager = FileManager.default    
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {        
            if fileManager.fileExists(atPath: documentDirectoryFileUrl.path) {
                let fileUrl = documentDirectory.appendingPathComponent(fileName)
                documentInteractionController = UIDocumentInteractionController(url: pdfUrl)
                documentInteractionController.delegate = self
                documentInteractionController.presentPreview(animated: true)
            }
        }

        OR

        //Pdf from from web do not work with UIDocumentInteractionController
    }
}

extension ViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
    return self
    }
}       

```

## Show pdf with UIWebView
```swift
func loadPdfWithWebView() {
    //Pdf from Xcode folder (Bundle)
    if let bundleUrl = Bundle.main.url(forResource: "documentName", withExtension: "pdf", subdirectory: nil, localization: nil)  {
        let request = URLRequest(URL: bundleUrl)
        webView.loadRequest(request)
    }

    OR

    //Pdf from from disk
    let fileName = "documentName.pdf"
    let fileManager = FileManager.default    
    if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {        
        if fileManager.fileExists(atPath: documentDirectoryFileUrl.path) {
            let fileUrl = documentDirectory.appendingPathComponent(fileName)
            let requestURL = URL(string: url)
            let request = URLRequest(URL: requestURL!)
            webView.loadRequest(request)
        }
    }   

    OR

    //Pdf from from web
    let url = "https://.../documentName.pdf"
    let requestURL = URL(string: url)
    let request = URLRequest(URL: requestURL!)
    webView.loadRequest(request)
}
```

## License

[MIT License](https://github.com/nmacambira/ShowPdf/blob/master/LICENSE)

## Info

- Swift 3.1 

