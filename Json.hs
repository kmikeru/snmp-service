{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Json where
import Data.Aeson
import GHC.Exts    -- (fromList)
import GHC.Generics
import qualified Data.Text.Lazy.IO as T
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.Encoding as T
import qualified Data.Text.Encoding as T1
import qualified Data.Text as T1
import qualified Network.Snmp.Client as S

{- val :: Value
val = Object $ fromList [
  ("numbers", Array $ fromList [Number 1, Number 2, Number 3]),
  ("boolean", Bool True) ]

enc = T.unpack . T.decodeUtf8 .  encode $ val  -}
data OidInt = OidInt { oid :: String , value :: Integer} deriving (Show, Generic)
instance ToJSON OidInt

enc2 x = T.unpack ( T.decodeUtf8 ( encode x))

v1 (s,v) = Object $ fromList [   ("oid", String s),   ("value",  Number v) ]
--enc1 (s,v) = T.unpack . T.decodeUtf8 . encode $ v1 (s,v)

{- snmpToJSON::S.Value -> Value
snmpToJSON (S.String v) =
  object ["value" .= String v1 ]
  where v1=T1.unpack . T1.decodeUtf8 v -}
