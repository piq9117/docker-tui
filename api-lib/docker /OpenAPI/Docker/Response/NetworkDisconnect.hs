{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.NetworkDisconnect where

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

data NetworkDisconnectRequestBody = NetworkDisconnectRequestBody
    {
        container :: (Data.Maybe.Maybe (Data.Text.Text)),
        force :: (Data.Maybe.Maybe (GHC.Types.Bool))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NetworkDisconnectRequestBody where
    toJSON NetworkDisconnectRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Container" Data.Aeson..= container | Just container <- [container] ]
        ++ [ "Force" Data.Aeson..= force | Just force <- [force] ])

    toEncoding NetworkDisconnectRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Container" . Data.Aeson.toEncoding) container <>
          maybe mempty (Data.Aeson.Encoding.pair "Force" . Data.Aeson.toEncoding) force
        )

instance Data.Aeson.FromJSON NetworkDisconnectRequestBody where
    parseJSON = Data.Aeson.withObject "NetworkDisconnectRequestBody" $ \o ->
        NetworkDisconnectRequestBody
            <$> o Data.Aeson..:? "Container"
            <*> o Data.Aeson..:? "Force"

data NetworkDisconnectResponse
    = NetworkDisconnectResponse200
    | NetworkDisconnectResponse403 ErrorResponse
    | NetworkDisconnectResponse404 ErrorResponse
    | NetworkDisconnectResponse500 ErrorResponse
    deriving (Show)

instance ToResponse NetworkDisconnectResponse where
    toResponse (NetworkDisconnectResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (NetworkDisconnectResponse403 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status403 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkDisconnectResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkDisconnectResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" NetworkDisconnectResponse Network.HTTP.Types.Status where
    getField (NetworkDisconnectResponse200 {}) = Network.HTTP.Types.status200
    getField (NetworkDisconnectResponse403 {}) = Network.HTTP.Types.status403
    getField (NetworkDisconnectResponse404 {}) = Network.HTTP.Types.status404
    getField (NetworkDisconnectResponse500 {}) = Network.HTTP.Types.status500