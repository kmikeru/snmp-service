{-# LANGUAGE OverloadedStrings #-}
import Snmp
import Json
import Web.Scotty

import Data.Monoid (mconcat)

main = do
  --x <- queryUptime
  --let x = enc1 ("aaa",3000)
  --x<-query
  --let t=show (getValues x)
  let o = OidInt "1.2.3" 93331
  let encoded = enc2 o
  putStrLn $ enc2 o


{-
main = scotty 3000 $ do
  get "/" $ do
    -- x <- queryUptime
    let x="aaa"
    html $ mconcat ["<h1>",x,"</h1>"]
-}
