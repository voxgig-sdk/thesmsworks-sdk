-- Generated model-driven entity + direct tests.
{-# LANGUAGE ScopedTypeVariables #-}

module SdkGenTests (genTests) where

import Control.Exception (SomeException, try)
import Data.IORef

import VoxgigStruct (Value (..), emptyMap, keysof, ismap, islist, isNoval, clone)
import SdkTypes
import SdkHelpers
import qualified SdkFeatures as F
import qualified SdkClient as C
import qualified TReadmeExamples
import Testutil
import SdkJson (jsonRead)

-- Load an entity fixture (../.sdk/test/entity/<name>/<Name>TestData.json).
loadFixture :: String -> IO Value
loadFixture entName = do
  -- The fixture DIRECTORY is the snake_case entity name (create_result), so a
  -- plain lowercase of the CamelCase entName (createresult) misses the
  -- underscores for multi-word entities. Convert CamelCase -> snake_case.
  let lname = camelToSnake entName
  raw <- readFile ("../.sdk/test/entity/" ++ lname ++ "/" ++ entName ++ "TestData.json")
  jsonRead raw
  where
    toLowerCh ch = if ch >= 'A' && ch <= 'Z' then toEnum (fromEnum ch + 32) else ch
    camelToSnake [] = []
    camelToSnake (c0 : rest) = toLowerCh c0 : go rest
    go [] = []
    go (c : cs)
      | c >= 'A' && c <= 'Z' = '_' : toLowerCh c : go cs
      | otherwise = c : go cs

-- The first new-ref data map for an entity (fixture.new.<entity>.<ref0>).
newRefData :: Value -> String -> IO Value
newRefData fixture entName = do
  newEnts <- getpathS fixture ("new." ++ entName)
  refs <- keysof newEnts
  case refs of
    [] -> emptyMap
    (r0 : _) -> do d <- getp newEnts r0; clone d

genTests :: Counters -> IO ()
genTests c = do
  TReadmeExamples.tests c
  batchInstanceTest c
  batchBasicTest c
  batchDirectTest c
  batch_messageInstanceTest c
  batch_messageBasicTest c
  batch_messageDirectTest c
  creditInstanceTest c
  creditBasicTest c
  creditDirectTest c
  flashInstanceTest c
  flashBasicTest c
  flashDirectTest c
  messageInstanceTest c
  messageBasicTest c
  messageDirectTest c
  one_time_passwordInstanceTest c
  one_time_passwordBasicTest c
  one_time_passwordDirectTest c
  scheduleInstanceTest c
  scheduleBasicTest c
  scheduleDirectTest c
  swaggerInstanceTest c
  swaggerBasicTest c
  swaggerDirectTest c
  utilInstanceTest c
  utilBasicTest c
  utilDirectTest c

batchInstanceTest :: Counters -> IO ()
batchInstanceTest c = runTest c "batch.instance" $ do
  sdk <- C.testSdk0
  ent <- C.batch sdk VNoval
  pure (eName ent == "batch")

batchBasicTest :: Counters -> IO ()
batchBasicTest c = do
  fixture <- loadFixture "Batch"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "batch.load" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.batch sdk VNoval
    entmap <- getp existing "batch"
    ids <- keysof entmap
    case ids of
      [] -> pure True
      (id0 : _) -> do
        m <- jo [("id", VStr id0)]; ctrl <- emptyMap
        loaded <- eLoad ent m ctrl
        ld <- eDataGet loaded
        lid <- getp ld "id"
        pure (ismap ld && vstring lid == id0)

batchDirectTest :: Counters -> IO ()
batchDirectTest c = runTest c "batch.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/batch/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

batch_messageInstanceTest :: Counters -> IO ()
batch_messageInstanceTest c = runTest c "batch_message.instance" $ do
  sdk <- C.testSdk0
  ent <- C.batch_message sdk VNoval
  pure (eName ent == "batch_message")

batch_messageBasicTest :: Counters -> IO ()
batch_messageBasicTest c = do
  fixture <- loadFixture "BatchMessage"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "batch_message.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.batch_message sdk VNoval
    d <- newRefData fixture "batch_message"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cd <- eDataGet created
    -- The create RESULT is a map. Deliberately NOT "and it carries an id":
    -- a create response need not return one. univec's convert, embed and
    -- ephemeral_key all answer {success, data:{...}} with no id, so this
    -- target failed three entity tests the go target passes -- go asserts
    -- only that the result is a map, and that is the assertion the model
    -- actually supports.
    pure (ismap cd)
  runTest c "batch_message.remove" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.batch_message sdk VNoval
    d <- newRefData fixture "batch_message"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cd <- eDataGet created
    cid <- getp cd "id"
    rm <- jo [("id", cid)]; ctrl2 <- emptyMap
    -- `remove` resolves to the entity, marked. It KEEPS the data it held.
    removed <- eRemove ent rm ctrl2
    gone <- readIORef (eDeleted removed)
    rd <- eDataGet removed
    rid <- getp rd "id"
    pure (gone && vstring rid == vstring cid)

batch_messageDirectTest :: Counters -> IO ()
batch_messageDirectTest c = runTest c "batch_message.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/batch_message/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

creditInstanceTest :: Counters -> IO ()
creditInstanceTest c = runTest c "credit.instance" $ do
  sdk <- C.testSdk0
  ent <- C.credit sdk VNoval
  pure (eName ent == "credit")

creditBasicTest :: Counters -> IO ()
creditBasicTest c = do
  fixture <- loadFixture "Credit"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "credit.load" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.credit sdk VNoval
    entmap <- getp existing "credit"
    ids <- keysof entmap
    case ids of
      [] -> pure True
      (id0 : _) -> do
        m <- jo [("id", VStr id0)]; ctrl <- emptyMap
        loaded <- eLoad ent m ctrl
        ld <- eDataGet loaded
        lid <- getp ld "id"
        pure (ismap ld && vstring lid == id0)

creditDirectTest :: Counters -> IO ()
creditDirectTest c = runTest c "credit.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/credit/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

flashInstanceTest :: Counters -> IO ()
flashInstanceTest c = runTest c "flash.instance" $ do
  sdk <- C.testSdk0
  ent <- C.flash sdk VNoval
  pure (eName ent == "flash")

flashBasicTest :: Counters -> IO ()
flashBasicTest c = do
  fixture <- loadFixture "Flash"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  pure ()

flashDirectTest :: Counters -> IO ()
flashDirectTest c = runTest c "flash.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/flash/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

messageInstanceTest :: Counters -> IO ()
messageInstanceTest c = runTest c "message.instance" $ do
  sdk <- C.testSdk0
  ent <- C.message sdk VNoval
  pure (eName ent == "message")

messageBasicTest :: Counters -> IO ()
messageBasicTest c = do
  fixture <- loadFixture "Message"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "message.load" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.message sdk VNoval
    entmap <- getp existing "message"
    ids <- keysof entmap
    case ids of
      [] -> pure True
      (id0 : _) -> do
        m <- jo [("id", VStr id0)]; ctrl <- emptyMap
        loaded <- eLoad ent m ctrl
        ld <- eDataGet loaded
        lid <- getp ld "id"
        pure (ismap ld && vstring lid == id0)
  runTest c "message.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.message sdk VNoval
    d <- newRefData fixture "message"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cd <- eDataGet created
    -- The create RESULT is a map. Deliberately NOT "and it carries an id":
    -- a create response need not return one. univec's convert, embed and
    -- ephemeral_key all answer {success, data:{...}} with no id, so this
    -- target failed three entity tests the go target passes -- go asserts
    -- only that the result is a map, and that is the assertion the model
    -- actually supports.
    pure (ismap cd)
  runTest c "message.remove" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.message sdk VNoval
    d <- newRefData fixture "message"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cd <- eDataGet created
    cid <- getp cd "id"
    rm <- jo [("id", cid)]; ctrl2 <- emptyMap
    -- `remove` resolves to the entity, marked. It KEEPS the data it held.
    removed <- eRemove ent rm ctrl2
    gone <- readIORef (eDeleted removed)
    rd <- eDataGet removed
    rid <- getp rd "id"
    pure (gone && vstring rid == vstring cid)

messageDirectTest :: Counters -> IO ()
messageDirectTest c = runTest c "message.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/message/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

one_time_passwordInstanceTest :: Counters -> IO ()
one_time_passwordInstanceTest c = runTest c "one_time_password.instance" $ do
  sdk <- C.testSdk0
  ent <- C.one_time_password sdk VNoval
  pure (eName ent == "one_time_password")

one_time_passwordBasicTest :: Counters -> IO ()
one_time_passwordBasicTest c = do
  fixture <- loadFixture "OneTimePassword"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "one_time_password.load" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.one_time_password sdk VNoval
    entmap <- getp existing "one_time_password"
    ids <- keysof entmap
    case ids of
      [] -> pure True
      (id0 : _) -> do
        m <- jo [("id", VStr id0)]; ctrl <- emptyMap
        loaded <- eLoad ent m ctrl
        ld <- eDataGet loaded
        lid <- getp ld "id"
        pure (ismap ld && vstring lid == id0)
  runTest c "one_time_password.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.one_time_password sdk VNoval
    d <- newRefData fixture "one_time_password"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cd <- eDataGet created
    -- The create RESULT is a map. Deliberately NOT "and it carries an id":
    -- a create response need not return one. univec's convert, embed and
    -- ephemeral_key all answer {success, data:{...}} with no id, so this
    -- target failed three entity tests the go target passes -- go asserts
    -- only that the result is a map, and that is the assertion the model
    -- actually supports.
    pure (ismap cd)

one_time_passwordDirectTest :: Counters -> IO ()
one_time_passwordDirectTest c = runTest c "one_time_password.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/one_time_password/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

scheduleInstanceTest :: Counters -> IO ()
scheduleInstanceTest c = runTest c "schedule.instance" $ do
  sdk <- C.testSdk0
  ent <- C.schedule sdk VNoval
  pure (eName ent == "schedule")

scheduleBasicTest :: Counters -> IO ()
scheduleBasicTest c = do
  fixture <- loadFixture "Schedule"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  pure ()

scheduleDirectTest :: Counters -> IO ()
scheduleDirectTest c = runTest c "schedule.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/schedule/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

swaggerInstanceTest :: Counters -> IO ()
swaggerInstanceTest c = runTest c "swagger.instance" $ do
  sdk <- C.testSdk0
  ent <- C.swagger sdk VNoval
  pure (eName ent == "swagger")

swaggerBasicTest :: Counters -> IO ()
swaggerBasicTest c = do
  fixture <- loadFixture "Swagger"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  pure ()

swaggerDirectTest :: Counters -> IO ()
swaggerDirectTest c = runTest c "swagger.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/swagger/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

utilInstanceTest :: Counters -> IO ()
utilInstanceTest c = runTest c "util.instance" $ do
  sdk <- C.testSdk0
  ent <- C.util sdk VNoval
  pure (eName ent == "util")

utilBasicTest :: Counters -> IO ()
utilBasicTest c = do
  fixture <- loadFixture "Util"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "util.load" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.util sdk VNoval
    entmap <- getp existing "util"
    ids <- keysof entmap
    case ids of
      [] -> pure True
      (id0 : _) -> do
        m <- jo [("id", VStr id0)]; ctrl <- emptyMap
        loaded <- eLoad ent m ctrl
        ld <- eDataGet loaded
        lid <- getp ld "id"
        pure (ismap ld && vstring lid == id0)

utilDirectTest :: Counters -> IO ()
utilDirectTest c = runTest c "util.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/util/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)
