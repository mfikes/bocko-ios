# bocko-ios

Render Bocko onto iOS: Using a ClojureScript REPL, you can render Bocko into a native iOS app running in a simulator or on your device.

# Prerequisites

You need Lein and CocoaPods and Xcode.

# Usage

1. Clone the [Ambly](https://github.com/omcljs/ambly) repo, and in its `Clojure` directory do a `lein install` in order to build a local snapshot of Ambly.
2. Clone this repo.
3. In the `ClojureScript` directory run `lein cljsbuild once dev`.
4. In the `iOS` directory run `pod install`.
5. Open `Bocko.xcworkspace` and run the Bocko app in a simulator or on a device.
6. In the `ClojureScript` directory run `lein run -m ambly.repl.jsc`.
7. Choose your discovered Bocko app.
8. In the REPL, `(require '[bocko.core :refer [color plot scrn hlin vlin clear]])`.

Now you can use Bocko, plotting in your simulator or on your device.

```
cljs.user=> (color :pink)
nil
cljs.user=> (plot 3 4)
nil
```
