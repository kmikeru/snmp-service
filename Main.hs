{-# LANGUAGE OverloadedStrings #-}
import Snmp
import Web.Scotty

import Data.Monoid (mconcat)

main = do
  x <- queryUptime
  putStrLn x


{-
main = scotty 3000 $ do
  get "/" $ do
    -- x <- queryUptime
    let x="aaa"
    html $ mconcat ["<h1>",x,"</h1>"]
-}
