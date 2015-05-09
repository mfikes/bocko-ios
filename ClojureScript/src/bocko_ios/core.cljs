(ns bocko-ios.core
  (:require bocko.core))

(defn ^:export init
  [canvas-view-controller]
  (bocko.core/set-create-canvas
    (fn [color-map raster width height _ _]
      (add-watch raster :monitor
        (fn [_ _ o n]
          (when (not= o n)
            (doseq [x (range width)
                    y (range height)]
              (let [[r g b] ((get-in n [x y]) color-map)]
                (.plotXYRedGreenBlue canvas-view-controller x y r g b)))))))))
