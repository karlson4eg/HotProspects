//
//  MeView.swift
//  HotProspects
//
//  Created by Evi St on 4/26/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreImage

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    @State private var QRCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: QRCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: QRCode)
                                                       
                        } label: {
                            Label("Save my QR",systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateQRCode) //so it will not update every time the body is loaded
            .onChange(of: name) { _ in updateQRCode() }
            .onChange(of: emailAddress) { _ in updateQRCode() }
        }
    }
    func updateQRCode() {
        QRCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message  = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
