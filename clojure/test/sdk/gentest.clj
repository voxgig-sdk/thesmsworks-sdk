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
            [sdk.entity.message :as e-message]
            [sdk.entity.message_message :as e-message_message]
            [sdk.entity.message_schedule :as e-message_schedule]
            [sdk.entity.one_time_password :as e-one_time_password]
            [sdk.entity.schedule :as e-schedule]
            [sdk.entity.util :as e-util]))

(defn run [rec]
  (t/run-check rec "gen-exists-batch"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/batch sdk nil)) "batch accessor present"))))
  (t/run-check rec "gen-validate-batch"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-batch/load (api/batch client nil) (vs/jm "id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-batch_message"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/batch_message sdk nil)) "batch_message accessor present"))))
  (t/run-check rec "gen-smoke-batch_message"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/batch_message sdk nil)]
             (let [res (e-batch_message/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-batch_message"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-batch_message/create (api/batch_message client nil) (vs/jm "ai" "x" "content" "x" "destinations" "x" "sender" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-credit"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/credit sdk nil)) "credit accessor present"))))
  (t/run-check rec "gen-exists-message"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/message sdk nil)) "message accessor present"))))
  (t/run-check rec "gen-exists-message_message"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/message_message sdk nil)) "message_message accessor present"))))
  (t/run-check rec "gen-smoke-message_message"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/message_message sdk nil)]
             (let [res (e-message_message/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-message_message"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-message_message/load (api/message_message client nil) (vs/jm "id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-message_schedule"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/message_schedule sdk nil)) "message_schedule accessor present"))))
  (t/run-check rec "gen-validate-message_schedule"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-message_schedule/load (api/message_schedule client nil) (vs/jm "id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-one_time_password"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/one_time_password sdk nil)) "one_time_password accessor present"))))
  (t/run-check rec "gen-smoke-one_time_password"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/one_time_password sdk nil)]
             (let [res (e-one_time_password/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-one_time_password"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-one_time_password/load (api/one_time_password client nil) (vs/jm "messageid" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-schedule"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/schedule sdk nil)) "schedule accessor present"))))
  (t/run-check rec "gen-validate-schedule"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-schedule/remove (api/schedule client nil) (vs/jm "id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-util"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/util sdk nil)) "util accessor present"))))
  (t/run-check rec "gen-validate-util"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-util/load (api/util client nil) (vs/jm "errorcode" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
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
  (t/run-check rec "gen-prepare-message_message"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/message_message" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-message_message"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/message_message" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-message_schedule"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/message_schedule" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-message_schedule"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/message_schedule" "method" "GET"))]
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
  (letfn [(fence-pat [] (re-pattern (apply str (repeat 3 (char 96)))))
          (fence-count [text] (count (re-seq (fence-pat) text)))
          (clj-blocks [text]
            (let [parts (clojure.string/split text (fence-pat))]
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
            (let [text (slurp path)]
              ;; A code fence opened but never closed leaves an ODD number of
              ;; fence markers; the split-on-fence then captures the trailing
              ;; prose (everything after the last opener) as if it were a
              ;; clojure block, which can parse cleanly and pass silently. Fail
              ;; on the malformed doc instead. (Count markers directly rather
              ;; than split parts: split drops trailing empty segments, so a
              ;; closing fence at EOF would be miscounted.)
              (t/is-true (even? (fence-count text))
                         (str label " code fences balanced (no unclosed fence)"))
              (let [blocks (clj-blocks text)]
                (doseq [b blocks]
                  (binding [*read-eval* false]
                    (read-string (str "[\n" b "\n]"))))
                (t/is-true true (str label " clojure blocks parse cleanly")))))))))
  nil)
