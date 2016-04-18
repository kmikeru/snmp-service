{-# LANGUAGE OverloadedStrings #-}
module Snmp where
--import Data.ByteString (ByteString)
--import Control.Exception (bracket, try)
import Debug.Trace
import Data.List
import Network.Snmp.Client
import Network.Protocol.Snmp
--import Data.Word(Word32)


conf1 :: Config
conf1 = (initial Version1) { hostname = "127.0.0.1", community = Community "public" }

uptime = "1.3.6.1.2.1.25.1.1.0"
sysname="1.3.6.1.2.1.1.1.0"
gauge="1.3.6.1.2.1.25.1.6.0"
--sysUptime = fmap oidFromBS ["1.3.6.1.2.1.25.1.1.0"]
oids = fmap oidFromBS [uptime,gauge]

coupla :: Suite -> [Coupla]
coupla (Suite c) = c

getOID :: Coupla -> OID
getOID (Coupla oid value) = oid

getValue :: Coupla -> Value
getValue (Coupla oid value) = value

--getTimeTicks :: Value -> Word32
--getTimeTicks ( TimeTicks v) = v

{- getValueStr :: Value -> String
getValueStr ( TimeTicks v) = show v
getValueStr ( Gauge32 v) = show v
getValueStr ( Counter32 v) = show v
getValueStr ( String v) = show v -}

getIntValue :: Value -> Integer
getIntValue (TimeTicks v) = toInteger v
getIntValue (Gauge32 v) = toInteger v
getIntValue (Counter32 v) = toInteger v
getIntValue (Integer v) = toInteger v

query :: IO [Coupla]
query = do
  cl1 <- client conf1
  res <- get cl1 oids
  let c = coupla res
  --traceIO $ show c
  --let x=map getValue c
  --traceIO $ show x
  return c

getValues :: [Coupla]  -> [Integer]
getValues x = map ( getIntValue . getValue)  x

couplaJSON :: Coupla -> String
couplaJSON (Coupla o v) =
  --let oid = getOID x
  --enc1 ("aaa", 3000)
  "aaaa"

--getJSON :: [Coupla] -> (String, String)
--getJSON x=
