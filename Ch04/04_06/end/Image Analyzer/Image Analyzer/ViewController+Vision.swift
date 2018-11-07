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
    var detectionRequest: VNDetectFaceRectanglesRequest {
        let request = VNDetectFaceRectanglesRequest( completionHandler: { (request, error) in
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
    
    private func visualizeObservations(_ observations: [VNDetectedObjectObservation]) {
        DispatchQueue.main.async {
            guard let image = self.imageView.image else {
                print("Failed to retrieve image!")
                return
            }
            
            // 1. Transforms
            let imageSize = image.size
            // Transform the observation bounding rect from Quartz 2D coordinate system to UIKit coordinates
            // flip vertically and translate back after flipping
            var transform = CGAffineTransform.identity.scaledBy(x: 1, y: -1).translatedBy(x: 0, y: -imageSize.height)
            // Scale the normalized bounding box based on the image dimensions
            transform = transform.scaledBy(x: imageSize.width, y: imageSize.height)
        }
    }
}
