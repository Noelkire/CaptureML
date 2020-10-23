//
//  mastermotion.swift
//  Sensor Capture
//
//  Created by Erik Leon on 10/20/20.
//

import Foundation
import Combine
import CoreMotion

class MotionManager: ObservableObject {

    private var motionManager: CMMotionManager
    
    /*
    @Published var accelx: Double = 0.0
    @Published var accely: Double = 0.0
    @Published var accelz: Double = 0.0
    @Published var gyrox: Double = 0.0
    @Published var gyroy: Double = 0.0
    @Published var gyroz: Double = 0.0
    @Published var accelSample: Double = 0.0
    @Published var gyroSample: Double = 0.0
    */
    @Published var deviceMotionPitch: Double = 0.0
    @Published var deviceMotionRoll: Double = 0.0
    @Published var deviceMotionYaw: Double = 0.0
    @Published var timer:Timer = Timer.init()
    
    private var sampleTime: Double = 1.0 //Double value in minutes
    
    var choosenTimeInterval:Double {
        return sampleTime * 60
    }
    var checkAccel: Bool {
        return motionManager.isAccelerometerActive
    }
    var checkGyro: Bool {
        return motionManager.isGyroActive
    }
    var checkDeviceMotion: Bool {
        return motionManager.isDeviceMotionActive
    }
    
    init() {
        self.motionManager = CMMotionManager()
        startDeviceMotion()
    }
    func startDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motionManager.showsDeviceMovementDisplay = true
            self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            // Configure a timer to fetch the motion data.
            timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                               block: { (timer) in
                                if let data = self.motionManager.deviceMotion {
                                    // Get the attitude relative to the magnetic north reference frame.
                                    self.deviceMotionRoll = data.attitude.pitch
                                    self.deviceMotionPitch = data.attitude.roll
                                    self.deviceMotionYaw = data.attitude.yaw
                                    
                                    // Use the motion data in your app.
                                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        }
    }
    /*
    func startSensors() {
        self.motionManager.startAccelerometerUpdates(to: .main) { (CMAccelerometerData, error) in
            guard error == nil else {
                print(error!)
                return
        }
            if let accelData = CMAccelerometerData {
                self.accelx = accelData.acceleration.x
                self.accely = accelData.acceleration.y
                self.accelz = accelData.acceleration.z
            }
        }
        self.motionManager.startGyroUpdates(to: .main) { (CMGyroData, error) in
            guard error == nil else {
                print(error!)
                return
        }
            if let gyroData = CMGyroData {
                self.gyrox = gyroData.rotationRate.x
                self.gyroy = gyroData.rotationRate.y
                self.gyroz = gyroData.rotationRate.z
            }
        }
    }
    */
    func stopSensors() {
        /*
        self.motionManager.stopGyroUpdates()
        self.motionManager.stopAccelerometerUpdates()
        */
        self.motionManager.stopDeviceMotionUpdates()
    }
    func startSampleData() {
        if CMSensorRecorder.isAccelerometerRecordingAvailable() {
            let recorder = CMSensorRecorder()
            recorder.recordAccelerometer(forDuration: choosenTimeInterval)  // Record for choosen minutes
        }
        
    }
}
