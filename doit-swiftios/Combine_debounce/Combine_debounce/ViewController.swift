//
//  ViewController.swift
//  Combine_debounce
//
//  Created by Wooyoung on 2022/11/18.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet var lblText: UILabel!
    
    // UISearchController(view controller): search bar와 상호작용하는 것을 바탕으로 검색 결과를 보여주는 것을 관리하는 뷰컨트롤러
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        // obscureBackgroundDuringPresentation는 search bar로 최초 응답자가 가게 되면 나머지 뷰들을 어둡게 할 것인지 설정
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .systemPink
        searchController.searchBar.searchTextField.accessibilityIdentifier = "mySearchBarTextField"
        return searchController
    }()
    
    var mySubscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Controller를 임베디드 했으므로 navigationItem이  있음. searchController를 위해서 정의한 searchController로 설정함. searchController를 lazy로 설정했기 때문에 이때 호출될 때 메모리로 올라감.
        self.navigationItem.searchController = searchController
        searchController.isActive = true
        
        searchController.searchBar.searchTextField
            .myDebounceSearchPublisher
        // 클로저 안에서 self를 쓸 때 순환참조 문제 발생. [weak self] 사용하여 약한 참조.
            .sink { [weak self] (receivedValue) in
                print("receivedValue : \(receivedValue)")
                self?.lblText.text = receivedValue
            }
            .store(in: &mySubscription)
    }


}

extension UISearchTextField {
    var myDebounceSearchPublisher: AnyPublisher<String, Never> {
        //.publishcer(for:object:) - for:publish할 notification, object:notification을 posting하는 object
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap{ $0.object as? UISearchTextField }
            .map{ $0.text ?? ""}
        // debounce : Publishes elements only after a specified time interval elapses between events.
        // debounce가 없는 경우 타이핑할 때마다 값을 받아 동작하기 때문에 리소스 낭비가 심해짐.
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
        // filter를 이용해서 글자가 있을 때만 값을 전달하도록 함.
            .filter{ $0.count > 0 }
            .print()
            .eraseToAnyPublisher()
    }
}
