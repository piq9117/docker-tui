{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Network where

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



import OpenAPI.Docker.Schemas.ConfigReference
import OpenAPI.Docker.Schemas.IPAM
import OpenAPI.Docker.Schemas.NetworkContainer
import OpenAPI.Docker.Schemas.PeerInfo

newtype NetworkContainers = NetworkContainers
    (Data.Map.Map Data.Text.Text (NetworkContainer))
    deriving (Show)

instance Data.Aeson.ToJSON NetworkContainers where
    toJSON (NetworkContainers x) =
        Data.Aeson.toJSON x

    toEncoding (NetworkContainers x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NetworkContainers where
    parseJSON x =
        NetworkContainers <$> Data.Aeson.parseJSON x

newtype NetworkLabels = NetworkLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON NetworkLabels where
    toJSON (NetworkLabels x) =
        Data.Aeson.toJSON x

    toEncoding (NetworkLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NetworkLabels where
    parseJSON x =
        NetworkLabels <$> Data.Aeson.parseJSON x

newtype NetworkOptions = NetworkOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON NetworkOptions where
    toJSON (NetworkOptions x) =
        Data.Aeson.toJSON x

    toEncoding (NetworkOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NetworkOptions where
    parseJSON x =
        NetworkOptions <$> Data.Aeson.parseJSON x

data Network = Network
    {
        attachable :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        configFrom :: (Data.Maybe.Maybe (ConfigReference)),
        configOnly :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        containers :: (Data.Maybe.Maybe (NetworkContainers)),
        created :: (Data.Maybe.Maybe (Data.Text.Text)),
        driver :: (Data.Maybe.Maybe (Data.Text.Text)),
        enableIPv4 :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        enableIPv6 :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        iPAM :: (Data.Maybe.Maybe (IPAM)),
        id :: (Data.Maybe.Maybe (Data.Text.Text)),
        ingress :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        internal :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        labels :: (Data.Maybe.Maybe (NetworkLabels)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        options :: (Data.Maybe.Maybe (NetworkOptions)),
        peers :: (Data.Maybe.Maybe ([ PeerInfo ])),
        scope :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Network where
    toJSON Network {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Attachable" Data.Aeson..= attachable | Just attachable <- [attachable] ]
        ++ [ "ConfigFrom" Data.Aeson..= configFrom | Just configFrom <- [configFrom] ]
        ++ [ "ConfigOnly" Data.Aeson..= configOnly | Just configOnly <- [configOnly] ]
        ++ [ "Containers" Data.Aeson..= containers | Just containers <- [containers] ]
        ++ [ "Created" Data.Aeson..= created | Just created <- [created] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "EnableIPv4" Data.Aeson..= enableIPv4 | Just enableIPv4 <- [enableIPv4] ]
        ++ [ "EnableIPv6" Data.Aeson..= enableIPv6 | Just enableIPv6 <- [enableIPv6] ]
        ++ [ "IPAM" Data.Aeson..= iPAM | Just iPAM <- [iPAM] ]
        ++ [ "Id" Data.Aeson..= id | Just id <- [id] ]
        ++ [ "Ingress" Data.Aeson..= ingress | Just ingress <- [ingress] ]
        ++ [ "Internal" Data.Aeson..= internal | Just internal <- [internal] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ]
        ++ [ "Peers" Data.Aeson..= peers | Just peers <- [peers] ]
        ++ [ "Scope" Data.Aeson..= scope | Just scope <- [scope] ])

    toEncoding Network {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Attachable" . Data.Aeson.toEncoding) attachable <>
          maybe mempty (Data.Aeson.Encoding.pair "ConfigFrom" . Data.Aeson.toEncoding) configFrom <>
          maybe mempty (Data.Aeson.Encoding.pair "ConfigOnly" . Data.Aeson.toEncoding) configOnly <>
          maybe mempty (Data.Aeson.Encoding.pair "Containers" . Data.Aeson.toEncoding) containers <>
          maybe mempty (Data.Aeson.Encoding.pair "Created" . Data.Aeson.toEncoding) created <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "EnableIPv4" . Data.Aeson.toEncoding) enableIPv4 <>
          maybe mempty (Data.Aeson.Encoding.pair "EnableIPv6" . Data.Aeson.toEncoding) enableIPv6 <>
          maybe mempty (Data.Aeson.Encoding.pair "IPAM" . Data.Aeson.toEncoding) iPAM <>
          maybe mempty (Data.Aeson.Encoding.pair "Id" . Data.Aeson.toEncoding) id <>
          maybe mempty (Data.Aeson.Encoding.pair "Ingress" . Data.Aeson.toEncoding) ingress <>
          maybe mempty (Data.Aeson.Encoding.pair "Internal" . Data.Aeson.toEncoding) internal <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options <>
          maybe mempty (Data.Aeson.Encoding.pair "Peers" . Data.Aeson.toEncoding) peers <>
          maybe mempty (Data.Aeson.Encoding.pair "Scope" . Data.Aeson.toEncoding) scope
        )

instance Data.Aeson.FromJSON Network where
    parseJSON = Data.Aeson.withObject "Network" $ \o ->
        Network
            <$> o Data.Aeson..:? "Attachable"
            <*> o Data.Aeson..:? "ConfigFrom"
            <*> o Data.Aeson..:? "ConfigOnly"
            <*> o Data.Aeson..:? "Containers"
            <*> o Data.Aeson..:? "Created"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "EnableIPv4"
            <*> o Data.Aeson..:? "EnableIPv6"
            <*> o Data.Aeson..:? "IPAM"
            <*> o Data.Aeson..:? "Id"
            <*> o Data.Aeson..:? "Ingress"
            <*> o Data.Aeson..:? "Internal"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Options"
            <*> o Data.Aeson..:? "Peers"
            <*> o Data.Aeson..:? "Scope"