{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.NetworkCreate where

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
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.IPAM
import OpenAPI.Docker.Schemas.NetworkCreateResponse

import OpenAPI.Docker.Response

data NetworkCreateRequestBody = NetworkCreateRequestBody
    {
        attachable :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        configFrom :: (Data.Maybe.Maybe (ConfigReference)),
        configOnly :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        driver :: (Data.Maybe.Maybe (Data.Text.Text)),
        enableIPv4 :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        enableIPv6 :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        iPAM :: (Data.Maybe.Maybe (IPAM)),
        ingress :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        internal :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        labels :: (Data.Maybe.Maybe (NetworkCreateRequestBodyLabels)),
        name :: Data.Text.Text,
        options :: (Data.Maybe.Maybe (NetworkCreateRequestBodyOptions)),
        scope :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NetworkCreateRequestBody where
    toJSON NetworkCreateRequestBody {..} = Data.Aeson.object
        ([ "Name" Data.Aeson..= name
        ]
        ++ [ "Attachable" Data.Aeson..= attachable | Just attachable <- [attachable] ]
        ++ [ "ConfigFrom" Data.Aeson..= configFrom | Just configFrom <- [configFrom] ]
        ++ [ "ConfigOnly" Data.Aeson..= configOnly | Just configOnly <- [configOnly] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "EnableIPv4" Data.Aeson..= enableIPv4 | Just enableIPv4 <- [enableIPv4] ]
        ++ [ "EnableIPv6" Data.Aeson..= enableIPv6 | Just enableIPv6 <- [enableIPv6] ]
        ++ [ "IPAM" Data.Aeson..= iPAM | Just iPAM <- [iPAM] ]
        ++ [ "Ingress" Data.Aeson..= ingress | Just ingress <- [ingress] ]
        ++ [ "Internal" Data.Aeson..= internal | Just internal <- [internal] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ]
        ++ [ "Scope" Data.Aeson..= scope | Just scope <- [scope] ])

    toEncoding NetworkCreateRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Attachable" . Data.Aeson.toEncoding) attachable <>
          maybe mempty (Data.Aeson.Encoding.pair "ConfigFrom" . Data.Aeson.toEncoding) configFrom <>
          maybe mempty (Data.Aeson.Encoding.pair "ConfigOnly" . Data.Aeson.toEncoding) configOnly <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "EnableIPv4" . Data.Aeson.toEncoding) enableIPv4 <>
          maybe mempty (Data.Aeson.Encoding.pair "EnableIPv6" . Data.Aeson.toEncoding) enableIPv6 <>
          maybe mempty (Data.Aeson.Encoding.pair "IPAM" . Data.Aeson.toEncoding) iPAM <>
          maybe mempty (Data.Aeson.Encoding.pair "Ingress" . Data.Aeson.toEncoding) ingress <>
          maybe mempty (Data.Aeson.Encoding.pair "Internal" . Data.Aeson.toEncoding) internal <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name) <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options <>
          maybe mempty (Data.Aeson.Encoding.pair "Scope" . Data.Aeson.toEncoding) scope
        )

instance Data.Aeson.FromJSON NetworkCreateRequestBody where
    parseJSON = Data.Aeson.withObject "NetworkCreateRequestBody" $ \o ->
        NetworkCreateRequestBody
            <$> o Data.Aeson..:? "Attachable"
            <*> o Data.Aeson..:? "ConfigFrom"
            <*> o Data.Aeson..:? "ConfigOnly"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "EnableIPv4"
            <*> o Data.Aeson..:? "EnableIPv6"
            <*> o Data.Aeson..:? "IPAM"
            <*> o Data.Aeson..:? "Ingress"
            <*> o Data.Aeson..:? "Internal"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..: "Name"
            <*> o Data.Aeson..:? "Options"
            <*> o Data.Aeson..:? "Scope"

newtype NetworkCreateRequestBodyLabels = NetworkCreateRequestBodyLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON NetworkCreateRequestBodyLabels where
    toJSON (NetworkCreateRequestBodyLabels x) =
        Data.Aeson.toJSON x

    toEncoding (NetworkCreateRequestBodyLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NetworkCreateRequestBodyLabels where
    parseJSON x =
        NetworkCreateRequestBodyLabels <$> Data.Aeson.parseJSON x

newtype NetworkCreateRequestBodyOptions = NetworkCreateRequestBodyOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON NetworkCreateRequestBodyOptions where
    toJSON (NetworkCreateRequestBodyOptions x) =
        Data.Aeson.toJSON x

    toEncoding (NetworkCreateRequestBodyOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NetworkCreateRequestBodyOptions where
    parseJSON x =
        NetworkCreateRequestBodyOptions <$> Data.Aeson.parseJSON x

data NetworkCreateResponse
    = NetworkCreateResponse201 NetworkCreateResponse
    | NetworkCreateResponse400 ErrorResponse
    | NetworkCreateResponse403 ErrorResponse
    | NetworkCreateResponse404 ErrorResponse
    | NetworkCreateResponse500 ErrorResponse
    deriving (Show)

instance ToResponse NetworkCreateResponse where
    toResponse (NetworkCreateResponse201 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status201 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkCreateResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkCreateResponse403 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status403 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkCreateResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkCreateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" NetworkCreateResponse Network.HTTP.Types.Status where
    getField (NetworkCreateResponse201 {}) = Network.HTTP.Types.status201
    getField (NetworkCreateResponse400 {}) = Network.HTTP.Types.status400
    getField (NetworkCreateResponse403 {}) = Network.HTTP.Types.status403
    getField (NetworkCreateResponse404 {}) = Network.HTTP.Types.status404
    getField (NetworkCreateResponse500 {}) = Network.HTTP.Types.status500