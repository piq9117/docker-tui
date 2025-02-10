{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.TaskLogs where

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

data TaskLogsResponse
    = TaskLogsResponse200 Network.Wai.StreamingBody
    | TaskLogsResponse404 Data.Aeson.Value
    | TaskLogsResponse500 Network.Wai.StreamingBody
    | TaskLogsResponse503 Network.Wai.StreamingBody

instance ToResponse TaskLogsResponse where
    toResponse (TaskLogsResponse200 x) =
        Network.Wai.responseStream Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x
    toResponse (TaskLogsResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (TaskLogsResponse500 x) =
        Network.Wai.responseStream Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x
    toResponse (TaskLogsResponse503 x) =
        Network.Wai.responseStream Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x

instance GHC.Records.HasField "status" TaskLogsResponse Network.HTTP.Types.Status where
    getField (TaskLogsResponse200 {}) = Network.HTTP.Types.status200
    getField (TaskLogsResponse404 {}) = Network.HTTP.Types.status404
    getField (TaskLogsResponse500 {}) = Network.HTTP.Types.status500
    getField (TaskLogsResponse503 {}) = Network.HTTP.Types.status503

instance Show TaskLogsResponse where
    show _ = "TaskLogsResponse {}"