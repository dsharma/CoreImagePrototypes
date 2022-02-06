//
//  Renderers.swift
//  SampleVideoEditorForBugReports
//
//  Created by Deepak Sharma on 05/02/22.
//

import CoreImage

class CIMetalPassthroughRenderer: CIFilter {
    var inputImage:CIImage?
    
    static var kernel:CIColorKernel = { () -> CIColorKernel in

        let bundle = Bundle.main
        let url = bundle.url(forResource: "Kernels", withExtension: "ci.metallib")!
        let data = try! Data(contentsOf: url)
        return try! CIColorKernel(functionName: "passthrough", fromMetalLibraryData: data)
        
    }()
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        return CIMetalPassthroughRenderer.kernel.apply(extent: inputImage.extent, arguments: [inputImage])
    }
}

class CIMetalTestRenderer: CIFilter {
    var inputImage:CIImage?
    
    static var kernel:CIKernel = { () -> CIKernel in

        let bundle = Bundle.main
        let url = bundle.url(forResource: "Kernels", withExtension: "ci.metallib")!
        let data = try! Data(contentsOf: url)
        return try! CIKernel(functionName: "testKernel", fromMetalLibraryData: data)
        
    }()
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        let dod = inputImage.extent.insetBy(dx: -10, dy: -10)
        return CIMetalTestRenderer.kernel.apply(extent: dod, roiCallback: { index, rect in
            return rect
        }, arguments: [inputImage])
    }
}

class CIMetalRedColorKernel: CIFilter {
    var inputImage:CIImage?
    
    static var kernel:CIKernel = { () -> CIKernel in

        let bundle = Bundle.main
        let url = bundle.url(forResource: "Kernels", withExtension: "ci.metallib")!
        let data = try! Data(contentsOf: url)
        return try! CIKernel(functionName: "redKernel", fromMetalLibraryData: data)
        
    }()
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        let dod = inputImage.extent
        return CIMetalRedColorKernel.kernel.apply(extent: dod, roiCallback: { index, rect in
            return rect
        }, arguments: [inputImage])?.cropped(to: dod)
    }
}
