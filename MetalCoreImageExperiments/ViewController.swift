//
//  ViewController.swift
//  MetalCoreImageExperiments
//
//  Created by Deepak Sharma on 06/02/22.
//

import UIKit
import Metal
import MetalKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        generateSolidImage()
    }

    private func generateSolidImage() {
        
        let renderSize = imageView.bounds.size
        
        let solidSize = CGSize(width: renderSize.width * 0.5, height: renderSize.height * 0.5)
        
        var solidImage = CIImage(color: CIColor(red: 0.3, green: 0.6, blue: 0.754, alpha: 1))
        
        var cropRect = CGRect.zero
        cropRect.size = solidSize
        solidImage = solidImage.cropped(to: cropRect)
        solidImage = solidImage.transformed(by: CGAffineTransform.init(translationX: -10, y: -10))
        
        let metalRenderer = CIMetalRedColorKernel()
        metalRenderer.inputImage = solidImage
        
        var outputImage = metalRenderer.outputImage
        
        outputImage = outputImage?.transformed(by: CGAffineTransform.init(translationX: 20, y: 20))
        let cyanImage = CIImage(color: CIColor.cyan).cropped(to: CGRect(x: 0, y: 0, width: renderSize.width, height: renderSize.height))
        
        outputImage = outputImage?.composited(over: cyanImage)
        
        let ciContext = CIContext()
        
        let cgImage = ciContext.createCGImage(outputImage!, from: outputImage!.extent)
        
        imageView.image = UIImage(cgImage: cgImage!)
        
    }

}

