{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.NodeDescription where

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



import OpenAPI.Docker.Schemas.EngineDescription
import OpenAPI.Docker.Schemas.Platform
import OpenAPI.Docker.Schemas.ResourceObject
import OpenAPI.Docker.Schemas.TLSInfo

data NodeDescription = NodeDescription
    {
        engine :: (Data.Maybe.Maybe (EngineDescription)),
        hostname :: (Data.Maybe.Maybe (Data.Text.Text)),
        platform :: (Data.Maybe.Maybe (Platform)),
        resources :: (Data.Maybe.Maybe (ResourceObject)),
        tLSInfo :: (Data.Maybe.Maybe (TLSInfo))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NodeDescription where
    toJSON NodeDescription {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Engine" Data.Aeson..= engine | Just engine <- [engine] ]
        ++ [ "Hostname" Data.Aeson..= hostname | Just hostname <- [hostname] ]
        ++ [ "Platform" Data.Aeson..= platform | Just platform <- [platform] ]
        ++ [ "Resources" Data.Aeson..= resources | Just resources <- [resources] ]
        ++ [ "TLSInfo" Data.Aeson..= tLSInfo | Just tLSInfo <- [tLSInfo] ])

    toEncoding NodeDescription {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Engine" . Data.Aeson.toEncoding) engine <>
          maybe mempty (Data.Aeson.Encoding.pair "Hostname" . Data.Aeson.toEncoding) hostname <>
          maybe mempty (Data.Aeson.Encoding.pair "Platform" . Data.Aeson.toEncoding) platform <>
          maybe mempty (Data.Aeson.Encoding.pair "Resources" . Data.Aeson.toEncoding) resources <>
          maybe mempty (Data.Aeson.Encoding.pair "TLSInfo" . Data.Aeson.toEncoding) tLSInfo
        )

instance Data.Aeson.FromJSON NodeDescription where
    parseJSON = Data.Aeson.withObject "NodeDescription" $ \o ->
        NodeDescription
            <$> o Data.Aeson..:? "Engine"
            <*> o Data.Aeson..:? "Hostname"
            <*> o Data.Aeson..:? "Platform"
            <*> o Data.Aeson..:? "Resources"
            <*> o Data.Aeson..:? "TLSInfo"