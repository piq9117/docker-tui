{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.PluginsInfo where

import qualified Control.Applicative
import qualified Control.Exception
import qualified Control.Monad
import qualified Control.Monad.IO.Class
import qualified Data.Aeson
import qualified Data.Aeson.Encoding
import qualified Data.Aeson.Types
import qualified Data.Attoparsec.ByteString
import qualified Data.ByteString
import qualified Data.List
import qualified Data.List.NonEmpty
import qualified Data.Map
import qualified Data.Maybe
import qualified Data.Text
import qualified Data.Text.Encoding
import qualified Data.Time
import qualified GHC.Float
import qualified GHC.Int
import qualified GHC.Records
import qualified GHC.Types
import qualified Network.HTTP.Types
import qualified Network.Wai
import qualified Web.HttpApiData





data PluginsInfo = PluginsInfo
    {
        authorization :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        log :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        network :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        volume :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginsInfo where
    toJSON PluginsInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Authorization" Data.Aeson..= authorization | Just authorization <- [authorization] ]
        ++ [ "Log" Data.Aeson..= log | Just log <- [log] ]
        ++ [ "Network" Data.Aeson..= network | Just network <- [network] ]
        ++ [ "Volume" Data.Aeson..= volume | Just volume <- [volume] ])

    toEncoding PluginsInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Authorization" . Data.Aeson.toEncoding) authorization <>
          maybe mempty (Data.Aeson.Encoding.pair "Log" . Data.Aeson.toEncoding) log <>
          maybe mempty (Data.Aeson.Encoding.pair "Network" . Data.Aeson.toEncoding) network <>
          maybe mempty (Data.Aeson.Encoding.pair "Volume" . Data.Aeson.toEncoding) volume
        )

instance Data.Aeson.FromJSON PluginsInfo where
    parseJSON = Data.Aeson.withObject "PluginsInfo" $ \o ->
        PluginsInfo
            <$> o Data.Aeson..:? "Authorization"
            <*> o Data.Aeson..:? "Log"
            <*> o Data.Aeson..:? "Network"
            <*> o Data.Aeson..:? "Volume"