//
//  Copyright © 2019 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import Combine
import SwiftUI

final class PDFState: ObservableObject {
    let pdfDocuments = ["PSPDFKit 9 QuickStart Guide", "PSPDFKit for Web"]
    @Published var currentPDFIndex = 0
}
