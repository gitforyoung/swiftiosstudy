//
//  MyViewModel.swift
//  Combine_PW
//
//  Created by Wooyoung on 2022/11/18.
//

import Foundation
import Combine

class MyViewModel {
    // @Published 어노테이션을 붙여서 "Property Wrapper"를 통해 Publisher로 사용할 수 있음.
    @Published var passwordInput: String = "" {
        didSet {
            print("passwordInput didSet: \(passwordInput)")
        }
    }
    @Published var passwordInputConfirm: String = "" {
        didSet {
            print("passwordInputConfirm didSet: \(passwordInputConfirm)")
        }
    }
    
    // 들어온 퍼블리셔들의 값이 일치하는지 여부를 반환하는 퍼블리셔
    lazy var isMatchPasswordInput:AnyPublisher<Bool,Never> = Publishers
    // CombineLatest: 2개의 퍼블리셔로부터 가장 최근의 값을 받아 조합하는 퍼블리셔
        .CombineLatest($passwordInput, $passwordInputConfirm)
        .map { (password:String, passwordConfirm:String) -> Bool in
            if password == "" || passwordConfirm == "" {
                return false
            }
            if password == passwordConfirm {
                return true
            } else {
                return false
            }
        }
//        .print()
        .eraseToAnyPublisher()
}
