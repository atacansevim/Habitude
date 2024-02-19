//
//  DrawingView.swift
//  Habitude
//
//  Created by Atacan Sevim on 18.02.2024.
//

import UIKit

protocol DrawingViewDelegate: AnyObject {
    func getResult(result: PredictResult)
}

class DrawingView: UIView {
    
    // MARK: -Constants
    
    private enum Constants {
        static let title = "Add your first habit"
        static let description = "Click on create habit button!"
        static let height: CGFloat = 120
        static let width: CGFloat = 300
        static let stackSpacing: CGFloat = 16
        static let iconStackViewSpacing: CGFloat = 10
        static let bottomStackViewSpacing: CGFloat = 5
    }
    
    // MARK: -Properties
    
    private var path = UIBezierPath()
    private var previousPoint: CGPoint = .zero
    private var lineWidth: CGFloat = 10
    private var lineColor: UIColor = .black
    
    private var lastPoint: CGPoint!
    private var strokeManager: StrokeManager = StrokeManager()
    weak var delegate: DrawingViewDelegate?
    
    private var drawnImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: -init
    
    init() {
        super.init(frame: .zero)
        strokeManager.downloadModel()
        strokeManager.delegate = self
        layout()
        style()
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
}

// MARK: -Setup Functions

extension DrawingView {
    
    private func style() {
        backgroundColor = UIColor.white
        clipsToBounds = true
        layer.cornerRadius = 20
    }
    
    private func layout() {
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        widthAnchor.constraint(equalToConstant: Constants.width).isActive = true

        addSubview(drawnImage)
        NSLayoutConstraint.activate([
            drawnImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            drawnImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            drawnImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            drawnImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
        ])
    }
}

// MARK: -TouchDelegates

extension DrawingView {
    
    /** Handle start of stroke: Draw the point, and pass it along to the `StrokeManager`. */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touch = touches.first
      // Since this is a new stroke, make last point the same as the current point.
      lastPoint = touch!.location(in: drawnImage)
      let time = touch!.timestamp
      drawLineSegment(touch: touch)
      strokeManager.startStrokeAtPoint(point: lastPoint!, t: time)
    }

    /** Handle continuing a stroke: Draw the line segment, and pass along to the `StrokeManager`. */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touch = touches.first
      drawLineSegment(touch: touch)
      strokeManager.continueStrokeAtPoint(point: lastPoint!, t: touch!.timestamp)
    }

    /** Handle end of stroke: Draw the line segment, and pass along to the `StrokeManager`. */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touch = touches.first
      drawLineSegment(touch: touch)
      strokeManager.endStrokeAtPoint(point: lastPoint!, t: touch!.timestamp)
    }

}

extension DrawingView {
    
    func drawLineSegment(touch: UITouch!) {
      let currentPoint = touch.location(in: drawnImage)

      UIGraphicsBeginImageContext(drawnImage.frame.size)
      drawnImage.image?.draw(
        in: CGRect(
          x: 0, y: 0, width: drawnImage.frame.size.width, height: drawnImage.frame.size.height))
      let ctx: CGContext! = UIGraphicsGetCurrentContext()
      ctx.move(to: lastPoint!)
      ctx.addLine(to: currentPoint)
      ctx.setLineCap(CGLineCap.round)
      ctx.setLineWidth(5)
      ctx.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
      ctx.setBlendMode(CGBlendMode.normal)
      ctx.strokePath()
      ctx.flush()
      drawnImage.image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      lastPoint = currentPoint
    }
    
    func recognize() {
        strokeManager.recognizeInk()
    }
}

// MARK: -StrokeManagerDelegate

extension DrawingView: StrokeManagerDelegate{
    func getResult(result: PredictResult) {
        delegate?.getResult(result: result)
    }
    
    func clearInk() {
        drawnImage.image = nil
    }
    
    func redraw() {
        
    }
    
    func displayMessage(message: String) {
        print(message)
    }
}
