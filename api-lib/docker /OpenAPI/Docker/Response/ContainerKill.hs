{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerKill where

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

data ContainerKillResponse
    = ContainerKillResponse204
    | ContainerKillResponse404 ErrorResponse
    | ContainerKillResponse409 ErrorResponse
    | ContainerKillResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerKillResponse where
    toResponse (ContainerKillResponse204) =
        Network.Wai.responseBuilder Network.HTTP.Types.status204 ([]) mempty
    toResponse (ContainerKillResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerKillResponse409 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status409 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerKillResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerKillResponse Network.HTTP.Types.Status where
    getField (ContainerKillResponse204 {}) = Network.HTTP.Types.status204
    getField (ContainerKillResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerKillResponse409 {}) = Network.HTTP.Types.status409
    getField (ContainerKillResponse500 {}) = Network.HTTP.Types.status500