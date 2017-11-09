//
//  SegmentControl.swift
//  DiscountApp
//
//  Created by andriibilan on 11/8/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
@IBDesignable class  SegmentControl : UIControl {
    private var labels = [UILabel]()
    var thumbView = UIView()
    
    var items:[String] = ["sa", "asdd","asdw", "qwe", "qwesfa"]{
        didSet {
            setupLabels()
        }
    }
    
    var selectIndex :Int = 0{
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init(coder : NSCoder) {
//        super.init(coder: NSCoder)
//    }
    
    func setupView(){
            layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.white.cgColor
            layer.borderWidth = 2
        backgroundColor = UIColor.black
        setupLabels()
        insertSubview(thumbView, at: 0)
    }
    
    func setupLabels(){
        for label in labels{
            label.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity:  true)
        for index in 1...items.count{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            label.text = items[index - 1]
            label.textAlignment = .center
            label.textColor = UIColor.white
            self.addSubview(label)
            labels.append(label)
        }
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        var selectframe = self.bounds
//        let newWeight = CGRect(x: 0, y: 0, width: selectframe, height: 0)
//
//    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        var calculateIndex: Int?
        for (item, index) in labels.enumerated(){
        if   index.frame.contains(location){
            calculateIndex = item
        }
    }
        if calculateIndex != nil {
           selectIndex = calculateIndex!
          sendActions(for: .valueChanged)
        }
        return false
    }
    func displayNewSelectedIndex(){
        
        var label = labels[selectIndex]
        self.thumbView.frame = label.frame
    }
    
}
