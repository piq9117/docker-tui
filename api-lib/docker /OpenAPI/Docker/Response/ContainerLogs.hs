{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerLogs where

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

data ContainerLogsResponse
    = ContainerLogsResponse200 Network.Wai.StreamingBody
    | ContainerLogsResponse404 Data.Aeson.Value
    | ContainerLogsResponse500 Network.Wai.StreamingBody

instance ToResponse ContainerLogsResponse where
    toResponse (ContainerLogsResponse200 x) =
        Network.Wai.responseStream Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x
    toResponse (ContainerLogsResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerLogsResponse500 x) =
        Network.Wai.responseStream Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x

instance GHC.Records.HasField "status" ContainerLogsResponse Network.HTTP.Types.Status where
    getField (ContainerLogsResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerLogsResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerLogsResponse500 {}) = Network.HTTP.Types.status500

instance Show ContainerLogsResponse where
    show _ = "ContainerLogsResponse {}"