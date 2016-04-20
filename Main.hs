{-# LANGUAGE OverloadedStrings #-}
import Snmp
import Text.JSON
import Text.Show
import Json
import Web.Scotty
--import Web.Scotty.Internal.Types (ActionT)
import Data.Monoid (mconcat)

main = scotty 3000 $ do
  get "/:oid" $ do
    oidp <- param "oid" :: ActionM String
    x<-liftAndCatchIO $ query oidp
    let t=getPairs x
    let v = OidInts $ map (uncurry OidInt) t
    json v
  --print $ enc v

{-
main = scotty 3000 $ do

    -- x <- queryUptime
    let x="aaa"
    html $ mconcat ["<h1>",x,"</h1>"]

-}
