{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Snmp where
import qualified Data.ByteString.Char8 as C
--import Control.Exception (bracket, try)
import Debug.Trace
import Data.List
import Network.Snmp.Client
import Network.Protocol.Snmp

conf1 :: String -> Config
conf1 ip = (initial Version1) { hostname = ip, community = Community "public" }

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

-- ip oid
query :: String -> String -> IO [Coupla]
query ip oidstr= do
  cl1 <- client (conf1 ip)
  res <- get cl1 [(oidFromBS $ C.pack oidstr)]
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
