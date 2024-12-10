//
//  Untitled.swift
//  Ruti
//
//  Created by leeyeon2 on 10/1/24.
//

//import RxSwift
//import RxCocoa
//
//class RotineRegistViewModel: BaseViewModel {
//    
//    var input = Input()
//    var output = Output()
//    
//    struct Input {
//        let email = PublishSubject<String>()
//        let password = PublishSubject<String>()
//        let tapSignIn = PublishSubject<Void>()
//    }
//    
//    struct Output {
//        let enableSignInButton = PublishRelay<Bool>()
//        let errorMessage = PublishRelay<String>()
//        let goToMain = PublishRelay<Void>()
//    }
//    
//    
//    init() {
//        super.init()
//        
//        Observable.combineLatest(input.email, input.password)
//            .map{ !$0.0.isEmpty && !$0.1.isEmpty }
//            .bind(to: output.enableSignInButton)
//            .disposed(by: disposeBag)
//        
//        input.tapSignIn.withLatestFrom(Observable.combineLatest(input.email, input.password)).bind { [weak self] (email, password) in
//            guard let self = self else { return }
//            if password.count < 6 {
//                self.output.errorMessage.accept("6자리 이상 비밀번호를 입력해주세요.")
//            } else {
//                // API 태우기
//                self.output.goToMain.accept(())
//            }
//        }.disposed(by: disposeBag)
//    }
//    
//}
