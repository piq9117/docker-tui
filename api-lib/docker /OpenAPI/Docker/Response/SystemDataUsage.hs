{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SystemDataUsage where

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

import OpenAPI.Docker.Schemas.BuildCache
import OpenAPI.Docker.Schemas.ContainerSummary
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.ImageSummary
import OpenAPI.Docker.Schemas.Volume

import OpenAPI.Docker.Response

data SystemDataUsageResponseBody200 = SystemDataUsageResponseBody200
    {
        buildCache :: (Data.Maybe.Maybe ([ BuildCache ])),
        containers :: (Data.Maybe.Maybe ([ ContainerSummary ])),
        images :: (Data.Maybe.Maybe ([ ImageSummary ])),
        layersSize :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        volumes :: (Data.Maybe.Maybe ([ Volume ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemDataUsageResponseBody200 where
    toJSON SystemDataUsageResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "BuildCache" Data.Aeson..= buildCache | Just buildCache <- [buildCache] ]
        ++ [ "Containers" Data.Aeson..= containers | Just containers <- [containers] ]
        ++ [ "Images" Data.Aeson..= images | Just images <- [images] ]
        ++ [ "LayersSize" Data.Aeson..= layersSize | Just layersSize <- [layersSize] ]
        ++ [ "Volumes" Data.Aeson..= volumes | Just volumes <- [volumes] ])

    toEncoding SystemDataUsageResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "BuildCache" . Data.Aeson.toEncoding) buildCache <>
          maybe mempty (Data.Aeson.Encoding.pair "Containers" . Data.Aeson.toEncoding) containers <>
          maybe mempty (Data.Aeson.Encoding.pair "Images" . Data.Aeson.toEncoding) images <>
          maybe mempty (Data.Aeson.Encoding.pair "LayersSize" . Data.Aeson.toEncoding) layersSize <>
          maybe mempty (Data.Aeson.Encoding.pair "Volumes" . Data.Aeson.toEncoding) volumes
        )

instance Data.Aeson.FromJSON SystemDataUsageResponseBody200 where
    parseJSON = Data.Aeson.withObject "SystemDataUsageResponseBody200" $ \o ->
        SystemDataUsageResponseBody200
            <$> o Data.Aeson..:? "BuildCache"
            <*> o Data.Aeson..:? "Containers"
            <*> o Data.Aeson..:? "Images"
            <*> o Data.Aeson..:? "LayersSize"
            <*> o Data.Aeson..:? "Volumes"

data SystemDataUsageResponseBody200 = SystemDataUsageResponseBody200
    {
        buildCache :: (Data.Maybe.Maybe ([ BuildCache ])),
        containers :: (Data.Maybe.Maybe ([ ContainerSummary ])),
        images :: (Data.Maybe.Maybe ([ ImageSummary ])),
        layersSize :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        volumes :: (Data.Maybe.Maybe ([ Volume ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemDataUsageResponseBody200 where
    toJSON SystemDataUsageResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "BuildCache" Data.Aeson..= buildCache | Just buildCache <- [buildCache] ]
        ++ [ "Containers" Data.Aeson..= containers | Just containers <- [containers] ]
        ++ [ "Images" Data.Aeson..= images | Just images <- [images] ]
        ++ [ "LayersSize" Data.Aeson..= layersSize | Just layersSize <- [layersSize] ]
        ++ [ "Volumes" Data.Aeson..= volumes | Just volumes <- [volumes] ])

    toEncoding SystemDataUsageResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "BuildCache" . Data.Aeson.toEncoding) buildCache <>
          maybe mempty (Data.Aeson.Encoding.pair "Containers" . Data.Aeson.toEncoding) containers <>
          maybe mempty (Data.Aeson.Encoding.pair "Images" . Data.Aeson.toEncoding) images <>
          maybe mempty (Data.Aeson.Encoding.pair "LayersSize" . Data.Aeson.toEncoding) layersSize <>
          maybe mempty (Data.Aeson.Encoding.pair "Volumes" . Data.Aeson.toEncoding) volumes
        )

instance Data.Aeson.FromJSON SystemDataUsageResponseBody200 where
    parseJSON = Data.Aeson.withObject "SystemDataUsageResponseBody200" $ \o ->
        SystemDataUsageResponseBody200
            <$> o Data.Aeson..:? "BuildCache"
            <*> o Data.Aeson..:? "Containers"
            <*> o Data.Aeson..:? "Images"
            <*> o Data.Aeson..:? "LayersSize"
            <*> o Data.Aeson..:? "Volumes"

data SystemDataUsageTypeParam
    = SystemDataUsageTypeParamContainer
    | SystemDataUsageTypeParamImage
    | SystemDataUsageTypeParamVolume
    | SystemDataUsageTypeParamBuildCache
    deriving (Eq, Show)

instance Data.Aeson.ToJSON SystemDataUsageTypeParam where
    toJSON x = case x of
        SystemDataUsageTypeParamContainer -> "container"
        SystemDataUsageTypeParamImage -> "image"
        SystemDataUsageTypeParamVolume -> "volume"
        SystemDataUsageTypeParamBuildCache -> "build-cache"

    toEncoding x = case x of
        SystemDataUsageTypeParamContainer -> Data.Aeson.Encoding.text "container"
        SystemDataUsageTypeParamImage -> Data.Aeson.Encoding.text "image"
        SystemDataUsageTypeParamVolume -> Data.Aeson.Encoding.text "volume"
        SystemDataUsageTypeParamBuildCache -> Data.Aeson.Encoding.text "build-cache"

instance Data.Aeson.FromJSON SystemDataUsageTypeParam where
    parseJSON = Data.Aeson.withText "SystemDataUsageTypeParam" $ \s ->
        case s of
            "container" -> pure SystemDataUsageTypeParamContainer
            "image" -> pure SystemDataUsageTypeParamImage
            "volume" -> pure SystemDataUsageTypeParamVolume
            "build-cache" -> pure SystemDataUsageTypeParamBuildCache
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData SystemDataUsageTypeParam where
    toQueryParam x = case x of
        SystemDataUsageTypeParamContainer -> "container"
        SystemDataUsageTypeParamImage -> "image"
        SystemDataUsageTypeParamVolume -> "volume"
        SystemDataUsageTypeParamBuildCache -> "build-cache"

instance Web.HttpApiData.FromHttpApiData SystemDataUsageTypeParam where
    parseUrlPiece x =
        case x of
            "container" -> pure SystemDataUsageTypeParamContainer
            "image" -> pure SystemDataUsageTypeParamImage
            "volume" -> pure SystemDataUsageTypeParamVolume
            "build-cache" -> pure SystemDataUsageTypeParamBuildCache
            _ -> Left "invalid enum value"

data SystemDataUsageResponse
    = SystemDataUsageResponse200 SystemDataUsageResponseBody200
    | SystemDataUsageResponse500 ErrorResponse
    deriving (Show)

instance ToResponse SystemDataUsageResponse where
    toResponse (SystemDataUsageResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SystemDataUsageResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" SystemDataUsageResponse Network.HTTP.Types.Status where
    getField (SystemDataUsageResponse200 {}) = Network.HTTP.Types.status200
    getField (SystemDataUsageResponse500 {}) = Network.HTTP.Types.status500