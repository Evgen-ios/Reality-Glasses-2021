//
//  ContentView.swift
//  Reality Glasses 2020
//
//  Created by Evgeniy Goncharov on 06.07.2021.
//

import ARKit
import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        // Create AR view
        let arView = ARView(frame: .zero)
        
        // Check that face tracking configuration is supported
        guard ARFaceTrackingConfiguration.isSupported else {
            print(#line, #function, "Sorry, face tracking is not supported by your device")
            return arView
        }
        
        // Create face traking configuration
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        // Run face traking session
        arView.session.run(configuration, options: [])
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
