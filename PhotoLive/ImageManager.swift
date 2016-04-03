//
//  ImageManager.swift
//  PhotoLive
//
//  Created by Kévin Rignault on 09/03/2016.
//  Copyright © 2016 Kévin Rignault. All rights reserved.
//

import Foundation
import UIKit

class ImageManager: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //-- Crop image
    func cropToSquare(image originalImage: UIImage) -> UIImage {
        //-- Create a copy of the image without the imageOrientation property
        let contextImage: UIImage = UIImage(CGImage: originalImage.CGImage!)
        
        //-- Get the size of the contextImage
        let contextSize: CGSize = contextImage.size
        
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        // Check to see which length is the longest and create the offset based on that length
        // then set the width and height of our rect
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            width = contextSize.height
            height = contextSize.height
        }
        else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            width = contextSize.width
            height = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        
        //-- Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        
        //-- Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        return image
    }
    
}