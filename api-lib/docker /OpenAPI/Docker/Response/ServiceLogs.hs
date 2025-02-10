{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ServiceLogs where

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

data ServiceLogsResponse
    = ServiceLogsResponse200 Network.Wai.StreamingBody
    | ServiceLogsResponse404 Data.Aeson.Value
    | ServiceLogsResponse500 Network.Wai.StreamingBody
    | ServiceLogsResponse503 Network.Wai.StreamingBody

instance ToResponse ServiceLogsResponse where
    toResponse (ServiceLogsResponse200 x) =
        Network.Wai.responseStream Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x
    toResponse (ServiceLogsResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceLogsResponse500 x) =
        Network.Wai.responseStream Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x
    toResponse (ServiceLogsResponse503 x) =
        Network.Wai.responseStream Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x

instance GHC.Records.HasField "status" ServiceLogsResponse Network.HTTP.Types.Status where
    getField (ServiceLogsResponse200 {}) = Network.HTTP.Types.status200
    getField (ServiceLogsResponse404 {}) = Network.HTTP.Types.status404
    getField (ServiceLogsResponse500 {}) = Network.HTTP.Types.status500
    getField (ServiceLogsResponse503 {}) = Network.HTTP.Types.status503

instance Show ServiceLogsResponse where
    show _ = "ServiceLogsResponse {}"