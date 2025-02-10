{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerExport where

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

data ContainerExportResponse
    = ContainerExportResponse200
    | ContainerExportResponse404 Data.Aeson.Value
    | ContainerExportResponse500 Network.Wai.StreamingBody

instance ToResponse ContainerExportResponse where
    toResponse (ContainerExportResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (ContainerExportResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerExportResponse500 x) =
        Network.Wai.responseStream Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/octet-stream")]) x

instance GHC.Records.HasField "status" ContainerExportResponse Network.HTTP.Types.Status where
    getField (ContainerExportResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerExportResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerExportResponse500 {}) = Network.HTTP.Types.status500

instance Show ContainerExportResponse where
    show _ = "ContainerExportResponse {}"