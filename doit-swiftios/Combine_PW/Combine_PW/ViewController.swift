//
//  ViewController.swift
//  Combine_PW
//
//  Created by Wooyoung on 2022/11/18.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfPasswordConfirm: UITextField!
    @IBOutlet var btnConfirm: UIButton!
    
    var viewModel: MyViewModel!
    
    private var mySubscriptionSet = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = MyViewModel()
        
        
        //MARK: - UITextField의 Publisher들 -> MyViewModel의 Property가 구독
        tfPassword
        // ** tfPassword 텍스트필드에 publisher 설정하고 **
            .myTextPublisher
            .print()
        // GDC(Grand Central Dispatch API): iOS의 공유된 thread pool을 관리하는 API
        // DispatchQueue는 GCD를 이용하기 위한 명령어
        // GCD의 queue에는 main,global,custom이 있다. main(main thread인 serial queue를 사용.직렬형태), global(전체 시스템에 공유되는 concurrent queue사용. 병렬형태)
        // 동기방식 sync, async,asyncAfter: sync 큐 작업 끝날 때까지 다음 실행 x, async 큐 작업있어도 다른 작업 비동기로 동시 진행, asyncAfter 일정 시간 후 비동기로 진행
        // ** publisher의 전달하는 값을 main 스레드에서 받고 **
            .receive(on: DispatchQueue.main)
        // KeyPath로 표시된 프로퍼티에 수신된 값을 할당한다. 간단히 말해 받은 값을 지정한 곳에 저장하는 subscriber 설정 (KeyValue Observing)
        // ** viewModel의 passwordInput 프로퍼티에 저장(구독) **
            .assign(to: \.passwordInput, on: viewModel)
        // 메모리 관리를 위해서 Set<AnyCancellable>을 만들어서 저장해둠.
            .store(in: &mySubscriptionSet)
        
        tfPasswordConfirm
            .myTextPublisher
            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordInputConfirm, on: viewModel)
            .store(in: &mySubscriptionSet)
        
        //MARK: - MyViewModel의 Publisher -> UIButton이 구독
        viewModel
            .isMatchPasswordInput
            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isValid, on: btnConfirm)
            .store(in: &mySubscriptionSet)
    }


}

// extension으로 UITextField에 기능 추가. (Publisher 기능 추가)
extension UITextField {
    var myTextPublisher: AnyPublisher<String, Never> {
        // myTextPublisher를 AnyPublisher 타입으로 클로저로 가져옴
        // UITextField의 NotificationCenter.default를 publisher로 하여 가져옴
        // object:self -> 자기 자신= UITextField, UITextField의 textDidChangeNotification이 들어왔을 때 이벤트 발산
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
//            .print()
        // compactMap -> nil이 아닌 배열을 반환함. 받은 값에서 object에서 UITextField를 가져옴.
            .compactMap{ $0.object as? UITextField }
//            .print()
        // UITextField에서 text(String) 를 가져옴. 값이 없으면 ""로 반환
            .map{ $0.text ?? "" }
//            .print()
        // filtering한 값을 AnyPublisher 형태로 가져옴
            .eraseToAnyPublisher()
    }
}
//publisher로부터 받은 값
//receive value: (name = UITextFieldTextDidChangeNotification,
//                object = Optional(
//                    <UITextField: 0x7fab04012400;
//                     frame = (0 0; 353 60);
//                     opaque = NO;
//                     autoresize = RM+BM;
//                     gestureRecognizers = <NSArray: 0x600000a31110>;
//                     text = '1';
//                     placeholder = 비밀번호 입력;
//                     borderStyle = RoundedRect;
//                     background = <_UITextFieldSystemBackgroundProvider: 0x60000045a2c0: backgroundView=<_UITextFieldRoundedRectBackgroundViewNeue: 0x7fab07c091c0;
//                     frame = (0 0; 353 60);
//                     opaque = NO;
//                     autoresize = W+H;
//                     userInteractionEnabled = NO;
//                     backgroundColor = <UIDynamicSystemColor: 0x6000011392c0;
//                     name = _textFieldBackgroundColor>;
//                     layer = <CALayer: 0x60000045a320>>, fillColor=(null), textfield=<UITextField 0x7fab04012400>>;
//                     layer = <CALayer: 0x60000046f400>
//                     >
//                                 ),
//                userInfo = nil)


extension UIButton {
    var isValid: Bool {
        get {
            // 버튼의 색이
            backgroundColor == UIColor.yellow
        }
        set {
            // isValid에 대한 값을 설정하면(newValue) 배경색을 바꿈. true면 노랑, false면 회색
            backgroundColor = newValue ? UIColor.yellow : UIColor.lightGray
            isEnabled = newValue
            setTitleColor(newValue ? UIColor.blue : UIColor.white, for: .normal)
        }
    }
}
