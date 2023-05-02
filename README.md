<div align="center">
  <img src="https://user-images.githubusercontent.com/26815443/232783649-896a94cf-7fb0-49c7-a0b2-4ac5a85862f6.png" width="600"/>
</div>

--------

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

1. To use Navify correctly, you must import it in every file that contains Navify content.
```swift
import Navify
```

2. Next, you need a Router enum which needs to conform to the Router protocol. Afterwards you need to implement the id propertie and viewForDestination method as following:

```swift
import SwiftUI
import Navify

enum MyRouter: Router {

    var id: String { UUID().uuidString }
    
    // MARK: - Views
    case YourView
    
    // MARK: - Methods
    func viewForDestination() -> some View {
        switch self {
        case .feed:
            YourView()
    }
}
```
3. To ues the coordinator, you need to create a coordinator class where you have to conform to the Coordinator protocol. The Coordinator class must be a generic type of Router. If you conform to the Coordinator protocol, you need to implement following properties and methods:

```swift
import SwiftUI
import Navify

class MyCoordinator<R: Router>: ObservableObject, Coordinator {
    
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
> If you don't want to use a alert, you can remove the alert propertie and method.

4. Afterwards you need the NavifyStack which is similar like the NavigationStack.

```swift
	NavifyStack(screens: Binding<[Screen<D>]>, alert: Binding<NavifyAlert>, content: () -> Content)
```
> The alert parameter is optional. If you choose not to use alerts in your app, you can simply use the screens parameter instead.

5. To navigate between views, you can use the methods provided by the coordinator.

```swift
    /// Navigates to a view
    navigateTo(view: Router, style: Types)
    /// Presents an alert
    presentAlert(with: NavifyAlert)
    /// Pops to root
    popToRoot()
```
> If you leave the message parameter empty, the confirmation dialog will be displayed without a message.

5. To dismiss a view, you can use the default environment property that is provided with SwiftUI.

```swift
    @Environment(\.dismiss) private var dismiss
  
```

