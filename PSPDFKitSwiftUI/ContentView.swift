//
//  Copyright © 2019 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import SwiftUI
import PSPDFKit
import PSPDFKitUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        return AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
    }
}

struct ContentView: View {
    @EnvironmentObject private var pdfState: PDFState

    var documentURL:URL {
        return Bundle.main.url(forResource: pdfState.pdfDocuments[pdfState.currentPDFIndex], withExtension: "pdf")!
    }

    let configuration = PSPDFConfiguration {
        $0.pageTransition = .scrollContinuous
        $0.pageMode = .single
        $0.scrollDirection = .vertical
        $0.backgroundColor = .white
        $0.spreadFitting = .fill

    }
    @State var showViewer = false

    var animation: Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.1)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $showViewer.animation()) {
                Text("Display PDF")
            }
            HStack(alignment: .center) {
                Text("PDF")
                Picker(selection: $pdfState.currentPDFIndex, label: Text("PDF")) {
                    ForEach(0 ..< pdfState.pdfDocuments.count) {
                        Text(self.pdfState.pdfDocuments[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            if showViewer {
                PSPDFKitView(url: documentURL, configuration: configuration)
                .transition(.moveAndFade)
                .animation(animation)
                .onAppear {
                    print("Displaying the PDF")
                }
            }
            else {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Welcome!")
                        .font(.title)
                        .padding(.bottom)
                    Text("Ready to display \"\(self.pdfState.pdfDocuments[self.pdfState.currentPDFIndex])\"")
                    Spacer()
                }
                .transition(.moveAndFade)
                .animation(animation)
                .onAppear {
                    print("Displaying the welcome message")
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(PDFState())
    }
}
