//
//  SliderGroupsViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 11/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class SliderGroupsViewController: UIViewController {

    
    @IBOutlet weak var rgbaSliderGroup: RGBASliderGroup!
    @IBOutlet weak var hsbaSliderGroup: HSBASliderGroup!
    @IBOutlet weak var hslaSliderGroup: HSLASliderGroup!
    @IBOutlet weak var cmykaSliderGroup: CMYKASliderGroup!
    @IBOutlet weak var yuvaSliderGroup: HSLASliderGroup!
    
    @IBOutlet var sliderGroups: [SliderGroup]!
    @IBOutlet weak var colorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
        
        for sliderGroup in sliderGroups {
            sliderGroup.color = UIColor.red
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func sliderGroupValueChanged(_ sender: SliderGroup) {
        let color = sender.color
        
        colorLabel.text = color.rgba().stringFor(type: .baseSixteen)
        
        for sliderGroup in sliderGroups {
            if sender == sliderGroup {
                
            } else {
                sliderGroup.color = color
            }
        }
    }
}

