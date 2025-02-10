{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ConfigCreate where

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

import OpenAPI.Docker.Schemas.ConfigSpec
import OpenAPI.Docker.Schemas.Driver
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.IdResponse

import OpenAPI.Docker.Response

data ConfigCreateRequestBody = ConfigCreateRequestBody
    {
        data' :: (Data.Maybe.Maybe (Data.Text.Text)),
        labels :: (Data.Maybe.Maybe (ConfigCreateRequestBodyLabels)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        templating :: (Data.Maybe.Maybe (Driver))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ConfigCreateRequestBody where
    toJSON ConfigCreateRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Data" Data.Aeson..= data' | Just data' <- [data'] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Templating" Data.Aeson..= templating | Just templating <- [templating] ])

    toEncoding ConfigCreateRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Data" . Data.Aeson.toEncoding) data' <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Templating" . Data.Aeson.toEncoding) templating
        )

instance Data.Aeson.FromJSON ConfigCreateRequestBody where
    parseJSON = Data.Aeson.withObject "ConfigCreateRequestBody" $ \o ->
        ConfigCreateRequestBody
            <$> o Data.Aeson..:? "Data"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Templating"

newtype ConfigCreateRequestBodyLabels = ConfigCreateRequestBodyLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ConfigCreateRequestBodyLabels where
    toJSON (ConfigCreateRequestBodyLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ConfigCreateRequestBodyLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ConfigCreateRequestBodyLabels where
    parseJSON x =
        ConfigCreateRequestBodyLabels <$> Data.Aeson.parseJSON x

data ConfigCreateResponse
    = ConfigCreateResponse201 IdResponse
    | ConfigCreateResponse409 ErrorResponse
    | ConfigCreateResponse500 ErrorResponse
    | ConfigCreateResponse503 ErrorResponse
    deriving (Show)

instance ToResponse ConfigCreateResponse where
    toResponse (ConfigCreateResponse201 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status201 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ConfigCreateResponse409 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status409 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ConfigCreateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ConfigCreateResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ConfigCreateResponse Network.HTTP.Types.Status where
    getField (ConfigCreateResponse201 {}) = Network.HTTP.Types.status201
    getField (ConfigCreateResponse409 {}) = Network.HTTP.Types.status409
    getField (ConfigCreateResponse500 {}) = Network.HTTP.Types.status500
    getField (ConfigCreateResponse503 {}) = Network.HTTP.Types.status503