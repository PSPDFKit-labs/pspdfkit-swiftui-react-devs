//
//  Copyright © 2019 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import SwiftUI
import PSPDFKitUI

struct PSPDFKitView: View {
    var url: URL
    var configuration: PSPDFConfiguration?
    
    var body: some View {
        PDFViewController(url, configuration: configuration)
    }
}

struct PSPDFKitView_Preview: PreviewProvider {
    static var previews: some View {
        PSPDFKitView(url: Bundle.main.bundleURL.appendingPathComponent("PSPDFKit 9 QuickStart Guide.pdf"), configuration: PSPDFConfiguration { $0.pageTransition = .scrollPerSpread })
    }
}

struct PDFViewController: UIViewControllerRepresentable {
    let url: URL
    let configuration: PSPDFConfiguration?

    init(_ url: URL, configuration: PSPDFConfiguration?) {
        self.url = url
        self.configuration = configuration
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PDFViewController>) -> UINavigationController {
        // Create a PSPDFDocument
        let document = PSPDFDocument(url: url)
        
        // Create the PSPDFViewController
        let pdfController = PSPDFViewController(document: document, configuration: configuration)
        return UINavigationController(rootViewController: pdfController)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<PDFViewController>) {
        // update view
    }
}
