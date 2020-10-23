//
//  ContentView.swift
//  Shared
//
//  Created by Erik Leon on 10/20/20.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @ObservedObject
        var motion: MotionManager
    
        var body: some View {
            VStack{
                /*
                VStack{
                    Text("Accelerometer Data")
                    Text("X: \(motion.accelx)")
                    Text("Y: \(motion.accely)")
                    Text("Z: \(motion.accelz)")
                }
                .padding()
                VStack{
                    Text("Gyro Data")
                    Text("X: \(motion.gyrox)")
                    Text("y: \(motion.gyroy)")
                    Text("z: \(motion.gyroz)")
                }
                .padding()
                */
                VStack{
                    Text("Device Motion Data")
                    Text("Roll: \(motion.deviceMotionRoll)")
                    Text("Pitch: \(motion.deviceMotionPitch)")
                    Text("Yaw: \(motion.deviceMotionYaw)")
                }
                .padding()
                VStack {
                    Text("Active Sensors")
                    Text("Accelerometer: \(String(motion.checkAccel))")
                    Text("Gyro: \(String(motion.checkGyro))")
                    Text("Device Motion: \(String(motion.checkDeviceMotion))")
                    Button(action: motion.startDeviceMotion, label: {
                        Text("Start Sensor Data")
                    })
                    Button(action: motion.stopSensors, label: {
                        Text("Stop Sensor Data")
                    })
                }
                .padding()
                VStack{
                    Text("Sample Time: \(motion.choosenTimeInterval)")
                }
            }
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(motion: MotionManager())
    }
}
