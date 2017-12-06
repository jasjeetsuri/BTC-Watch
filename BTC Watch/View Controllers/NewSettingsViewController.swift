//
//  NewSettingsViewController.swift
//  BTC Watch
//
//  Created by Jas on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit
import AVFoundation

var captureSession:AVCaptureSession?
var videoPreviewLayer:AVCaptureVideoPreviewLayer?
var qrCodeFrameView:UIView?
var gradientLayer = CALayer()

class NewSettingsViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
  
  //MARK: Properties
  
  var xpubSetting: String?
  @IBOutlet weak var tableView: UITableView!
  @IBAction func scanAddrBtn(_ sender: UIButton) {
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
    let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    do {
      // Get an instance of the AVCaptureDeviceInput class using the previous device object.
      let input = try AVCaptureDeviceInput(device: captureDevice)
      
      // Initialize the captureSession object.
      captureSession = AVCaptureSession()
      
      // Set the input device on the capture session.
      captureSession?.addInput(input)
      
      // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
      let captureMetadataOutput = AVCaptureMetadataOutput()
      captureSession?.addOutput(captureMetadataOutput)
      
      // Set delegate and use the default dispatch queue to execute the call back
      captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
      
    } catch {
      // If any error occurs, simply print it out and don't continue any more.
      print(error)
      return
    }
    gradientLayer.frame = tableView.bounds
    gradientLayer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    gradientLayer.isHidden = false
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
    
    //let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    let frameSize: CGPoint = CGPoint(x: ((tableView.bounds.size.width*0.5)-((tableView.bounds.size.width-80)/2)),y: ((tableView.bounds.size.height*0.5)-((tableView.bounds.size.width-80)/2)))
    
    let rect = CGRect(origin: frameSize, size: CGSize(width: (tableView.bounds.size.width-80), height: (tableView.bounds.size.width-80)))
    videoPreviewLayer?.frame = rect
    view.layer.addSublayer(videoPreviewLayer!)
    view.layer.insertSublayer(gradientLayer, at:1)
    //fade background
    gradientLayer.frame = tableView.bounds
    gradientLayer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    gradientLayer.isHidden = false
    
    
    // Start video capture.
    captureSession?.startRunning()
    
    //Initialize QR Code Frame to highlight the QR code
    qrCodeFrameView = UIView()
    
    if let qrCodeFrameView = qrCodeFrameView {
      qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
      qrCodeFrameView.layer.borderWidth = 2
      view.addSubview(qrCodeFrameView)
      view.bringSubview(toFront: qrCodeFrameView)
    }
  }
  
  //MARK: Outlets
  
 // @IBOutlet weak var xpubSetting: UITextField!
  @IBOutlet weak var myTable: UITableView!
  
  //MARK: Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UINavigationBar.appearance().barStyle = .black
    self.xpubSetting = UserDefaults.standard.string(forKey: "xpub")
    tableView.backgroundColor =  UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
    tableView.separatorColor = UIColor.darkGray
    self.hideKeyboardWhenTappedAround()
  }

  override func viewDidAppear(_ animated: Bool) {
    videoPreviewLayer?.isHidden = true
    qrCodeFrameView?.isHidden = true
    captureSession?.stopRunning()
    myTable.reloadData()
    gradientLayer.isHidden = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}

func handleSingleTap(recognizer: UITapGestureRecognizer) {
  videoPreviewLayer?.isHidden = true
  qrCodeFrameView?.isHidden = true
  captureSession?.stopRunning()
}

extension NewSettingsViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if(textField.tag == 0){
      let defaults = UserDefaults.standard
      if let text = textField.text {
        defaults.set(text, forKey: "xpub")
      }
      xpubSetting = textField.text
    }
  }
  //delegate method
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    //self.xpubSetting.resignFirstResponder()
    return true
  }
  
  
  func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if metadataObjects == nil || metadataObjects.count == 0 {
      qrCodeFrameView?.frame = CGRect.zero
      //messageLabel.text = "No QR code is detected"
      return
    }
    
    // Get the metadata object.
    let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
    
    if metadataObj.type == AVMetadataObjectTypeQRCode {
      // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
      let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
      qrCodeFrameView?.frame = barCodeObject!.bounds
      
      if metadataObj.stringValue != nil {
        //xpubt = metadataObj.stringValue
        let defaults = UserDefaults.standard
          defaults.set(metadataObj.stringValue, forKey: "xpub")
        tableView.reloadData()
        videoPreviewLayer?.isHidden = true
        qrCodeFrameView?.isHidden = true
        captureSession?.stopRunning()
        gradientLayer.isHidden = true
      }
    }
  }
  
}

extension NewSettingsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: XPubSettingTableViewCell.self), for: indexPath as IndexPath) as! XPubSettingTableViewCell
      cell.xpubTextField.delegate = self
      if (UserDefaults.standard.string(forKey: "xpub") == "" ){
        
      } else
      {
        cell.xpubTextField.text = UserDefaults.standard.string(forKey: "xpub")!
      }
      cell.xpubTextField.placeholder = "Enter your xpub"
      //cell.xpubSettingLabel.text = "Enter xpub"
      cell.xpubTextField.tag = 0
      cell.xpubTextField.autocorrectionType = UITextAutocorrectionType.no
      cell.xpubTextField.clearButtonMode = UITextFieldViewMode.whileEditing
      cell.xpubTextField.returnKeyType = UIReturnKeyType.done
      cell.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
      return(cell)
    }
    
    if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencySettingTableViewCell.self)) as! CurrencySettingTableViewCell
      cell.currencySettingLabel.text = "Currency"
      if (UserDefaults.standard.string(forKey: "currency") == nil ) {
        cell.currencySettingCodeDisplayLabel.text = "GBP"
      } else {
        cell.currencySettingCodeDisplayLabel.text = UserDefaults.standard.string(forKey: "currency")!
      }
      cell.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
      return(cell)
    }
    if indexPath.row == 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TouchIdTableViewCell.self)) as! TouchIdTableViewCell
      cell.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
      cell.touchIdLbl.text = "Touch Id"
      return(cell)
    }
    return UITableViewCell()
  }
  
  // method to run when table view cell is tapped
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // Segue to the second view controller
    if indexPath.row == 1 {
      self.performSegue(.showCurrencySelection, sender: self)
    }
  }
}
extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  func dismissKeyboard() {
    gradientLayer.isHidden = true
    videoPreviewLayer?.isHidden = true
    qrCodeFrameView?.isHidden = true
    captureSession?.stopRunning()
    view.endEditing(true)
  }
}

