{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Json where
import Data.Aeson
import GHC.Generics
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.Encoding as T

data OidInt = OidInt { oid :: String , value :: Integer} deriving (Show, Generic)
instance ToJSON OidInt

data OidInts=OidInts [OidInt] deriving (Show, Generic)
instance ToJSON OidInts

enc x = T.unpack ( T.decodeUtf8 ( encode x))
