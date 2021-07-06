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
    
    func createBox() -> Entity {
        // Create mesh (geometry
        let mesh = MeshResource.generateBox(size: 0.2)
        
        // Create entity based on mesh
        let entity = ModelEntity(mesh: mesh)
        
        return entity
    }
    
    func createShpere(x: Float = 0, y: Float = 0, z: Float = 0, color: UIColor = .red, radius: Float = 0.05) -> Entity {
        // Create sphere mesh
        let sphere = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial(color: color, isMetallic: true)
        
        // Create sphere entity
        let sphereEntity = ModelEntity(mesh: sphere, materials: [material])
        
        sphereEntity.position = SIMD3(x, y, z)
        
        return sphereEntity
    }
    
    func createCircle(x: Float = 0, y: Float = 0, z: Float = 0) -> Entity {
        // Create circke mesh
        let circle = MeshResource.generateBox(size: 0.05, cornerRadius: 0.025)
        
        // Create material
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        
        // Create entity
        let circleEntity = ModelEntity(mesh: circle, materials: [material])
        circleEntity.position = SIMD3(x, y, z)
        circleEntity.scale.z = 0.2
        circleEntity.scale.x = 1.1
        
        return circleEntity
    }
    
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
                
        // Create face anchor
        let faceAnchor = AnchorEntity(.face)
        
        // Add box to the face anchor
        faceAnchor.addChild(createCircle(x: 0.035, y: 0.025, z: 0.06))
        faceAnchor.addChild(createCircle(x: -0.035, y: 0.025, z: 0.06))
        faceAnchor.addChild(createShpere(z: 0.06, radius: 0.025))
        
        // Add face anchor to the sceen
        arView.scene.anchors.append(faceAnchor)
        
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
