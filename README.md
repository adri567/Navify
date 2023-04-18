# 🔰 Navify

Navify is a SwiftUI package that simplifies navigation in your app by using a router and coordinator pattern. It provides a clean and organized way to handle navigation, presentation, and alerts.

## ⛓️ Features

- Navigation using Router and Coordinator pattern
- Push, Pop, Present, and Present Full Screen navigation styles
- Supports custom transitions for presentation
- Alert and Confirmation Dialog support
- Detents support for presentation
- SwiftUI-based


## 🛠 Installation

Navify requires iOS 16 and Xcode 14.

1. In Xcode go to `File` ➤ `Add Packages...`

2. In the top right corner, paste `https://github.com/username/Navify.git` and press Enter.

3. Choose `Navify` from the list ➤ `Add Package`

## ⌨️ How to use

1. In order to use Navify correctly you need to import Navify in every File where you use Navify content.
```swift
import Navify
```


2. Next, you need a Router enum and a Coordinator class.

```swift
import SwiftUI
import Navify

enum HomeRouter: Router {

    var id: String { UUID().uuidString }
    
    // MARK: - Views
    case feed
    case settings
    
    // MARK: - Methods
    func viewForDestination() -> some View {
        switch self {
        case .feed:
            Feed()
        case .settings:
            Settings()
    }
}
```
> When you confirm to Router, make sure, that you implement the id and viewForDestination(). The cases indicate where you want to navigate.

```swift
import SwiftUI
import Navify

class HomeCoordinator<R: Router>: ObservableObject, Coordinator {
    
    // MARK: - Properties
    @Published var screens: [Screen<R>] = []
    
    @Published var alert: NavifyAlert = .init(title: "")
    
    // MARK: - Methods
    func popToRoot() {
        screens = []
    }
    
    func navigateTo(_ view: R, style: Types) {
        screens.append(Screen(style: style, view: view))
    }
    
    func presentAlert(with alert: NavifyAlert) {
        self.alert = alert
    }
}
```
> The coordinator class must be a generic of type Router and needs to conform to the Coordinator Protocol. You need to implement the screens property, popToRoot() and func  navigateTo(_ view: R, style:  Types) methods like in the example above. If you want to use an alert in your app, you can implement the alert property and method too.


3. Afterwards you need the NavifyStack which is similar like the NavigationStack.

```swift
import SwiftUI
import Navify

struct ContentView: View {

    @EnvironmentObject private var coordinator: HomeCoordinator<HomeRouter>

    var body: some View {
	     NavifyStack(screens: $coordinator.screens, alert: $coordinator.alert) {
		     HomeView()
	     }
     }
}
```
> The alert parameter is optional. If you don't want to use alerts in your app, you can just use the screens parameter.
