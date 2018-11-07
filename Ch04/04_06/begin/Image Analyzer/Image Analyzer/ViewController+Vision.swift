//
//  ViewController+Vision.swift
//  Image Analyzer
//
//  Created by Nyisztor, Karoly on 10/30/18.
//  Copyright © 2018 Nyisztor, Karoly. All rights reserved.
//

import UIKit
import Vision

extension ViewController {
    // Detection request
    var detectionRequest: VNDetectBarcodesRequest {
        let request = VNDetectBarcodesRequest( completionHandler: { (request, error) in
            if let detectError = error as NSError? {
                print(detectError)
                return
            } else {
                guard let observations = request.results as? [VNDetectedObjectObservation] else {
                    return
                }
                
                print(observations)
            }
        })
        
        return request
    }
    
    func performVisionRequest(image: UIImage) {
        guard let cgImage = image.cgImage else {
            return
        }
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage,
                                                        orientation: image.cgOrientation,
                                                        options: [:])
        let requests = [detectionRequest]
        // Send the requests to the request handler.
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform(requests)
            } catch let error as NSError {
                print("Failed to perform image request: \(error)")
                return
            }
        }
    }
}
