{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SecretCreate where

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

import OpenAPI.Docker.Schemas.Driver
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.IdResponse
import OpenAPI.Docker.Schemas.SecretSpec

import OpenAPI.Docker.Response

data SecretCreateRequestBody = SecretCreateRequestBody
    {
        data' :: (Data.Maybe.Maybe (Data.Text.Text)),
        driver :: (Data.Maybe.Maybe (Driver)),
        labels :: (Data.Maybe.Maybe (SecretCreateRequestBodyLabels)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        templating :: (Data.Maybe.Maybe (Driver))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SecretCreateRequestBody where
    toJSON SecretCreateRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Data" Data.Aeson..= data' | Just data' <- [data'] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Templating" Data.Aeson..= templating | Just templating <- [templating] ])

    toEncoding SecretCreateRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Data" . Data.Aeson.toEncoding) data' <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Templating" . Data.Aeson.toEncoding) templating
        )

instance Data.Aeson.FromJSON SecretCreateRequestBody where
    parseJSON = Data.Aeson.withObject "SecretCreateRequestBody" $ \o ->
        SecretCreateRequestBody
            <$> o Data.Aeson..:? "Data"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Templating"

newtype SecretCreateRequestBodyLabels = SecretCreateRequestBodyLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON SecretCreateRequestBodyLabels where
    toJSON (SecretCreateRequestBodyLabels x) =
        Data.Aeson.toJSON x

    toEncoding (SecretCreateRequestBodyLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON SecretCreateRequestBodyLabels where
    parseJSON x =
        SecretCreateRequestBodyLabels <$> Data.Aeson.parseJSON x

data SecretCreateResponse
    = SecretCreateResponse201 IdResponse
    | SecretCreateResponse409 ErrorResponse
    | SecretCreateResponse500 ErrorResponse
    | SecretCreateResponse503 ErrorResponse
    deriving (Show)

instance ToResponse SecretCreateResponse where
    toResponse (SecretCreateResponse201 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status201 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SecretCreateResponse409 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status409 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SecretCreateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SecretCreateResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" SecretCreateResponse Network.HTTP.Types.Status where
    getField (SecretCreateResponse201 {}) = Network.HTTP.Types.status201
    getField (SecretCreateResponse409 {}) = Network.HTTP.Types.status409
    getField (SecretCreateResponse500 {}) = Network.HTTP.Types.status500
    getField (SecretCreateResponse503 {}) = Network.HTTP.Types.status503