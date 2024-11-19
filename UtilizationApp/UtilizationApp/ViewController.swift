//
//  ViewController.swift
//  UtilizationApp
//
//  Created by khanhnvm on 13/11/24.
//

import UIKit


/*
    We defined a class ViewController inherited UIViewController.
    As we know about class is a template a fold for us could rely on it created an instance to use. But created an instance it simililarly with we have allocate variable in the memory
 
    -> So all stuffs in the class define with name ViewController acts as the mold/khuôn đúc
    And when we actualy run the app with this mold, one instance is created
    It becomes and goes up to the heap
 */
final class ViewController: UIViewController {
    
    // This is property internal class, it has type UILabel
    // we use weak here cause regarding with ARC, or about referring counter
    // this property have connect with the object in the story using keyword @IBOutlet
    @IBOutlet weak var mainLabel: UILabel!
    // Để có thể thay đổi hoặc lấy giá trị của một thuộc tính thì phải khai báo outlet ở đây
    @IBOutlet weak var slider: UISlider!
    // Variable will be initiate time loop
    weak var timer: Timer?
    // The count number using when timer will count
    var number: Int = 0
    
    // This method will run first when we enter to this screen, this method defined in the UIVewController class, we inherited this class so with the knowledge about OOP, when inherited the super class and use the method was defined we will redefined
    override func viewDidLoad() {
        super.viewDidLoad()
        // Actually the property mainLabel we could set text in the Storyboard, but typically developer or the project will developed by developer in around the word using set with code
        // mainLabel.text = "Select the second you want to start"
        
        // Replace with calling the method configureUI()
        // Ý nghĩa thật sự flow ở đây là hàm viewDidLoad() được gọi định nghĩa lại, thì khi thực thi cũng sẽ gọi đến hàm configureUI() để thực thi các câu lệnh mã code mà chúng ta đã viết bên trong
        configureUI()
    }

    
    // Let the code be neatly we will using define a method will excute the setup layout or UI
    private func configureUI() {
        mainLabel.text = "Select the second here"
        
        // Set the center of slider
        slider.value = 0.5
    }
    
    // MARK: Action
    
    // Slider action will send the changed value here, and we handle excute the action in side the block method
    @IBAction func sliderChanged(_ sender: UISlider) {
        // Set the main lable with the value slider
        // Công việc ta cần xử lý ở đây là sẽ lấy ra được giá trị
        // khi người dùng thực hiện kéo trượt nút thumb ở trên slider
        // Lấy được value của slider và sẽ dùng nó * với số giây và chuyển đổi nó về số Int để làm tròn số này
        // IPO như sau:
        // Input: người dùng thực hiện kéo nút tròn thumb trên slider
        // Processing:
        //  - Lấy được giá trị slider bằng slider.value
        //  - tính bằng công thức value * 60 -> lấy ra được giá trị
        // Output:
        //  - Hiển thị giá trị sau khi tính toán lên mainLabel
        let seconds = Int(slider.value * 60)
        debugPrint(seconds)
        mainLabel.text = "\(seconds) seconds"
        number = seconds
    }
    
    // The code will be excute when user tapped the button, and this method will excute
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // Thực thi vài thứ gì đó ở đây khi thời gian trôi qua 1s
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            if number > 0 {
                number -= 1
                slider.value = Float(number) / Float(60)
                mainLabel.text = "\(number) seconds"
            } else {
                // Set the value to default and also stop the timer prevent loop infinity
                number = 0
                mainLabel.text = "Select the second here"
                timer?.invalidate()
            }
        })
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // Khởi tạo lại giá trị
        mainLabel.text = "Select the second here"
        slider.value = 0.5
        
        // set the center of the slider
    }
}

