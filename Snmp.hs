{-# LANGUAGE OverloadedStrings #-}
module Snmp where
--import Data.ByteString (ByteString)
--import Control.Exception (bracket, try)

import Network.Snmp.Client
import Network.Protocol.Snmp
--import Data.ASN1.Types
import Data.Word(Word32)

conf1 :: Config
conf1 = (initial Version1) { hostname = "127.0.0.1", community = Community "public" }

--sysUptime = fmap oidFromBS ["1.3.6.1.2.1.25.1.1.0"]
sysUptime = fmap oidFromBS ["1.3.6.1.2.1.25.1.6.0"]

coupla :: Suite -> [Coupla]
coupla (Suite c) = c

getOID :: Coupla -> OID
getOID (Coupla oid value) = oid

getValue :: Coupla -> Value
getValue (Coupla oid value) = value

getTimeTicks :: Value -> Word32
getTimeTicks ( TimeTicks v) = v

getValueStr :: Value -> String
getValueStr ( TimeTicks v) = show v
getValueStr ( Gauge32 v) = show v
getValueStr ( Counter32 v) = show v
getValueStr ( String v) = show v

queryUptime :: IO String
queryUptime = do
  cl1 <- client conf1
  res <- get cl1 sysUptime
  let firstCoupla = head $ coupla res
  let oid = getOID firstCoupla
  let val = getValue firstCoupla
  --let t= getTimeTicks val
  --let s=show t
  let s=getValueStr val
  return ("abc="++s)
