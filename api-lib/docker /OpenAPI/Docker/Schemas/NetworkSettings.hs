{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.NetworkSettings where

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



import OpenAPI.Docker.Schemas.Address
import OpenAPI.Docker.Schemas.EndpointSettings
import OpenAPI.Docker.Schemas.PortMap

newtype NetworkSettingsNetworks = NetworkSettingsNetworks
    (Data.Map.Map Data.Text.Text (EndpointSettings))
    deriving (Show)

instance Data.Aeson.ToJSON NetworkSettingsNetworks where
    toJSON (NetworkSettingsNetworks x) =
        Data.Aeson.toJSON x

    toEncoding (NetworkSettingsNetworks x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NetworkSettingsNetworks where
    parseJSON x =
        NetworkSettingsNetworks <$> Data.Aeson.parseJSON x

data NetworkSettings = NetworkSettings
    {
        bridge :: (Data.Maybe.Maybe (Data.Text.Text)),
        endpointID :: (Data.Maybe.Maybe (Data.Text.Text)),
        gateway :: (Data.Maybe.Maybe (Data.Text.Text)),
        globalIPv6Address :: (Data.Maybe.Maybe (Data.Text.Text)),
        globalIPv6PrefixLen :: (Data.Maybe.Maybe (GHC.Int.Int)),
        hairpinMode :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        iPAddress :: (Data.Maybe.Maybe (Data.Text.Text)),
        iPPrefixLen :: (Data.Maybe.Maybe (GHC.Int.Int)),
        iPv6Gateway :: (Data.Maybe.Maybe (Data.Text.Text)),
        linkLocalIPv6Address :: (Data.Maybe.Maybe (Data.Text.Text)),
        linkLocalIPv6PrefixLen :: (Data.Maybe.Maybe (GHC.Int.Int)),
        macAddress :: (Data.Maybe.Maybe (Data.Text.Text)),
        networks :: (Data.Maybe.Maybe (NetworkSettingsNetworks)),
        ports :: (Data.Maybe.Maybe (PortMap)),
        sandboxID :: (Data.Maybe.Maybe (Data.Text.Text)),
        sandboxKey :: (Data.Maybe.Maybe (Data.Text.Text)),
        secondaryIPAddresses :: (Data.Maybe.Maybe ([ Address ])),
        secondaryIPv6Addresses :: (Data.Maybe.Maybe ([ Address ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NetworkSettings where
    toJSON NetworkSettings {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Bridge" Data.Aeson..= bridge | Just bridge <- [bridge] ]
        ++ [ "EndpointID" Data.Aeson..= endpointID | Just endpointID <- [endpointID] ]
        ++ [ "Gateway" Data.Aeson..= gateway | Just gateway <- [gateway] ]
        ++ [ "GlobalIPv6Address" Data.Aeson..= globalIPv6Address | Just globalIPv6Address <- [globalIPv6Address] ]
        ++ [ "GlobalIPv6PrefixLen" Data.Aeson..= globalIPv6PrefixLen | Just globalIPv6PrefixLen <- [globalIPv6PrefixLen] ]
        ++ [ "HairpinMode" Data.Aeson..= hairpinMode | Just hairpinMode <- [hairpinMode] ]
        ++ [ "IPAddress" Data.Aeson..= iPAddress | Just iPAddress <- [iPAddress] ]
        ++ [ "IPPrefixLen" Data.Aeson..= iPPrefixLen | Just iPPrefixLen <- [iPPrefixLen] ]
        ++ [ "IPv6Gateway" Data.Aeson..= iPv6Gateway | Just iPv6Gateway <- [iPv6Gateway] ]
        ++ [ "LinkLocalIPv6Address" Data.Aeson..= linkLocalIPv6Address | Just linkLocalIPv6Address <- [linkLocalIPv6Address] ]
        ++ [ "LinkLocalIPv6PrefixLen" Data.Aeson..= linkLocalIPv6PrefixLen | Just linkLocalIPv6PrefixLen <- [linkLocalIPv6PrefixLen] ]
        ++ [ "MacAddress" Data.Aeson..= macAddress | Just macAddress <- [macAddress] ]
        ++ [ "Networks" Data.Aeson..= networks | Just networks <- [networks] ]
        ++ [ "Ports" Data.Aeson..= ports | Just ports <- [ports] ]
        ++ [ "SandboxID" Data.Aeson..= sandboxID | Just sandboxID <- [sandboxID] ]
        ++ [ "SandboxKey" Data.Aeson..= sandboxKey | Just sandboxKey <- [sandboxKey] ]
        ++ [ "SecondaryIPAddresses" Data.Aeson..= secondaryIPAddresses | Just secondaryIPAddresses <- [secondaryIPAddresses] ]
        ++ [ "SecondaryIPv6Addresses" Data.Aeson..= secondaryIPv6Addresses | Just secondaryIPv6Addresses <- [secondaryIPv6Addresses] ])

    toEncoding NetworkSettings {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Bridge" . Data.Aeson.toEncoding) bridge <>
          maybe mempty (Data.Aeson.Encoding.pair "EndpointID" . Data.Aeson.toEncoding) endpointID <>
          maybe mempty (Data.Aeson.Encoding.pair "Gateway" . Data.Aeson.toEncoding) gateway <>
          maybe mempty (Data.Aeson.Encoding.pair "GlobalIPv6Address" . Data.Aeson.toEncoding) globalIPv6Address <>
          maybe mempty (Data.Aeson.Encoding.pair "GlobalIPv6PrefixLen" . Data.Aeson.toEncoding) globalIPv6PrefixLen <>
          maybe mempty (Data.Aeson.Encoding.pair "HairpinMode" . Data.Aeson.toEncoding) hairpinMode <>
          maybe mempty (Data.Aeson.Encoding.pair "IPAddress" . Data.Aeson.toEncoding) iPAddress <>
          maybe mempty (Data.Aeson.Encoding.pair "IPPrefixLen" . Data.Aeson.toEncoding) iPPrefixLen <>
          maybe mempty (Data.Aeson.Encoding.pair "IPv6Gateway" . Data.Aeson.toEncoding) iPv6Gateway <>
          maybe mempty (Data.Aeson.Encoding.pair "LinkLocalIPv6Address" . Data.Aeson.toEncoding) linkLocalIPv6Address <>
          maybe mempty (Data.Aeson.Encoding.pair "LinkLocalIPv6PrefixLen" . Data.Aeson.toEncoding) linkLocalIPv6PrefixLen <>
          maybe mempty (Data.Aeson.Encoding.pair "MacAddress" . Data.Aeson.toEncoding) macAddress <>
          maybe mempty (Data.Aeson.Encoding.pair "Networks" . Data.Aeson.toEncoding) networks <>
          maybe mempty (Data.Aeson.Encoding.pair "Ports" . Data.Aeson.toEncoding) ports <>
          maybe mempty (Data.Aeson.Encoding.pair "SandboxID" . Data.Aeson.toEncoding) sandboxID <>
          maybe mempty (Data.Aeson.Encoding.pair "SandboxKey" . Data.Aeson.toEncoding) sandboxKey <>
          maybe mempty (Data.Aeson.Encoding.pair "SecondaryIPAddresses" . Data.Aeson.toEncoding) secondaryIPAddresses <>
          maybe mempty (Data.Aeson.Encoding.pair "SecondaryIPv6Addresses" . Data.Aeson.toEncoding) secondaryIPv6Addresses
        )

instance Data.Aeson.FromJSON NetworkSettings where
    parseJSON = Data.Aeson.withObject "NetworkSettings" $ \o ->
        NetworkSettings
            <$> o Data.Aeson..:? "Bridge"
            <*> o Data.Aeson..:? "EndpointID"
            <*> o Data.Aeson..:? "Gateway"
            <*> o Data.Aeson..:? "GlobalIPv6Address"
            <*> o Data.Aeson..:? "GlobalIPv6PrefixLen"
            <*> o Data.Aeson..:? "HairpinMode"
            <*> o Data.Aeson..:? "IPAddress"
            <*> o Data.Aeson..:? "IPPrefixLen"
            <*> o Data.Aeson..:? "IPv6Gateway"
            <*> o Data.Aeson..:? "LinkLocalIPv6Address"
            <*> o Data.Aeson..:? "LinkLocalIPv6PrefixLen"
            <*> o Data.Aeson..:? "MacAddress"
            <*> o Data.Aeson..:? "Networks"
            <*> o Data.Aeson..:? "Ports"
            <*> o Data.Aeson..:? "SandboxID"
            <*> o Data.Aeson..:? "SandboxKey"
            <*> o Data.Aeson..:? "SecondaryIPAddresses"
            <*> o Data.Aeson..:? "SecondaryIPv6Addresses"