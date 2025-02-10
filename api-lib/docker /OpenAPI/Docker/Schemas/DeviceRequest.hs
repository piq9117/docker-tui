{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.DeviceRequest where

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





newtype DeviceRequestOptions = DeviceRequestOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON DeviceRequestOptions where
    toJSON (DeviceRequestOptions x) =
        Data.Aeson.toJSON x

    toEncoding (DeviceRequestOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON DeviceRequestOptions where
    parseJSON x =
        DeviceRequestOptions <$> Data.Aeson.parseJSON x

data DeviceRequest = DeviceRequest
    {
        capabilities :: (Data.Maybe.Maybe ([ [ Data.Text.Text ] ])),
        count :: (Data.Maybe.Maybe (GHC.Int.Int)),
        deviceIDs :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        driver :: (Data.Maybe.Maybe (Data.Text.Text)),
        options :: (Data.Maybe.Maybe (DeviceRequestOptions))
    }
    deriving (Show)

instance Data.Aeson.ToJSON DeviceRequest where
    toJSON DeviceRequest {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Capabilities" Data.Aeson..= capabilities | Just capabilities <- [capabilities] ]
        ++ [ "Count" Data.Aeson..= count | Just count <- [count] ]
        ++ [ "DeviceIDs" Data.Aeson..= deviceIDs | Just deviceIDs <- [deviceIDs] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ])

    toEncoding DeviceRequest {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Capabilities" . Data.Aeson.toEncoding) capabilities <>
          maybe mempty (Data.Aeson.Encoding.pair "Count" . Data.Aeson.toEncoding) count <>
          maybe mempty (Data.Aeson.Encoding.pair "DeviceIDs" . Data.Aeson.toEncoding) deviceIDs <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options
        )

instance Data.Aeson.FromJSON DeviceRequest where
    parseJSON = Data.Aeson.withObject "DeviceRequest" $ \o ->
        DeviceRequest
            <$> o Data.Aeson..:? "Capabilities"
            <*> o Data.Aeson..:? "Count"
            <*> o Data.Aeson..:? "DeviceIDs"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "Options"