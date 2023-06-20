//
//  storage.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 31/03/23.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase


//    MARK :- Upload Image to firebase storage and Recive Url

    func uploadImageAndGetUrl(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "Invalid image data", code: 0)))
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).jpg")
        
        let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let url = url else {
                    completion(.failure(NSError(domain: "Invalid download URL", code: 0)))
                    return
                }
                
                completion(.success(url))
            }
        }
        
        uploadTask.resume()
    }


//MARK :- Use

//uploadImageAndGetUrl(image: image) { result in
//    switch result {
//    case .success(let url):
//        // Handle the URL returned from Firebase Storage
//        print("Image uploaded successfully. URL: \(url)")
//    case .failure(let error):
//        // Handle the error returned from Firebase Storage
//        print("Error uploading image: \(error.localizedDescription)")
//    }
//}
