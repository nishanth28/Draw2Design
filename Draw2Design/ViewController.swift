//
//  ViewController.swift
//  Draw2Design
//
//  Created by Nishanth P on 1/3/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,updateSettingsDelegate {

    @IBOutlet weak var drawArea: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var lastPoint = CGPoint.zero
    var swiped:Bool = false
    
    var red : CGFloat = 0.0
    var green : CGFloat = 0.0
    var blue : CGFloat = 0.0
    var brush : CGFloat = 5.0
    var colors : [(CGFloat,CGFloat,CGFloat)] = [(CGFloat,CGFloat,CGFloat)]()
    
    @IBAction func chooseColor(_ sender: UIButton) {
        (red,green,blue) = colors[sender.tag]
        (red,green,blue) = (red/255.0,green/255.0,blue/255.0)
    
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        drawArea.image = nil
    }
    
    @IBAction func eraser(_ sender: UIBarButtonItem) {
        (red,green,blue) = (1,1,1)
    }
    
    func customiseBar(){
        let button : UIButton = UIButton.init(type:.custom)
        button.setImage(UIImage(named:"eraser"), for: .normal)
        button.frame = CGRect(x:0,y:0,width:30,height:30)
        button.addTarget(self, action:#selector(ViewController.eraserFunc), for:.touchUpInside)
        let bbtn = UIBarButtonItem(customView: button)
        toolBar.items?[2] = bbtn
        
        let settingsButton : UIButton = UIButton.init(type:.custom)
        settingsButton.setImage(UIImage(named:"Settings"), for: .normal)
        settingsButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        settingsButton.addTarget(self, action:#selector(ViewController.settingFunc), for:.touchUpInside)
        let sbbtn = UIBarButtonItem(customView: settingsButton)
        toolBar.items?[8] = sbbtn
        
        let saveButton : UIButton = UIButton.init(type:.custom)
        saveButton.setImage(UIImage(named:"Save"), for: .normal)
        saveButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        saveButton.addTarget(self, action:#selector(ViewController.saveFunc), for:.touchUpInside)
        let savebbtn = UIBarButtonItem(customView: saveButton)
        toolBar.items?[6] = savebbtn
        
    }
    
    func eraserFunc(){
        (red,green,blue) = (1,1,1)
    }
    
    func settingFunc(){
        self.performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    func saveFunc(){
        if let image  = drawArea.image{
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        let alert = UIAlertController(title: "Success!",message: "Design saved", preferredStyle:UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title:"Dismiss",style:.default, handler:{(action) -> Void in
            
            self.dismiss(animated: true, completion:nil)
        }))
        
            self.present(alert, animated: true, completion:nil)
        }
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colors = [(0,0,0),
                  (1,159,0),
                  (0,40,208),
                  (244,0,0),
                  (247,247,2),
                  (252,143,0),
                  (2,235,243),
                  (92,17,127),
                  (251,0,236),
                  (78,76,53),
                  (106,209,246),
                  (252,125,255),
                  (148,247,110),
                  (145,60,56),
                  (104,104,104),
                  (153,166,1),
                  (19,128,254),
                  (184,184,184)]
                  customiseBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first{
            lastPoint = touch.location(in:self.drawArea)
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first{
            let currentPoint = touch.location(in:self.drawArea)
            drawLines(from: lastPoint, to: currentPoint)
            lastPoint = currentPoint
            //print(lastPoint)
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped{
            
            drawLines(from: lastPoint, to: lastPoint)
            
        }
        
    }
    
    func drawLines(from:CGPoint,to:CGPoint){
        
        UIGraphicsBeginImageContext(self.drawArea.frame.size)
    drawArea.image?.draw(in: CGRect(x:0,y:0,width:self.drawArea.frame.width
            ,height:self.drawArea.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to:CGPoint(x:from.x, y:from.y))
        context?.addLine(to: CGPoint(x:to.x, y:to.y))
        
        context?.setBlendMode(.normal)
        context?.setLineCap(.round)
        context?.setLineWidth(brush)
        context?.setStrokeColor(UIColor(red:red,green:green,blue:blue,alpha:1.0).cgColor)
        context?.strokePath()
        
        drawArea.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
    }
    
    func updateSettings(_ settingsVC: SettingsViewController) {
        
        brush = settingsVC.brush!
        red = settingsVC.red!
        green = settingsVC.green!
        blue = settingsVC.blue!
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            
            let settingsVc = segue.destination as! SettingsViewController
            settingsVc.delegate = self
            settingsVc.red = red
            settingsVc.blue = blue
            settingsVc.brush = brush
            settingsVc.green = green
        }
    }


}

