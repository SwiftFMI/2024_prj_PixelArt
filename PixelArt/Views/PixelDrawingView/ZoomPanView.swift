//
//  ZoomPanView.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 8.01.25.
//


import SwiftUI
import UIKit

struct ZoomPanView<Content: View>: View {
    @ViewBuilder let content: () -> Content
    let expectedWidth: CGFloat
    let expectedHeight: CGFloat
    @Binding var shouldBePanning: Bool
    
    init(expectedWidth: CGFloat, expectedHeight: CGFloat, shouldBePanning: Binding<Bool>,  content: @escaping () -> Content) {
        self.expectedWidth = expectedWidth
        self.expectedHeight = expectedHeight
        self._shouldBePanning = shouldBePanning
        self.content = content
    }
    
    var body: some View {
        PinchZoomContext(expectedWidth: expectedWidth, expectedHeight: expectedHeight, shouldBePanning: $shouldBePanning) {
            content()
        }
        .clipped()
    }
}

// helper struct
struct PinchZoomContext<Content: View>: View {
    var content: Content
    
    @State var scale: CGFloat = 2
    @State var lastAvailableScale: CGFloat = 1
    @State var offset: CGPoint = .zero
    @State var lastAvailableOffset: CGPoint = .zero
    
    let expectedWidth: CGFloat
    let expectedHeight: CGFloat
    @Binding var shouldBePanning: Bool
    
    init(expectedWidth: CGFloat, expectedHeight: CGFloat, shouldBePanning: Binding<Bool>,  content: @escaping () -> Content) {
        self.expectedWidth = expectedWidth
        self.expectedHeight = expectedHeight
        self._shouldBePanning = shouldBePanning
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { proxy in
            let biggerSideSize = expectedWidth >= expectedHeight ? expectedWidth : expectedHeight
            let biggerProxySideSize = expectedWidth >= expectedHeight ? proxy.size.width : proxy.size.height
            let secondaryScale = biggerProxySideSize / (biggerSideSize * 2)
            ZoomGesture(content: content.scaleEffect(secondaryScale), size: proxy.size, scale: $scale, lastAvailableScale: $lastAvailableScale, offset: $offset, lastAvailableOffset: $lastAvailableOffset, shouldBePanning: $shouldBePanning)
                .offset(x: offset.x, y: offset.y)
                .scaleEffect(scale)
        }
        
    }
}

struct ZoomGesture<Content: View>: UIViewRepresentable {
    var content: Content
    
    var size: CGSize
    @Binding var scale: CGFloat
    @Binding var lastAvailableScale: CGFloat
    @Binding var offset: CGPoint
    @Binding var lastAvailableOffset: CGPoint
    @Binding var shouldBePanning: Bool
    
    func makeUIView(context: Context) -> UIView {
        let mview = UIView()

        // creating gestures
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(sender:)))
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(sender:)))

        // setting delegates
        pinchGesture.delegate = context.coordinator
        panGesture.delegate = context.coordinator

        // adding gestures
        mview.addGestureRecognizer(pinchGesture)
        mview.addGestureRecognizer(panGesture)

        // create a UIHostingController to hold our SwiftUI content
            let hostedView = context.coordinator.hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = true
            hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostedView.frame = mview.bounds
            mview.addSubview(hostedView)
        
        return mview
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // update uiView
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        var parent: ZoomGesture
        var hostingController: UIHostingController<Content>
        
        init(parent: ZoomGesture, hostingController: UIHostingController<Content>) {
            self.parent = parent
            self.hostingController = hostingController
        }
        
        @objc
        func handlePinch(sender: UIPinchGestureRecognizer) {
            if(!parent.shouldBePanning) {
                return
            }
            // calculating scale
            if (sender.state == .began || sender.state == .changed) {
                // calculate scale data
                let delta = sender.scale / parent.lastAvailableScale
                parent.scale *= delta
                parent.lastAvailableScale = sender.scale
            }
            else {
                if (parent.scale > 10) {
                    withAnimation(.easeOut(duration: 0.35), {
                        parent.scale = 10
                    })
                }
                if (parent.scale < 2) {
                    withAnimation(.easeOut(duration: 0.35), {
                        parent.scale = 2
                    })
                }
                parent.lastAvailableScale = 1
            }
        }
        
        @objc
        func handlePan(sender: UIPanGestureRecognizer) {
            if(!parent.shouldBePanning) {
                return
            }
            sender.maximumNumberOfTouches = 2
            if (sender.state == .began || sender.state == .changed) {
                if let view = sender.view {
                    let translation = sender.translation(in: view)
                    parent.offset = CGPoint(x: parent.lastAvailableOffset.x + translation.x, y: parent.lastAvailableOffset.y + translation.y)
                }
            } else {
                if (parent.offset.x > (sender.view?.frame.width)!/4) {
                    withAnimation(.easeOut(duration: 0.35), {
                        parent.offset.x = (sender.view?.frame.width)!/4
                    })
                }
                if (parent.offset.x < -(sender.view?.frame.width)!/4) {
                    withAnimation(.easeOut(duration: 0.35), {
                        parent.offset.x = -(sender.view?.frame.width)!/4
                    })
                }
                if (parent.offset.y > (sender.view?.frame.height)!/4) {
                    withAnimation(.easeOut(duration: 0.35), {
                        parent.offset.y = (sender.view?.frame.height)!/4
                    })
                }
                if (parent.offset.y < -(sender.view?.frame.height)!/4) {
                    withAnimation(.easeOut(duration: 0.35), {
                        parent.offset.y = -(sender.view?.frame.height)!/4
                    })
                }
                parent.lastAvailableOffset = parent.offset
            }
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, hostingController: UIHostingController(rootView: self.content))
    }
}


class SwiftUIWrapViewController<Content: View>: UIViewController {
    
    let childView: Content
    let childSize: CGSize
    init(childView: Content, childSize: CGSize) {
        self.childView = childView
        self.childSize = childSize
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // this initializer should not be called
        fatalError("big error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let childView = UIHostingController(rootView: childView)
        childView.view.frame = CGRect(origin: .zero, size: childSize)
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
    
}
