{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ImageDelete where

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
import OpenAPI.Docker.Schemas.ImageDeleteResponseItem

import OpenAPI.Docker.Response

data ImageDeleteResponse
    = ImageDeleteResponse200 [ ImageDeleteResponseItem ]
    | ImageDeleteResponse404 ErrorResponse
    | ImageDeleteResponse409 ErrorResponse
    | ImageDeleteResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ImageDeleteResponse where
    toResponse (ImageDeleteResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ImageDeleteResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ImageDeleteResponse409 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status409 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ImageDeleteResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ImageDeleteResponse Network.HTTP.Types.Status where
    getField (ImageDeleteResponse200 {}) = Network.HTTP.Types.status200
    getField (ImageDeleteResponse404 {}) = Network.HTTP.Types.status404
    getField (ImageDeleteResponse409 {}) = Network.HTTP.Types.status409
    getField (ImageDeleteResponse500 {}) = Network.HTTP.Types.status500