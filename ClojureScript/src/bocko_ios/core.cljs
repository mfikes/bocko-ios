(ns bocko-ios.core
  (:require bocko.core))

(defn init
  []
  (bocko.core/set-create-canvas
    (fn [color-map raster width height pixel-width pixel-height]
      (println "creating canvas" color-map)
      (add-watch raster :monitor
        (fn [_ _ o n]
          (when (not= o n)
            (prn n)))))))
