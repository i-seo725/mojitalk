## Mojitalk - 언제 어디서나 팀과 소통하기
<img width="1018" alt="스크린샷 2023-11-12 오전 10 55 52" src="https://github.com/i-seo725/PodoTodo/assets/140357379/901e9bd8-1d6f-4dd6-bd61-eb324756a777">


## 앱 소개
 * 카카오 및 애플 소셜로그인을 통한 간편한 회원가입 및 로그인 지원
 * 워크스페이스를 생성하여 팀원들과의 소통 공간 생성 및 채널을 통한 채팅방 분리
 * 채널 채팅을 통한 팀원들과의 실시간 소통 지원
<br/>

## 주요 기능
 * Moya 라이브러리를 활용하여 Router Pattern으로 추상화한 네트워크 로직으로 채팅 등을 위한 서버 통신
 * Alamofire에 내장된 Interceptor 기능을 활용한 서버 토큰 갱신 로직 구현
 * RxSwift 및 RxDataSources 라이브러리로 작성한 반응형 프로그래밍 코드로 각종 유효성 검사 및 테이블뷰 갱신
 * Realm 라이브러리에 채팅 내용 저장하여 네트워크가 연결되지 않은 환경에서도 지난 채팅 내용 표현
 <br/>

## 개발 기간
 * 2024.01.10. ~ 2023.02.29.
<br/>


## 개발환경
  * Xcode 15.2
  * Supported Destinations : iPhone
  * Minimum Deployments : 16.0
  * Orientation : Portrait
<br/>


## 사용기술 및 라이브러리
 * UIKit, Snapkit, RxSwift, RxDataSources
 * Moya, KakaoOpenSDK, Realm, IQKeyboardManagerSwift
 * MVVM, Repository Pattern, Router Pattern
 <br/>
 
## 트러블 슈팅     
 ### 1. 날짜 변화에 따른 FSCalendar UI 업데이트 이슈
   * 오후 11시 59분에서 자정으로 넘어갈 때 오늘 날짜로 표시되는 UI가 변경되지 않는 이슈 발생
   * `viewWillAppear` 메서드에 캘린더 업데이트 구문을 작성하였으나 다른 탭을 선택했다 돌아와도 변경되지 않음
   * NotificationCenter를 통해 날짜 변화 시점을 관찰하여 자정이 될 때 캘린더 UI가 업데이트 되도록 반영

     ```swift
     override func viewDidLoad() {
          super.viewDidLoad()
          NotificationCenter.default.addObserver(self, selector: #selector(updateToday), name: NSNotification.Name.NSCalendarDayChanged, object: nil)
      }
  
       @objc func updateToday() {
          DispatchQueue.main.async {
              self.todoCalendar.today = Date()
              self.todoCalendar.reloadData()
          }
      }
      
       override func viewDidDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
          NotificationCenter.default.removeObserver(self)
      }
     ```
   
 ### 2. 포도알 채우는 로직 구현 시 예상보다 많은 고려 사항
   * 화면이 나타날 때 로직 계산을 위해 `viewWillAppear`에 메서드를 작성하였는데, Todo를 모두 완료한 경우 화면을 볼 때마다 포도알이 늘어나는 버그 발생
   * 오늘의 Todo를 모두 완료처리 했다가 사용자가 새로운 할 일을 추가하거나 완료 처리를 취소할 때 채웠던 포도알 스티커를 하나 회수해야 하는 상황 발생
   * 다음과 같은 코드를 통한 예외 처리 구현

     ```swift
      func setNewPodo() {
        guard let todayTodo else { return }
        let validateIsDone = todayTodo.filter { $0.isDone == false }
        let date = Date().addingTimeInterval(-86400).dateToString().stringToDate()
        if currentPodoCount() == 10 && (todayTodo.count == 0 || validateIsDone.isEmpty) {
            if let currentPodo {
                podoRepo.update(id: currentPodo._id, isCurrent: false, fillCount: 10, completeDate: date, plusDate: date, deleteDate: nil)
                podoRepo.create(GrapeList(isCurrent: true, completeDate: nil, plusDate: nil, deleteDate: nil))
            }
            currentPodo = podoRepo.fetchCurrent().first
            podoList = podoRepo.fetch()
         }
       }

     func updatePodo() {
        guard let todayTodo else { return }
        let count = currentPodoCount()
        var changeCount = count
        let today = Date().dateToString().stringToDate()
        let validateIsDone = todayTodo.filter { $0.isDone == false }
        
        guard let currentPodo else {
            return
        }
        
        if validateIsDone.isEmpty && todayTodo.count != 0 {
            if currentPodo.plusDate != today {
                changeCount += 1
                if changeCount > 10 || changeCount > count + 1 {
                    return
                }
                podoRepo.update(id: currentPodo._id, isCurrent: true, fillCount: changeCount, completeDate: nil, plusDate: today, deleteDate: nil)
            }
        } else {
            if currentPodo.deleteDate != today && currentPodo.plusDate == today {
                changeCount -= 1
                if changeCount < 0 || changeCount < count - 1 {
                    return
                }
                podoRepo.update(id: currentPodo._id, isCurrent: true, fillCount: changeCount, completeDate: nil, plusDate: nil, deleteDate: today)
            }
        }
    
     ```

<br/>

## 회고
 * 서버와의 네트워크 통신에서 크고 작은 이슈가 많이 발생하였는데 이러한 이슈 대응 경험이 후에 많은 도움이 될 것이라고 여겨짐
 * 주어진 기획안의 내용 뿐만 아니라 사용자의 편의성을 고려하느라 사소한 부분에 신경을 많이 써 보다 많은 기능을 구현하지 못해 아쉬움이 남음
 * Xcode 15 업데이트 후 에셋 관리를 하지 않아도 UIImage 및 UIColor로 불러올 수 있게 되어 코드로 정리하지 않았으나,
   일부 기능을 사용할 때에는 해당 기능을 사용하기 어려워 정리하는 것이 낫다고 판단되어 다음 개발 시 반영하기로 다짐함
