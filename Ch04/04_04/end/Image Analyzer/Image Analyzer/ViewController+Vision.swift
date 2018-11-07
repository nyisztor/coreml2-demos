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
    func performVisionRequest(image: UIImage) {
        guard let cgImage = image.cgImage else {
            return
        }
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage,
                                                        orientation: image.cgOrientation,
                                                        options: [:])
    }
}
