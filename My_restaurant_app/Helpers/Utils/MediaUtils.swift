//
//  ImageUtils.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 13/12/2023.
//

import UIKit
import AVFoundation
import Photos


class MediaUtils {
    
  

    /// Lấy tên nguyên bản trên thiết bị của ảnh
    static func getAssetFullName(asset: PHAsset) -> String {
        let resources = PHAssetResource.assetResources(for: asset)
        
        if let resource = resources.first {
            let fullName = resource.originalFilename
            return fullName
        }
        return ""
    }
    
    static func getAssetSize(asset: PHAsset) -> Int {
        var fileSize = 0
        let resources = PHAssetResource.assetResources(for: asset)
        if let resource = resources.first {
            let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong
            fileSize = Int(unsignedInt64 ?? 0)
        }
        return fileSize
    }
    
    static func saveImageDataToFile(data: Data, fileExtension: String) -> URL? {
        let uniqueFilename = ProcessInfo.processInfo.globallyUniqueString
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(uniqueFilename).\(fileExtension)")
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch let error {
            dLog("Error saving image to file: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    
    static func captureViewScreenshot(viewToCapture: UIView) -> UIImage? {
 
        UIGraphicsBeginImageContextWithOptions(viewToCapture.bounds.size, true, 1)
        if let context = UIGraphicsGetCurrentContext() {
            viewToCapture.layer.render(in: context)
        }
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot
    }
    
    static func combineScreenshots(_ screenshot1: UIImage?, _ screenshot2: UIImage?) -> UIImage? {
        guard let screenshot1 = screenshot1, let screenshot2 = screenshot2 else {
            return nil
        }
        let combinedSize = CGSize(width: max(screenshot1.size.width, screenshot2.size.width),height: screenshot1.size.height + screenshot2.size.height)
        UIGraphicsBeginImageContextWithOptions(combinedSize, false, UIScreen.main.scale)
        screenshot1.draw(at: CGPoint.zero)
        screenshot2.draw(at: CGPoint(x: 0, y: screenshot1.size.height))
        let combinedScreenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return combinedScreenshot
    }
        
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        
        let size = image.size
           
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
           newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

//        if let data:Data = newImage?.pngData() {
//            return UIImage(data: data)
//        }
//
        return newImage
    }
 
    
    
    static func overlayWithGray(image: UIImage, color: UIColor = .systemGray6, alpha: CGFloat = 0.4) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let rect = CGRect(origin: .zero, size: image.size)

        image.draw(in: rect)

        color.withAlphaComponent(alpha).setFill()
        UIRectFillUsingBlendMode(rect, .multiply)

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    
    static func convertImageToBlackAndWhiteFormat(yourUIImage:UIImage) -> UIImage{
        guard let currentCGImage = yourUIImage.cgImage else { return yourUIImage}
        let currentCIImage = CIImage(cgImage: currentCGImage)

        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(currentCIImage, forKey: "inputImage")

        // set a gray value for the tint color
        filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")

        filter?.setValue(1.0, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return yourUIImage}

        let context = CIContext()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            return processedImage
        }
        return yourUIImage
    }
    
   static func invertQRCodeColors(image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }

        // Step 1: Invert the colors (black ↔︎ white)
        guard let invertFilter = CIFilter(name: "CIColorInvert") else { return nil }
        invertFilter.setValue(ciImage, forKey: kCIInputImageKey)

        // Step 2: Render the output
        guard let outputImage = invertFilter.outputImage else { return nil }
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }

        return UIImage(cgImage: cgImage)
    }
    
    
    /// Lấy Thumbnail từ URL string của Video
    static func generateThumbnailURLFromVideo(for videoURL: URL, completion: @escaping (URL?) -> Void) {
        let asset = AVAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        imageGenerator.appliesPreferredTrackTransform = true

        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 60) // You can adjust the time to get the thumbnail at a different point in the video

        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)

            // Save the image to a temporary file
            let tempDirectoryURL = FileManager.default.temporaryDirectory
            let tempFileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")

            if let data = thumbnail.pngData() {
                try data.write(to: tempFileURL)
                completion(tempFileURL)
            } else {
                completion(nil)
            }
        } catch {
            dLog("Error generating thumbnail: \(error.localizedDescription)")
            completion(nil)
        }
    }
    
    
    static func getFullMediaLink(string:String, media_type:media_type = .image) -> String {
        
        return media_type == .video
        ? (String(format: "%@%@", APIEndPoint.GATEWAY_SERVER_URL, "/s3") + string)
        : (String(format: "%@", ManageCacheObject.getConfig()?.api_upload_short ?? "") + string)
    }
    
    
    
    
    static func getSizeOfFile(url:URL) -> Int {
        do {
            let resources = try url.resourceValues(forKeys:[.fileSizeKey])
            let fileSize = resources.fileSize!
            return Int(fileSize)
        } catch {
            return 0
        }
    }
    
    
    

    static func getTappedLink(at point: CGPoint, fullText: String, linkTexts: [String], label: UILabel) -> String? {
        guard let attributedText = label.attributedText else {
               return nil
           }

           // Create a text container with the label's text and size
           let textContainer = NSTextContainer(size: label.bounds.size)
           let layoutManager = NSLayoutManager()
           let textStorage = NSTextStorage(attributedString: attributedText)

           layoutManager.addTextContainer(textContainer)
           textStorage.addLayoutManager(layoutManager)

           // Create a tap location in the text container
           let tapLocation = point
           let characterIndex = layoutManager.characterIndex(for: tapLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

           // Check if the character index corresponds to a URL
           for linkText in linkTexts {
               let linkRange = (NSString(utf8String: fullText) ?? "" as NSString).range(of: linkText)
               if NSLocationInRange(characterIndex, linkRange) {
                   return linkText
               }
           }
        do {
            let urlDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let urlMatches = urlDetector.matches(in: fullText, range: NSRange(fullText.startIndex..., in: fullText))
            for match in urlMatches {
               if NSLocationInRange(characterIndex, match.range) {
                   return (fullText as NSString).substring(with: match.range)
               }
            }
        } catch let error {
            dLog("Error creating regular expression: \(error.localizedDescription)")
        }
           return nil
    }
    
    
    static func convertHEICToJPG(from imageURL: URL, completion: @escaping (URL?) -> Void) {
        // Step 1: Download HEIC image data
        guard let heicImageData = try? Data(contentsOf: imageURL) else {
            completion(nil)
            return
        }
        // Step 2: Convert HEIC data to UIImage
        guard var image = UIImage(data: heicImageData) else {
            completion(nil)
            return
        }
        // Step 3: Fix the image orientation
        guard image.imageOrientation != .up else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        image = normalizedImage ?? image
        // Extract the original file name (without extension) from the provided URL
        let originalFileName = imageURL.deletingPathExtension().lastPathComponent
        // Step 4: Convert UIImage to JPG data
        guard let jpgData = image.jpegData(compressionQuality: 0.5) else {
            completion(nil)
            return
        }
        // Step 5: Save JPG data to a file with the original file name and .jpg extension
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let jpgURL = documentsDirectory.appendingPathComponent(originalFileName).appendingPathExtension("jpg")
        do {
            try jpgData.write(to: jpgURL)
            completion(jpgURL)
        } catch {
            dLog("Error saving JPG data to file: \(error)")
            completion(nil)
        }
    }
    
    

    

}



extension MediaUtils {

  
    
    
}
