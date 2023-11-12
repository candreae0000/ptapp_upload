//
//  ContentView.swift
//  photo
//
//  Created by Cecilia Andreae on 11/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //show image pickker
    @State var showImagePicker: Bool = false
    
    //show selected image
    @State var selectedImage: Image? = Image("")
    
    var body: some View {
        VStack {
            //create button to select image
            Button(action: {
                self.showImagePicker.toggle()
            }, label: {
                Text("select image")
            })
            
            //show image
            self.selectedImage?.resizable().scaledToFit()
            
            
            //show button to upload image
            Button(action:{
                //convert image into base 64
                
                let uiImage :UIImage = self.selectedImage.asUIImage()
                let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
                let imageStr: String =
                    imageData.base64EncodedString()
                
                //send request to server
                guard let url: URL = URL(string:"http://parktudor.org.192-185-10-227.hgws18.hgwin.temp.domains/photos/") else {
                    print("invalid URL")
                    return
                }
                
                //create parameters
                let paramStr: String = "image=\(imageStr)"
                let paramData: Data = paramStr.data(using:
                        .utf8) ?? Data()
                
                
                var urlRequest: URLRequest =
                    URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = paramData
                
                //required for sending large data
//                urlRequest.setValue("application/x-ww-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                //send request
                URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                    guard let data = data else {
                        print("invalid data")
                        return
                    }
                    
                    //show response in string
                    let responseStr: String = String(data: data, encoding: .utf8) ?? ""
                    print(responseStr)
                })
            
            }, label: {
                Text("Upload Image")
            })
        }
        .sheet(isPresented: $showImagePicker, content:
            {
            ImagePicker(image: self.$selectedImage)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
