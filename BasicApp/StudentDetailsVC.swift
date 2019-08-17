//
//  StudentDetailsVC.swift
//  BasicApp
//
//  Created by Randhir raj on 1/20/19.
//  Copyright © 2019 Randhir raj. All rights reserved.
//

import UIKit
import AVFoundation

class StudentDetailsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       DataManager.shared.saveStudentDetails()
      // DataManager.shared.saveSubjeectDetails()
     // DataManager.shared.getTableDetails(tableName: "Student")
        
        
        let outputURL = NSURL.fileURL(withPath: "TempPath")
        let inputURL = NSURL.fileURL(withPath: "VideoWithWatermarkPath")
        addWatermark(inputURL: inputURL, outputURL: outputURL, handler: { (exportSession) in
            guard let session = exportSession else {
                // Error
                return
            }
            switch session.status {
            case .completed:
                guard NSData(contentsOf: outputURL) != nil else {
                    // Error
                    return
                }
                
                // Now you can find the video with the watermark in the location outputURL
            default:
                // Error
                break
                
            }
        })
    }
    
    
    func addWatermark(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let mixComposition = AVMutableComposition()
        let asset = AVAsset(url: inputURL)
        let videoTrack = asset.tracks(withMediaType: AVMediaType.video)[0]
        let timerange = CMTimeRangeMake(start: CMTime.zero, duration: asset.duration)
        
        let compositionVideoTrack:AVMutableCompositionTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid))!
        
        do {
            try compositionVideoTrack.insertTimeRange(timerange, of: videoTrack, at: CMTime.zero)
            compositionVideoTrack.preferredTransform = videoTrack.preferredTransform
        } catch {
            print(error)
        }
        
        let watermarkFilter = CIFilter(name: "CISourceOverCompositing")!
        let watermarkImage = CIImage(image: UIImage(named: "waterMark")!)
        let videoComposition = AVVideoComposition(asset: asset) { (filteringRequest) in
            let source = filteringRequest.sourceImage.clampedToExtent()
            watermarkFilter.setValue(source, forKey: "inputBackgroundImage")
            let transform = CGAffineTransform(translationX: filteringRequest.sourceImage.extent.width - (watermarkImage?.extent.width)! - 2, y: 0)
            watermarkFilter.setValue(watermarkImage?.transformed(by: transform), forKey: "inputImage")
            filteringRequest.finish(with: watermarkFilter.outputImage!, context: nil)
        }
        
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPreset640x480) else {
            handler(nil)
            return
        }
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.videoComposition = videoComposition
        exportSession.exportAsynchronously { () -> Void in
            handler(exportSession)
        }
    }
    
    
    
    
    

}
