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
> When confirming with the Router, make sure to implement the id and viewForDestination() functions. The cases indicate the destination you wish to navigate to.

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
> The Coordinator class must be a generic of type Router and conform to the Coordinator Protocol. You must implement the screens property, popToRoot(), and navigateTo(_ view: R, style: Types) methods as shown in the example above. If you want to use an alert in your app, you can also implement the alert property and method.

3. Afterwards you need the NavifyStack which is similar like the NavigationStack.

```swift
import SwiftUI
import Navify

@main
struct NavifyTestApp: App {
    
    // MARK: - Properties
    @StateObject private var homeCoordinator: HomeCoordinator<HomeRouter> = HomeCoordinator<HomeRouter>()
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeCoordinator)
        }
    }
}

struct ContentView: View {

    // MARK: - Properties
    @EnvironmentObject private var coordinator: HomeCoordinator<HomeRouter>

    // MARK: - Body
    var body: some View {
    	NavifyStack(screens: $coordinator.screens, alert: $coordinator.alert) {
		HomeView()
	}
    }
}
```
> The alert parameter is optional. If you choose not to use alerts in your app, you can simply use the screens parameter instead.

4. To navigate between views, you can use the methods provided by the coordinator.

```swift
struct HomeView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var coordinator: HomeCoordinator<HomeRouter>
    
    // MARK: - Body
    var body: some View {
        VStack {
            /// Push and present
            Button("Push") {
                coordinator.navigateTo(.feed, style: .init(segue: .push))
            }
            Button("Present") {
                coordinator.navigateTo(.feed, style: .init(segue: .present))
            }
            Button("Present with Detents") {
                coordinator.navigateTo(.feed, style: .init(segue: .present, detents: Detents(presentationDetents: [.medium])))
            }
            Button("PresentFullScreen") {
                coordinator.navigateTo(.feed, style: .init(segue: .presentFullScreen))
            }
            
            /// Alert and confirmationDialog
            Button("Present Alert") {
                coordinator.presentAlert(with:
                                            NavifyAlert(
                                                isPresenting: true,
                                                option: .alert,
                                                title: "My Alert",
                                                message: "Alert 2",
                                                content: {
                                                    buttons
                                                })
                )
            }
            Button("Present Confirmation Dialog 1") {
                coordinator.presentAlert(with:
                                            NavifyAlert(
                                                isPresenting: true,
                                                option: .confirmationDialog,
                                                title: "My ConfirmationDialog 1",
                                                message: "",
                                                content: {
                                                    confirm1
                                                })
                )
            }
            Button("Present Confirmation Dialog 1") {
                coordinator.presentAlert(with:
                                            NavifyAlert(
                                                isPresenting: true,
                                                option: .confirmationDialog,
                                                title: "My ConfirmationDialog 2",
                                                message: "Confirmation 2",
                                                content: {
                                                    confirm1
                                                })
                )
            }
        }
    }
    
    // MARK: - Views
    @ViewBuilder private var confirm1: some View {
        Button("Button1") {}
    }
        
    @ViewBuilder private var buttons: some View {
	/// You can also use TextField with Buttons
        Button("Button1") {}
        Button("Button2") {}
    }
}
```
> If you leave the message parameter empty, the confirmation dialog will be displayed without a message.

5. To dismiss a view, you can use the default environment property that is provided with SwiftUI.

```swift
struct Feed: View {

    // MARK: - Properties
    @EnvironmentObject private var coordinator: HomeCoordinator<HomeRouter>
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Feed")
            Button("To Root") {
                coordinator.popToRoot()
            }
            Button("dismiss") {
                dismiss()
            }
        }
    }
}
```

