{-# LANGUAGE OverloadedStrings #-}
module Json where
import Data.Aeson
import GHC.Exts    -- (fromList)
import qualified Data.Text.Lazy.IO as T
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.Encoding as T

val :: Value
val = Object $ fromList [
  ("numbers", Array $ fromList [Number 1, Number 2, Number 3]),
  ("boolean", Bool True) ]

enc = T.unpack . T.decodeUtf8 .  encode $ val
