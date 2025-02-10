{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.NetworkConnect where

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

import OpenAPI.Docker.Schemas.EndpointSettings
import OpenAPI.Docker.Schemas.ErrorResponse

import OpenAPI.Docker.Response

data NetworkConnectRequestBody = NetworkConnectRequestBody
    {
        container :: (Data.Maybe.Maybe (Data.Text.Text)),
        endpointConfig :: (Data.Maybe.Maybe (EndpointSettings))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NetworkConnectRequestBody where
    toJSON NetworkConnectRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Container" Data.Aeson..= container | Just container <- [container] ]
        ++ [ "EndpointConfig" Data.Aeson..= endpointConfig | Just endpointConfig <- [endpointConfig] ])

    toEncoding NetworkConnectRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Container" . Data.Aeson.toEncoding) container <>
          maybe mempty (Data.Aeson.Encoding.pair "EndpointConfig" . Data.Aeson.toEncoding) endpointConfig
        )

instance Data.Aeson.FromJSON NetworkConnectRequestBody where
    parseJSON = Data.Aeson.withObject "NetworkConnectRequestBody" $ \o ->
        NetworkConnectRequestBody
            <$> o Data.Aeson..:? "Container"
            <*> o Data.Aeson..:? "EndpointConfig"

data NetworkConnectResponse
    = NetworkConnectResponse200
    | NetworkConnectResponse400 ErrorResponse
    | NetworkConnectResponse403 ErrorResponse
    | NetworkConnectResponse404 ErrorResponse
    | NetworkConnectResponse500 ErrorResponse
    deriving (Show)

instance ToResponse NetworkConnectResponse where
    toResponse (NetworkConnectResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (NetworkConnectResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkConnectResponse403 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status403 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkConnectResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkConnectResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" NetworkConnectResponse Network.HTTP.Types.Status where
    getField (NetworkConnectResponse200 {}) = Network.HTTP.Types.status200
    getField (NetworkConnectResponse400 {}) = Network.HTTP.Types.status400
    getField (NetworkConnectResponse403 {}) = Network.HTTP.Types.status403
    getField (NetworkConnectResponse404 {}) = Network.HTTP.Types.status404
    getField (NetworkConnectResponse500 {}) = Network.HTTP.Types.status500