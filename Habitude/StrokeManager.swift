//
//  StrokeManager.swift
//  Habitude
//
//  Created by Atacan Sevim on 18.02.2024.
//

import Foundation
import UIKit

import MLKit

enum PredictResult {
    case tick
    case crossMark
    case undefined(errorMessage: String)
}

/// Protocol used by the `StrokeManager` to send requests back to the `ViewController` to update the
/// display.
protocol StrokeManagerDelegate: AnyObject {
    /** Clears any temporary ink managed by the caller. */
    func clearInk()
    /** Redraws the ink and recognition results. */
    func redraw()
    /** Display the given message to the user. */
    func displayMessage(message: String)
    
    func getResult(result: PredictResult)
}

/// The `StrokeManager` object is responsible for storing the ink and recognition results, and
/// managing the interaction with the recognizer. It receives the touch points as the user is drawing
/// from the `ViewController` (which takes care of rendering the ink), and stores them into an array
/// of `Stroke`s. When the user taps "recognize", the strokes are collected together into an `Ink`
/// object, and passed to the recognizer. The `StrokeManagerDelegate` protocol is used to inform the
/// `ViewController` when the display needs to be updated.
///
/// The `StrokeManager` provides additional methods to handle other buttons in the UI, including
/// selecting a recognition language, downloading or deleting the recognition model, or clearing the
/// ink.
class StrokeManager {
    
    /**
     * Array of `RecognizedInk`s that have been sent to the recognizer along with any recognition
     * results.
     */
    var recognizedInks: [RecognizedInk]
    
    /**
     * Conversion factor between `TimeInterval` and milliseconds, which is the unit used by the
     * recognizer.
     */
    private var kMillisecondsPerTimeInterval = 1000.0
    
    /** Arrays used to keep the piece of ink that is currently being drawn. */
    private var strokes: [Stroke] = []
    private var points: [StrokePoint] = []
    
    /** The recognizer that will translate the ink into text. */
    private var recognizer: DigitalInkRecognizer! = nil
    
    /** The view that handles UI stuff. */
    weak var delegate: StrokeManagerDelegate?
    
    /** Properties to track and manage the selected language and recognition model. */
    private var model: DigitalInkRecognitionModel?
    private var modelManager: ModelManager
    
    /**
     * Initialization of internal variables as well as creating the model manager and setting up
     * observers of the recognition model downloading status.
     */
    init() {
        modelManager = ModelManager.modelManager()
        recognizedInks = []
    }
    /**
     * Actually downloads the model. This happens asynchronously with the user being shown status messages
     * when the download completes or fails.
     */
    func downloadModel() {
        let identifier = DigitalInkRecognitionModelIdentifier(forLanguageTag: "zxx-Zsye-x-emoji")
        model = DigitalInkRecognitionModel.init(modelIdentifier: identifier!)
        if modelManager.isModelDownloaded(model!) {
            self.delegate?.displayMessage(message: "Model is already downloaded")
            return
        }
        self.delegate?.displayMessage(message: "Starting download")
        // The Progress object returned by `downloadModel` currently only takes on the values 0% or 100%
        // so is not very useful. Instead we'll rely on the outcome listeners in the initializer to
        // inform the user if a download succeeds or fails.
        modelManager.download(
            model!,
            conditions: ModelDownloadConditions.init(
                allowsCellularAccess: true, allowsBackgroundDownloading: true)
        )
    }
    
    /**
     * Actually carries out the recognition. The recognition may happen asynchronously so there's a
     * callback that handles the results when they are ready.
     */
    func recognizeInk() {
        if strokes.isEmpty {
            delegate?.displayMessage(message: "No ink to recognize")
            return
        }
        if !modelManager.isModelDownloaded(model!) {
            delegate?.displayMessage(message: "Recognizer model not downloaded")
            return
        }
        if recognizer == nil {
            self.delegate?.displayMessage(message: "Initializing recognizer")
            let options: DigitalInkRecognizerOptions = DigitalInkRecognizerOptions.init(model: model!)
            recognizer = DigitalInkRecognizer.digitalInkRecognizer(options: options)
            delegate?.displayMessage(message: "Initialized recognizer")
        }
        
        // Turn the list of strokes into an `Ink`, and add this ink to the `recognizedInks` array.
        let ink = Ink.init(strokes: strokes)
        let recognizedInk = RecognizedInk.init(ink: ink)
        recognizedInks.append(recognizedInk)
        // Clear the currently being drawn ink, and display the ink from `recognizedInks` (which results
        // in it changing color).
        delegate?.redraw()
        delegate?.clearInk()
        strokes = []
        // Start the recognizer. Callback function will store the recognized text and tell the
        // `ViewController` to redraw the screen to show it.
        recognizer.recognize(
            ink: ink,
            completion: {
                [unowned self, recognizedInk]
                (result: DigitalInkRecognitionResult?, error: Error?) in
                if let result = result, let candidate = result.candidates.first {
                    switch candidate.text {
                    case "✓" :
                        self.delegate?.getResult(result: .tick)
                    case "❌":
                        self.delegate?.getResult(result: .crossMark)
                    default:
                        self.delegate?.getResult(result: .undefined(errorMessage: "Please check your shape! must be a tick or a cross"))
                    }
                } else {
                    recognizedInk.text = "error"
                    self.delegate?.getResult(result: .undefined(errorMessage: "Recognition error " + String(describing: error)))
                }
            })
    }
    
    func clear() {
        recognizedInks = []
        strokes = []
        points = []
    }
    
    func startStrokeAtPoint(point: CGPoint, t: TimeInterval) {
        points = [
            StrokePoint.init(
                x: Float(point.x), y: Float(point.y), t: Int(t * kMillisecondsPerTimeInterval))
        ]
    }
    
    func continueStrokeAtPoint(point: CGPoint, t: TimeInterval) {
        points.append(
            StrokePoint.init(
                x: Float(point.x), y: Float(point.y),
                t: Int(t * kMillisecondsPerTimeInterval)))
    }
    
    func endStrokeAtPoint(point: CGPoint, t: TimeInterval) {
        points.append(
            StrokePoint.init(
                x: Float(point.x), y: Float(point.y),
                t: Int(t * kMillisecondsPerTimeInterval)))
        strokes.append(Stroke.init(points: points))
        points = []
    }
}
