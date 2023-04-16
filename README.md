![GoXlrKit banner](https://user-images.githubusercontent.com/63637808/232327849-513d5586-1beb-412a-a70c-8a9fe6649dd6.png)

# GoXlrKit

GoXlrKit allows accessing to the status of every GoXLR connected, as well as sending commands to the connected GoXLRs. This module also brings controls on the GoXlr-utility itself.

## Installation

Go in File -> Add packages... and paste the following URL in the search bar:
```
https://github.com/Adelenade/GoXlrKit
```

Don't forget to add inside the Sources/GoXlrKit/Ressources folder a build of the [goxlr utility](https://github.com/GoXLR-on-Linux/goxlr-utility)'s goxlr-daemon and of the goxlr-defaults ! If you don't, every utility-related command will fail (startObserving, daemon.start etc...) and will make your app crash.

## Usage

Here is a little example on how you can use this package:
```swift
import SwiftUI
import GoXlrKit

struct ContentView: View {
    
    @ObservedObject var goxlr = GoXlr.shared
    
    var body: some View {
        VStack {
            if goxlr.status != nil {
                Text("Connected to the Daemon with GoXlr \(goxlr.device)")
                    .padding()
                Text("Goxlr's System volume: \(goxlr.status!.data.status.mixers[goxlr.device]?.levels.volumes.system ?? 0)")
                Button("Set System volume to 100%") {
                    guard goxlr.device != "" else { return } // check if a GoXlr is connected
                    
                    goxlr.status!.data.status.mixers[goxlr.device]!.levels.volumes.system = 255 //Set System volume to maximum. Volumes are a Float going from 0 to 255 (The daemon only uses Int values but GoXlrKit provides Float values to allow directly binding to sliders)
                    //As you can see, you don't need to manually send the commands to the Daemon: the module does it by itself.
                }.disabled(goxlr.status == nil)
                
            } else {
                ProgressView()
            }
        }.onAppear() {
            goxlr.startObserving() // Start the Daemon and connect to its WebSocket
            //If you don't need to connect to the websocket, you can do goxlr.daemon.start(args: [DaemonArguments])
            //If you only need to connect to the websocket, do goxlr.socket.connect()
            
            //Make sure the utility isn't already launched, else the app will crash
        }
        .padding()
    }
}
```

*This project is not supported by, or affiliated in any way with, TC-Helicon. For the official GoXLR software, please refer to their website.*
