//
//  AccessCameraViewController.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit
import AVFoundation

class AccessCameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var router: (NSObjectProtocol & OnboardingRoutingLogic & OnboardingDataPassing)?
    
    var captureSession: AVCaptureSession!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.clearBackground()
    }
    
    // MARK: - Methods
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {

            return
        }
        
        captureSession.startRunning()
        router?.routeToEnablePushNotifications()
    }
    
    func cameraSelected() {
        // First we check if the device has a camera (otherwise will crash in Simulator - also, some iPod touch models do not have a camera).
        if let _ = AVCaptureDevice.default(for: .video) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
                case .authorized:
                    setupCamera()
                case .denied:
                    alertPromptToAllowCameraAccessViaSettings()
                case .notDetermined:
                    permissionPrimeCameraAccess()
                default:
                    permissionPrimeCameraAccess()
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "Device has no camera", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            })
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }


    func alertPromptToAllowCameraAccessViaSettings() {
        let alert = UIAlertController(title: "Ionix App needs to access to your camera", message: "Allow to access your camera", preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Open Settings", style: .cancel) { alert in
            if let appSettingsURL = NSURL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(appSettingsURL as URL)
            }
        })
        present(alert, animated: true, completion: nil)
    }


    func permissionPrimeCameraAccess() {
        let alert = UIAlertController( title: "Ionix App needs to access to your camera", message: "Allow to access your camera", preferredStyle: .alert )
        let allowAction = UIAlertAction(title: "Allow", style: .default, handler: { (alert) -> Void in
            if (AVCaptureDevice.default(for: AVMediaType.video) != nil) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [weak self] granted in
                    DispatchQueue.main.async {
                        self?.cameraSelected() // try again
                    }
                })
            }
        })
        alert.addAction(allowAction)
        let declineAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
        }
        alert.addAction(declineAction)
        present(alert, animated: true, completion: nil)
    }
    
    func presentPermissions() {
        let vc = EnablePushNotificationsViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }


    // MARK: - Actions
    
    @IBAction func onClickAllow(_ sender: Any) {
        cameraSelected()
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        router?.routeToEnablePushNotifications()
    }
    
}
