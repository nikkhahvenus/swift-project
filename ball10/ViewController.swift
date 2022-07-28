//
//  ViewController.swift
//  ball10
//
//  Created by Apple on 5/5/1401 AP.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    let randomLukyTexts = ["خوش شانسی","بد شانسی","پیروزی","شکست","خیلی خوب","خوب"]
    ////////////////////////////////////////////////

    let randomColors = [UIColor.orange, UIColor.systemPink, UIColor.yellow, UIColor.purple, UIColor.green, UIColor.blue, UIColor.gray,UIColor.red]

    @IBOutlet weak var wheelBtn: UIButton!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var luckLbl: UILabel!
    @IBAction func whellBtnPressed(_ sender: Any) {
        randWheel()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    func setupView(){
           self.wheelBtn.layer.shadowColor = UIColor(rgb:0xFFfddb3a).withAlphaComponent(0.5).cgColor
           wheelBtn.layer.shadowOffset = CGSize(width : 4, height : 4)
           wheelBtn.layer.shadowOpacity = 1.0
           wheelBtn.layer.shadowRadius = 0.0
           wheelBtn.layer.masksToBounds = false
           //wheelBtn.layer.cornerRadius = 4.0
           wheelBtn.makeRadius(radius : 2)
        
           numberLbl.text = "0"
           luckLbl.text = ""
           setHello()
       }

}


extension UIColor{
    convenience init( red : Int , green : Int , blue : Int ){
        assert( red >= 0 && red <= 255, "Invalid Red Component")
        assert( green >= 0 && green <= 255, "Invalid Green Component")
        assert( blue >= 0 && blue <= 255, "Invalid Blue Component")
        
        self.init(red : CGFloat(red) / 255.0 ,green : CGFloat(green) / 255.0 ,blue : CGFloat(blue) / 255.0 ,alpha : 0.1 )
    }
    convenience init(rgb : Int){
        self.init(
            red: ( rgb >> 16 ) & 0xFF,
            green: ( rgb >> 8 ) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIButton {
    func makeRadius(radius : CGFloat){
        assert(radius > 0 , "Invalid radius number")
        self.layer.cornerRadius = radius
    }
    func setBtnTitle(title : String){
        self.setTitle(title, for: .normal)
        
    }
}

extension ViewController{
    
    func setHello()  {
        self.wheelBtn.setBtnTitle(title: "Hello")
    }
    ///////////////////////////////////////////
    func getRandomNumber(index: Int) -> UInt32 {
        let lower: UInt32 = 0
        let upper: UInt32 = 6
        
        let randomNumber = arc4random_uniform(upper - lower) + lower
        
        //wheelBtn.setTitle( "\(getPersianNumber(number : randomNumber))" , for: .normal)
        wheelBtn.setBtnTitle( title: "\(getPersianNumber(number : randomNumber))" )
        return randomNumber
    }
    ////////////////////////////////////////////////

    func getPersianNumber(number : UInt32) ->String{
        var num : String = ""
        switch(number){
        case 0:
            num = "۰"
            break
        case 1:
            num = "۱"
            break
        case 2:
            num = "۲"
            break
        case 3:
            num = "۳"
            break
        case 4:
            num = "۴"
            break
        case 5:
            num = "۵"
            break
        case 6:
            num = "۶"
            break
        case 7:
            num = "۷"
            break
        case 8:
            num = "۸"
            break
        case 9:
            num = "۹"
            break
        default:
            num = "۰"
      }
        return num
    }
    ////////////////////////////////////
    func randWheel()  {
     //print(getRandomNumber(index:0))
     var randomLuckyNumber : UInt32!
     DispatchQueue.global(qos: .background).async {
         for i in 0...6 {
             
             DispatchQueue.main.async {
                 randomLuckyNumber = self.getRandomNumber(index: i )
                 self.wheelBtn.backgroundColor = self.randomColors [i]
                 print(i)
                 if(i == 6){
                     self.wheelBtn.isEnabled = true
                     self.numberLbl.text = self.getPersianNumber(number: randomLuckyNumber!)
                     self.luckLbl.text = self.randomLukyTexts                        [Int (randomLuckyNumber!)]
                     //self.wheelBtn.setTitle("شانستو امتحان کن", for: .normal)
                     self.wheelBtn.setBtnTitle(title: "شانستو امتحان کن" )
                 } else {
                     self.wheelBtn.isEnabled = false
                     self.luckLbl.text = ""
                 }
             }
             usleep(useconds_t(200000))
         }
     }
 }
    
    
}
