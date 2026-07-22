;; Thesmsworks SDK generated API tests.
(ns sdk.gentest
  (:require [sdk.api :as api]
            [sdk.config :as config]
            [sdk.testutil :as t]
            [clojure.string]
            [voxgig.struct :as vs]
            [sdk.entity.batch :as e-batch]
            [sdk.entity.batch_message :as e-batch_message]
            [sdk.entity.credit :as e-credit]
            [sdk.entity.flash :as e-flash]
            [sdk.entity.message :as e-message]
            [sdk.entity.one_time_password :as e-one_time_password]
            [sdk.entity.schedule :as e-schedule]
            [sdk.entity.swagger :as e-swagger]
            [sdk.entity.util :as e-util]))

(defn run [rec]
  (t/run-check rec "gen-exists-batch"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/batch sdk nil)) "batch accessor present"))))
  (t/run-check rec "gen-exists-batch_message"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/batch_message sdk nil)) "batch_message accessor present"))))
  (t/run-check rec "gen-smoke-batch_message"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/batch_message sdk nil)]
             (let [res (e-batch_message/create ent (vs/jm "name" "smoke") nil)]
               (t/is-true (vs/ismap res) "create returns a record map")
               (t/is-true (some? (vs/getprop res "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-exists-credit"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/credit sdk nil)) "credit accessor present"))))
  (t/run-check rec "gen-exists-flash"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/flash sdk nil)) "flash accessor present"))))
  (t/run-check rec "gen-exists-message"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/message sdk nil)) "message accessor present"))))
  (t/run-check rec "gen-smoke-message"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/message sdk nil)]
             (let [res (e-message/create ent (vs/jm "name" "smoke") nil)]
               (t/is-true (vs/ismap res) "create returns a record map")
               (t/is-true (some? (vs/getprop res "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-exists-one_time_password"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/one_time_password sdk nil)) "one_time_password accessor present"))))
  (t/run-check rec "gen-smoke-one_time_password"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/one_time_password sdk nil)]
             (let [res (e-one_time_password/create ent (vs/jm "name" "smoke") nil)]
               (t/is-true (vs/ismap res) "create returns a record map")
               (t/is-true (some? (vs/getprop res "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-exists-schedule"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/schedule sdk nil)) "schedule accessor present"))))
  (t/run-check rec "gen-exists-swagger"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/swagger sdk nil)) "swagger accessor present"))))
  (t/run-check rec "gen-exists-util"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/util sdk nil)) "util accessor present"))))
  (t/run-check rec "gen-prepare-batch"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/batch" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-batch"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/batch" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-credit"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/credit" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-credit"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/credit" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-message"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/message" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-message"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/message" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-one_time_password"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/one_time_password" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-one_time_password"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/one_time_password" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-util"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/util" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-util"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/util" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (letfn [(clj-blocks [text]
            (let [fence (apply str (repeat 3 (char 96)))
                  parts (clojure.string/split text (re-pattern fence))]
              (->> parts
                   (map-indexed vector)
                   (filter (fn [[i _]] (odd? i)))
                   (map (fn [[_ seg]] seg))
                   (filter (fn [seg]
                             (= "clojure"
                                (clojure.string/trim (first (clojure.string/split-lines seg))))))
                   (map (fn [seg]
                          (clojure.string/join "\n"
                            (rest (clojure.string/split-lines seg))))))))]
    (doseq [[label path] [["root-README" "../README.md"]
                          ["README" "README.md"]
                          ["REFERENCE" "REFERENCE.md"]]]
      (t/run-check rec (str "gen-readme-examples-" label)
        (fn []
          (if-not (.exists (java.io.File. ^String path))
            (t/is-true true (str label " absent (skipped)"))
            (let [blocks (clj-blocks (slurp path))]
              (doseq [b blocks]
                (binding [*read-eval* false]
                  (read-string (str "[\n" b "\n]"))))
              (t/is-true true (str label " clojure blocks parse cleanly"))))))))
  nil)
