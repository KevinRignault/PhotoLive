//
//  ViewController.swift
//  PhotoLive
//
//  Created by Kévin Rignault on 08/11/2015.
//  Copyright © 2015 Kévin Rignault. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Variables
    let picker = UIImagePickerController()
    let socket = SocketIOClient(socketURL: "localhost:3001")
    @IBOutlet weak var mainImage: UIImageView!
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //-- Picker
        picker.delegate = self
        
        //-- Connect socket
        self.socket.connect()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Picker
    
    //-- Take photo
    @IBAction func takePhoto(sender: AnyObject) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        picker.modalPresentationStyle = .FullScreen
        presentViewController(picker, animated: true, completion: nil)
    }
    
    //-- Pick photo from library
    @IBAction func pickPhoto(sender: AnyObject) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)

    }
    
    //-- End taking/picking photo
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //-- Chosen image
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //-- Get image data
        let imageData = UIImageJPEGRepresentation(chosenImage, 0)
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        //-- Send image to server
        self.socket.emit("image_to_server", base64String)
        
        //-- Set image view
        self.mainImage.contentMode = .ScaleAspectFit
        self.mainImage.image = ImageManager().cropToSquare(image: chosenImage)
        
        //-- Hide library
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //-- Cancel taking/picking photo
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

