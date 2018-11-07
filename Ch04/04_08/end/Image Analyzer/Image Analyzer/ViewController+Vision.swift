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
    var barcodesDetectionRequest: VNDetectBarcodesRequest {
        let request = VNDetectBarcodesRequest( completionHandler: { (request, error) in
            // The rest of the code remains unchanged
            if let detectError = error as NSError? {
                print(detectError)
                return
            } else {
                guard let observations = request.results as? [VNDetectedObjectObservation] else {
                    return
                }
                
                print(observations)
                self.visualizeObservations(observations)
            }
        })
        
        return request
    }

    var rectangleDetectionRequest: VNDetectRectanglesRequest {
        let request = VNDetectRectanglesRequest( completionHandler: { (request, error) in
            if let detectError = error as NSError? {
                print(detectError)
                return
            } else {
                guard let observations = request.results as? [VNDetectedObjectObservation] else {
                    return
                }
                
                print(observations)
                self.visualizeObservations(observations)
            }
        })
        
        // Detect only certain rectangles
        //request.maximumObservations = 0
        //request.minimumConfidence = 0.5
        //request.minimumAspectRatio = 0.4
        
        return request
    }

    var faceDetectionRequest: VNDetectFaceRectanglesRequest {
        let request = VNDetectFaceRectanglesRequest( completionHandler: { (request, error) in
            if let detectError = error as NSError? {
                print(detectError)
                return
            } else {
                guard let observations = request.results as? [VNDetectedObjectObservation] else {
                    return
                }
                
                print(observations)
                self.visualizeObservations(observations)
            }
        })
        
        return request
    }
    
    var textDetectionRequest: VNDetectTextRectanglesRequest {
        let request = VNDetectTextRectanglesRequest( completionHandler: { (request, error) in
            if let detectError = error as NSError? {
                print(detectError)
                return
            } else {
                guard let observations = request.results as? [VNDetectedObjectObservation] else {
                    return
                }
                
                print(observations)
                self.visualizeObservations(observations)
            }
        })
        
        request.reportCharacterBoxes = true
        
        return request
    }

    
    func performVisionRequest(image: UIImage) {
        guard let cgImage = image.cgImage else {
            return
        }
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage,
                                                        orientation: image.cgOrientation,
                                                        options: [:])
        let requests = [rectangleDetectionRequest, textDetectionRequest, faceDetectionRequest, barcodesDetectionRequest]
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
            
            // 2. Rendering
            UIGraphicsBeginImageContextWithOptions(imageSize, true, 0.0)
            let context = UIGraphicsGetCurrentContext()
            
            // Draw the image in the current graphics context within the boundaries of the provided rectangle
            image.draw(in: CGRect(origin: .zero, size: imageSize))
            
            // saves the current graphics state before we change line, stroke color and fill color properties
            context?.saveGState()
            
            // set line properties
            context?.setLineWidth(8.0)
            context?.setLineJoin(CGLineJoin.round)
            context?.setStrokeColor(UIColor.red.cgColor)
            context?.setFillColor(red: 1, green: 0, blue: 0, alpha: 0.3)
            
            observations.forEach({ observation in
                // transform the observation's bounding rectangle to the UIKit coordinate system and scale it based on the image dimensions
                let observationBounds = observation.boundingBox.applying(transform)
                // add the rectangular path
                context?.addRect(observationBounds)
            })
            
            // draw the paths
            context?.drawPath(using: CGPathDrawingMode.fillStroke)
            
            // restores the current graphics state
            context?.restoreGState()
            // get the final image
            let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            // replace image drawn in ImageView
            self.imageView.image = drawnImage
        }
    }
}
