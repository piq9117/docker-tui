{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.EndpointIPAMConfig where

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





data EndpointIPAMConfig = EndpointIPAMConfig
    {
        iPv4Address :: (Data.Maybe.Maybe (Data.Text.Text)),
        iPv6Address :: (Data.Maybe.Maybe (Data.Text.Text)),
        linkLocalIPs :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON EndpointIPAMConfig where
    toJSON EndpointIPAMConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "IPv4Address" Data.Aeson..= iPv4Address | Just iPv4Address <- [iPv4Address] ]
        ++ [ "IPv6Address" Data.Aeson..= iPv6Address | Just iPv6Address <- [iPv6Address] ]
        ++ [ "LinkLocalIPs" Data.Aeson..= linkLocalIPs | Just linkLocalIPs <- [linkLocalIPs] ])

    toEncoding EndpointIPAMConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "IPv4Address" . Data.Aeson.toEncoding) iPv4Address <>
          maybe mempty (Data.Aeson.Encoding.pair "IPv6Address" . Data.Aeson.toEncoding) iPv6Address <>
          maybe mempty (Data.Aeson.Encoding.pair "LinkLocalIPs" . Data.Aeson.toEncoding) linkLocalIPs
        )

instance Data.Aeson.FromJSON EndpointIPAMConfig where
    parseJSON = Data.Aeson.withObject "EndpointIPAMConfig" $ \o ->
        EndpointIPAMConfig
            <$> o Data.Aeson..:? "IPv4Address"
            <*> o Data.Aeson..:? "IPv6Address"
            <*> o Data.Aeson..:? "LinkLocalIPs"