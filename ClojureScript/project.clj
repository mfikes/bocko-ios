(defproject bocko-ios "1.1.0"
  :description "Use Bocko on iOS"
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [org.clojure/clojurescript "1.9.562"]
                 [org.clojure/core.async "0.3.443"]
                 [bocko "1.0.0"]
                 [ambly "1.0.0"]]
  :plugins [[lein-cljsbuild "1.1.6"]]
  :source-paths ["src"]
  :clean-targets ["target" "out"]
  :cljsbuild {:builds {:dev
                       {:source-paths ["src"]
                        :compiler     {:output-to      "target/out/main.js"
                                       :output-dir     "target/out"
                                       :optimizations  :none}}
                       :rel
                       {:source-paths ["src"]
                        :compiler     {:output-to     "target/out/main.js"
                                       :optimizations :advanced
                                       :externs       ["externs.js"]
                                       :pretty-print  false
                                       :pseudo-names  false}}}})
