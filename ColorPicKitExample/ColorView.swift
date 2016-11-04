//
//  ColorView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 11/4/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class ColorView: UIView, NibDefinable {

    // MARK: Begin NibDefinable
    
    @IBOutlet weak var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromXib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = UIColor.clear
        addSubview(contentView)
    }
    
    func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    
    
    // MARK: Public variables
    @IBOutlet weak var hexLabel: UILabel!
    var color: UIColor! {
        didSet {
            contentView.backgroundColor = color
        }
    }
    
    // MARK: Private variables
    
    // MARK: Publilc methods
    
    // MARK: Private methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

}
