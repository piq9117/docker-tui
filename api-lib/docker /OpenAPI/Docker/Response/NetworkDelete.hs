{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.NetworkDelete where

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

data NetworkDeleteResponse
    = NetworkDeleteResponse204
    | NetworkDeleteResponse403 ErrorResponse
    | NetworkDeleteResponse404 ErrorResponse
    | NetworkDeleteResponse500 ErrorResponse
    deriving (Show)

instance ToResponse NetworkDeleteResponse where
    toResponse (NetworkDeleteResponse204) =
        Network.Wai.responseBuilder Network.HTTP.Types.status204 ([]) mempty
    toResponse (NetworkDeleteResponse403 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status403 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkDeleteResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkDeleteResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" NetworkDeleteResponse Network.HTTP.Types.Status where
    getField (NetworkDeleteResponse204 {}) = Network.HTTP.Types.status204
    getField (NetworkDeleteResponse403 {}) = Network.HTTP.Types.status403
    getField (NetworkDeleteResponse404 {}) = Network.HTTP.Types.status404
    getField (NetworkDeleteResponse500 {}) = Network.HTTP.Types.status500