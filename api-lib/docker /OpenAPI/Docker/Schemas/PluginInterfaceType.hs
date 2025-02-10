{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.PluginInterfaceType where

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





data PluginInterfaceType = PluginInterfaceType
    {
        capability :: Data.Text.Text,
        prefix :: Data.Text.Text,
        version :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginInterfaceType where
    toJSON PluginInterfaceType {..} = Data.Aeson.object
        ([ "Capability" Data.Aeson..= capability,
           "Prefix" Data.Aeson..= prefix,
           "Version" Data.Aeson..= version
        ]
        )

    toEncoding PluginInterfaceType {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Capability" (Data.Aeson.toEncoding capability) <>
          Data.Aeson.Encoding.pair "Prefix" (Data.Aeson.toEncoding prefix) <>
          Data.Aeson.Encoding.pair "Version" (Data.Aeson.toEncoding version)
        )

instance Data.Aeson.FromJSON PluginInterfaceType where
    parseJSON = Data.Aeson.withObject "PluginInterfaceType" $ \o ->
        PluginInterfaceType
            <$> o Data.Aeson..: "Capability"
            <*> o Data.Aeson..: "Prefix"
            <*> o Data.Aeson..: "Version"