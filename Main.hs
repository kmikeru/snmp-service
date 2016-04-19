{-# LANGUAGE OverloadedStrings #-}
import Snmp
import Text.JSON
import Text.Show
import Json
--import Web.Scotty
--import Data.Monoid (mconcat)

main = do
  x<-query
  let t=getPairs x
  let v = OidInts $ map (uncurry OidInt) t
  print $ enc v

{-
main = scotty 3000 $ do
  get "/" $ do
    -- x <- queryUptime
    let x="aaa"
    html $ mconcat ["<h1>",x,"</h1>"]
-}
