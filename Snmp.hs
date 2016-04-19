{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Snmp where
--import Data.ByteString (ByteString)
--import Control.Exception (bracket, try)
import Debug.Trace
import Data.List
import Network.Snmp.Client
import Network.Protocol.Snmp

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

formatOID :: OID ->String
formatOID x = intercalate "." (map show x)

getValue :: Coupla -> Value
getValue (Coupla oid value) = value

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
getValues  = map ( getIntValue . getValue)

getPair :: Coupla -> (String,Integer)
getPair c = (formatOID $ getOID c , getIntValue $ getValue c)

getPairs :: [Coupla] -> [(String,Integer)]
getPairs = map getPair
