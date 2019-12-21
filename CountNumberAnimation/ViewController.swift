//
//  ViewController.swift
//  CountNumberAnimation
//
//  Created by apple on 2019/12/21.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var displayLink: CADisplayLink?
    var startValue: Double = 1
    let endValue: Double = 1000
    let animationDuration: Double = 3
    
    let animationStartDate = Date()
    
    let countingLabel1: UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let countingLabel2: UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(countingLabel1)
        countingLabel1.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)

        
        view.addSubview(countingLabel2)
        countingLabel2.frame = view.frame
        
        displayLink = CADisplayLink.init(target: self, selector: #selector(handleUpdate))
        displayLink?.add(to: .main, forMode: .default)
        
        incrementLabel(to: 1000)
    
    }

    @objc func handleUpdate() {
        // So tu dong tang dan
//        self.countingLabel.text = "\(startValue)"
//        startValue += 1
//        if startValue > endValue {
//            startValue = endValue
//        }
//        self.countingLabel.text = "\(startValue)"
        
        
        // Dung Animation: dat thoi gian hoan thanh
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.countingLabel1.text = "\(endValue)"
            displayLink?.invalidate()
            displayLink = nil
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.countingLabel1.text = "\(value)"
        }
    }

    // Func count
    func incrementLabel(to endValue: Int) {
        let duration: Double = 2.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.countingLabel2.text = "\(i)"
                }
            }
        }
    }
}

