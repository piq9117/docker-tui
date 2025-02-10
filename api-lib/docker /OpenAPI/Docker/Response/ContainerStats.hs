{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerStats where

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

import OpenAPI.Docker.Schemas.ErrorResponse

import OpenAPI.Docker.Response

data ContainerStatsResponseBody200 = ContainerStatsResponseBody200
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerStatsResponseBody200 where
    toJSON ContainerStatsResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ContainerStatsResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ContainerStatsResponseBody200 where
    parseJSON = Data.Aeson.withObject "ContainerStatsResponseBody200" $ \o ->
        ContainerStatsResponseBody200
            

data ContainerStatsResponse
    = ContainerStatsResponse200 ContainerStatsResponseBody200
    | ContainerStatsResponse404 ErrorResponse
    | ContainerStatsResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerStatsResponse where
    toResponse (ContainerStatsResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerStatsResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerStatsResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerStatsResponse Network.HTTP.Types.Status where
    getField (ContainerStatsResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerStatsResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerStatsResponse500 {}) = Network.HTTP.Types.status500