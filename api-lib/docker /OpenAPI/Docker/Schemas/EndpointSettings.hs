{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.EndpointSettings where

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



import OpenAPI.Docker.Schemas.EndpointIPAMConfig

newtype EndpointSettingsDriverOpts = EndpointSettingsDriverOpts
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON EndpointSettingsDriverOpts where
    toJSON (EndpointSettingsDriverOpts x) =
        Data.Aeson.toJSON x

    toEncoding (EndpointSettingsDriverOpts x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON EndpointSettingsDriverOpts where
    parseJSON x =
        EndpointSettingsDriverOpts <$> Data.Aeson.parseJSON x

data EndpointSettings = EndpointSettings
    {
        aliases :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        dNSNames :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        driverOpts :: (Data.Maybe.Maybe (EndpointSettingsDriverOpts)),
        endpointID :: (Data.Maybe.Maybe (Data.Text.Text)),
        gateway :: (Data.Maybe.Maybe (Data.Text.Text)),
        globalIPv6Address :: (Data.Maybe.Maybe (Data.Text.Text)),
        globalIPv6PrefixLen :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        iPAMConfig :: (Data.Maybe.Maybe (EndpointIPAMConfig)),
        iPAddress :: (Data.Maybe.Maybe (Data.Text.Text)),
        iPPrefixLen :: (Data.Maybe.Maybe (GHC.Int.Int)),
        iPv6Gateway :: (Data.Maybe.Maybe (Data.Text.Text)),
        links :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        macAddress :: (Data.Maybe.Maybe (Data.Text.Text)),
        networkID :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON EndpointSettings where
    toJSON EndpointSettings {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Aliases" Data.Aeson..= aliases | Just aliases <- [aliases] ]
        ++ [ "DNSNames" Data.Aeson..= dNSNames | Just dNSNames <- [dNSNames] ]
        ++ [ "DriverOpts" Data.Aeson..= driverOpts | Just driverOpts <- [driverOpts] ]
        ++ [ "EndpointID" Data.Aeson..= endpointID | Just endpointID <- [endpointID] ]
        ++ [ "Gateway" Data.Aeson..= gateway | Just gateway <- [gateway] ]
        ++ [ "GlobalIPv6Address" Data.Aeson..= globalIPv6Address | Just globalIPv6Address <- [globalIPv6Address] ]
        ++ [ "GlobalIPv6PrefixLen" Data.Aeson..= globalIPv6PrefixLen | Just globalIPv6PrefixLen <- [globalIPv6PrefixLen] ]
        ++ [ "IPAMConfig" Data.Aeson..= iPAMConfig | Just iPAMConfig <- [iPAMConfig] ]
        ++ [ "IPAddress" Data.Aeson..= iPAddress | Just iPAddress <- [iPAddress] ]
        ++ [ "IPPrefixLen" Data.Aeson..= iPPrefixLen | Just iPPrefixLen <- [iPPrefixLen] ]
        ++ [ "IPv6Gateway" Data.Aeson..= iPv6Gateway | Just iPv6Gateway <- [iPv6Gateway] ]
        ++ [ "Links" Data.Aeson..= links | Just links <- [links] ]
        ++ [ "MacAddress" Data.Aeson..= macAddress | Just macAddress <- [macAddress] ]
        ++ [ "NetworkID" Data.Aeson..= networkID | Just networkID <- [networkID] ])

    toEncoding EndpointSettings {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Aliases" . Data.Aeson.toEncoding) aliases <>
          maybe mempty (Data.Aeson.Encoding.pair "DNSNames" . Data.Aeson.toEncoding) dNSNames <>
          maybe mempty (Data.Aeson.Encoding.pair "DriverOpts" . Data.Aeson.toEncoding) driverOpts <>
          maybe mempty (Data.Aeson.Encoding.pair "EndpointID" . Data.Aeson.toEncoding) endpointID <>
          maybe mempty (Data.Aeson.Encoding.pair "Gateway" . Data.Aeson.toEncoding) gateway <>
          maybe mempty (Data.Aeson.Encoding.pair "GlobalIPv6Address" . Data.Aeson.toEncoding) globalIPv6Address <>
          maybe mempty (Data.Aeson.Encoding.pair "GlobalIPv6PrefixLen" . Data.Aeson.toEncoding) globalIPv6PrefixLen <>
          maybe mempty (Data.Aeson.Encoding.pair "IPAMConfig" . Data.Aeson.toEncoding) iPAMConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "IPAddress" . Data.Aeson.toEncoding) iPAddress <>
          maybe mempty (Data.Aeson.Encoding.pair "IPPrefixLen" . Data.Aeson.toEncoding) iPPrefixLen <>
          maybe mempty (Data.Aeson.Encoding.pair "IPv6Gateway" . Data.Aeson.toEncoding) iPv6Gateway <>
          maybe mempty (Data.Aeson.Encoding.pair "Links" . Data.Aeson.toEncoding) links <>
          maybe mempty (Data.Aeson.Encoding.pair "MacAddress" . Data.Aeson.toEncoding) macAddress <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkID" . Data.Aeson.toEncoding) networkID
        )

instance Data.Aeson.FromJSON EndpointSettings where
    parseJSON = Data.Aeson.withObject "EndpointSettings" $ \o ->
        EndpointSettings
            <$> o Data.Aeson..:? "Aliases"
            <*> o Data.Aeson..:? "DNSNames"
            <*> o Data.Aeson..:? "DriverOpts"
            <*> o Data.Aeson..:? "EndpointID"
            <*> o Data.Aeson..:? "Gateway"
            <*> o Data.Aeson..:? "GlobalIPv6Address"
            <*> o Data.Aeson..:? "GlobalIPv6PrefixLen"
            <*> o Data.Aeson..:? "IPAMConfig"
            <*> o Data.Aeson..:? "IPAddress"
            <*> o Data.Aeson..:? "IPPrefixLen"
            <*> o Data.Aeson..:? "IPv6Gateway"
            <*> o Data.Aeson..:? "Links"
            <*> o Data.Aeson..:? "MacAddress"
            <*> o Data.Aeson..:? "NetworkID"