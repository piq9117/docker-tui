{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ThrottleDevice where

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





data ThrottleDevice = ThrottleDevice
    {
        path :: (Data.Maybe.Maybe (Data.Text.Text)),
        rate :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ThrottleDevice where
    toJSON ThrottleDevice {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Path" Data.Aeson..= path | Just path <- [path] ]
        ++ [ "Rate" Data.Aeson..= rate | Just rate <- [rate] ])

    toEncoding ThrottleDevice {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Path" . Data.Aeson.toEncoding) path <>
          maybe mempty (Data.Aeson.Encoding.pair "Rate" . Data.Aeson.toEncoding) rate
        )

instance Data.Aeson.FromJSON ThrottleDevice where
    parseJSON = Data.Aeson.withObject "ThrottleDevice" $ \o ->
        ThrottleDevice
            <$> o Data.Aeson..:? "Path"
            <*> o Data.Aeson..:? "Rate"