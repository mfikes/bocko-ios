# bocko-ios

Render Bocko onto iOS: Using a ClojureScript REPL, you can render [Bocko](https://github.com/mfikes/bocko) into a native iOS app running in a simulator or on your device.

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
8. In the REPL, `(require '[bocko.core :refer [color plot scrn hlin vlin clear *color*]])`.

Now you can use Bocko, plotting in your simulator or on your device.

```
cljs.user=> (color :pink)
nil
cljs.user=> (plot 3 4)
nil
```

Try some of the examples from the [Bocko](https://github.com/mfikes/bocko) page. 

Note that you can't block the JavaScriptCore thread using direct `loop/recur`, but with `core.async` (which is included as a dependency) you can achieve the same using `go-loop` and other requisite changes.

For example, here is the painting colors / bouncing ball example from the Bocko page, where the changes needed comprise:

1. Don't use `future`, as there are no threads.
2. Use `go-loop` instead of `loop`.
3. Make use of `(<! (timeout n))` instead of `(Thread/sleep n)`, where _n_ is in milliseconds.
4. When binding the dynamic var `*color*`, don't allow `core.async` to rewrite the code, defeating the binding. In other words, reduce the scope of the binding so that no async operation like `<!` is within scope of the binding.

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

Here is a pic of what `bocko-ios` looks like in action:

![iOS and REPL](https://pbs.twimg.com/media/CElZIPdUIAAC7Us.jpg)

### rlwrap

For a better REPL experience (keyboard input editing and history support), you can install
[rlwrap](http://utopia.knoware.nl/~hlub/uck/rlwrap/) under OS X with
[Homebrew](http://brew.sh/):

```
brew install rlwrap
```

Then you can start the Ambly REPL with `lein run -m ambly.repl.jsc`.
