//
//  SettingsViewController.swift
//  Draw2Design
//
//  Created by Nishanth P on 1/3/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import UIKit

protocol updateSettingsDelegate:class{
    
    func updateSettings(_ settingsVC: SettingsViewController)
    
    
}

class SettingsViewController: UIViewController {
   
    @IBOutlet weak var brushImage: UIImageView!
    @IBOutlet weak var colorImage: UIImageView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var brushSlider: UISlider!
    
    var red : CGFloat?
    var green : CGFloat?
    var blue : CGFloat?
    var brush : CGFloat?
    
    var delegate : updateSettingsDelegate?
    
    @IBOutlet weak var redLabel: UILabel!
    
    @IBOutlet weak var greenLabel: UILabel!
    
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var brushLabel: UILabel!
    
    
    @IBAction func rgbValue(_ sender: UISlider) {
        
        red = CGFloat(redSlider.value)
         redLabel.text = "Red: "+String(format:"%d",Int(redSlider.value * 255.0)) as String
        
        green = CGFloat(greenSlider.value)
        greenLabel.text = "Green: "+String(format:"%d",Int(greenSlider.value * 255.0)) as String
        
        blue = CGFloat(blueSlider.value)
        blueLabel.text = "Blue: "+String(format:"%d",Int(blueSlider.value * 255.0)) as String
        preview(imageView: colorImage, brushSize: 30.0)
        
        
        
    }
    
    @IBAction func brushSliderFunc(_ sender: UISlider) {
        if sender == brushSlider
        {
            brush = CGFloat(sender.value * 50)
            brushLabel.text = "Brush: "+String(format:"%2i",Int(brush!)) as String
            
        }
        preview(imageView: brushImage, brushSize: brush!)
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
   
    @IBAction func save(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.updateSettings(self)
    }
    
    
    func preview(imageView:UIImageView,brushSize:CGFloat)
    {
        UIGraphicsBeginImageContext(CGSize(width:50.0,height:50.0))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to:CGPoint(x:25.0, y:25.0))
        context?.addLine(to: CGPoint(x:25.0, y:25.0))
    
        context?.setBlendMode(.normal)
        context?.setLineCap(.round)
        context?.setLineWidth(brushSize)
        context?.setStrokeColor(UIColor(red:red!,green:green!,blue:blue!,alpha:1.0).cgColor)
        context?.strokePath()
    
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func slider()
    {
        brushSlider.value = Float(brush!/50)
        brushLabel.text = "Brush: "+String(format:"%2i",Int(brush!)) as String
        redSlider.value = Float(red!)
        redLabel.text = "Red: "+String(format:"%d",Int(redSlider.value * 255.0)) as String
        greenSlider.value = Float(green!)
        greenLabel.text = "Green: "+String(format:"%d",Int(greenSlider.value * 255.0)) as String
        blueSlider.value = Float(green!)
        blueLabel.text = "Blue: "+String(format:"%d",Int(blueSlider.value * 255.0)) as String
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        preview(imageView:brushImage,brushSize:brush!)
        preview(imageView:colorImage,brushSize:10.0)
        slider()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
