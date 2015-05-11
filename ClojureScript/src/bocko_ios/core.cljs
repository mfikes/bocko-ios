(ns bocko-ios.core
  (:require bocko.core))

(defn run-app
  []
  (comment "Code here will be run when app launches"))

(defn ^:export init
  [canvas-view-controller]
  (bocko.core/set-create-canvas
    (fn [color-map raster width height _ _]
      (add-watch raster :monitor
        (fn [_ _ old new]
          (when-not (= old new)
            (doseq [x (range width)]
              (let [old-col (nth old x)
                    new-col (nth new x)]
                (when-not (= old-col new-col)
                  (doseq [y (range height)]
                    (let [old-color (nth old-col y)
                          new-color (nth new-col y)]
                      (when-not (= old-color new-color)
                        (let [[r g b] (new-color color-map)]
                          (.plotXYRedGreenBlue canvas-view-controller x y r g b)))))))))))))
  (run-app))

