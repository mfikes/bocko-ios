(ns bocko-ios.core
  (:require bocko.core))

(defn ^:export init
  [canvas-view-controller]
  (bocko.core/set-create-canvas
    (fn [color-map raster width height _ _]
      (add-watch raster :monitor
        (fn [_ _ old new]
          (when-not (= old new)
            (doseq [x (range width)
                    y (range height)]
              (let [old-color (get-in old [x y])
                    new-color (get-in new [x y])]
                (when-not (= old-color new-color)
                  (let [[r g b] (new-color color-map)]
                    (.plotXYRedGreenBlue canvas-view-controller x y r g b)))))
            (.refreshDisplay canvas-view-controller)))))))
