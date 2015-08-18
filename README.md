# Bocko iOS

Render Bocko onto iOS: Using a ClojureScript REPL, you can render [Bocko](https://github.com/mfikes/bocko) into a native iOS app running in a simulator or on your device.

<img src="icon.png"/>

# Prerequisites

You need Lein and CocoaPods and Xcode.

# Usage

```
lein new bocko-ios my-project
```

Then find a short `README.md` at the top-level of the generated project, explaining how to get up and running.

# Examples

Here is a pic of what `bocko-ios` looks like in action:

![iOS and REPL](https://pbs.twimg.com/media/CElZIPdUIAAC7Us.jpg)

Try some of the examples from the [Bocko](https://github.com/mfikes/bocko#examples) page.

# Standalone App

If you would like to make an app that runs your ClojureScript upon launch, simply revise `bocko-ios.core/run-app` to run your code. If you then do a `lein cljsbuild once dev`, your code will be bundled into the app and executed upon launch.

If you would like to make an optimized build of your standalone app, instead do `lein cljsbuild once rel` and change to a Release scheme in Xcode.

# Threading Concerns

Note that you shouldn't block the JavaScriptCore thread using direct `loop/recur`, otherwise you'll lock up the only processing thread. But, with `core.async` (which is included as a dependency) you can achieve the desired result using `go-loop` along with other requisite changes.

For example, here is the painting colors / bouncing ball example from the Bocko page, where the changes needed comprise:

1. Don't use `future`, as there are no threads.
2. Use `go-loop` instead of `loop`.
3. Make use of `(<! (timeout n))` instead of `(Thread/sleep n)`, where _n_ is in milliseconds.
4. When binding the dynamic var `*color*`, don't allow the `core.async` `go` macro to defeat the binding via its code rewriting. Specifically, reduce the scope of the binding so that no async operation (like `<!`) is within scope of the binding.

With these revisions, this works:

```clojure
(require '[cljs.core.async :refer [<! timeout]])
(require-macros '[cljs.core.async.macros :refer [go-loop]])

(do

  ;; Repeatedly display all the colors

  (go-loop []
    (clear)
    (doseq [[c n] (map vector
                    [:black :red :dark-blue :purple
                     :dark-green :dark-gray :medium-blue :light-blue
                     :brown :orange :light-gray :pink
                     :light-green :yellow :aqua :white]
                    (range))]
      (let [x' (* 10 (rem n 4))
            y' (* 10 (quot n 4))]
        (doseq [x (range x' (+ 10 x'))
                y (range y' (+ 10 y'))]
          (binding [*color* c]
            (plot x y))
          (<! (timeout 1)))))
    (recur))

  ;; Add a bouncing ball

  (go-loop [x 5 y 23 vx 1 vy 1]
    ; First determine new location and velocity,
    ; reversing direction if bouncing off edge.
    (let [x' (+ x vx)
          y' (+ y vy)
          vx' (if (< 0 x' 39) vx (- vx))
          vy' (if (< 0 y' 39) vy (- vy))]
      ; Erase drawing at previous location
      (binding [*color* :black]
        (plot x y))
      ; Draw ball in new location
      (binding [*color* :dark-blue]
        (plot x' y'))
      ; Sleep a little and then loop around again
      (<! (timeout 50))
      (recur x' y' vx' vy'))))
```

### rlwrap

For a better REPL experience (keyboard input editing and history support), you can install
[rlwrap](http://utopia.knoware.nl/~hlub/uck/rlwrap/) under OS X with
[Homebrew](http://brew.sh/):

```
brew install rlwrap
```

Then `script/repl` will automatically detect that you have `rlwrap` installed and use it.

# License

Copyright © 2015 Mike Fikes and Contributors

Distributed under the Eclipse Public License either version 1.0 or (at your option) any later version.
