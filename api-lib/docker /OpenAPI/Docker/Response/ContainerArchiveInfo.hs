{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerArchiveInfo where

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

data ContainerArchiveInfoResponse
    = ContainerArchiveInfoResponse200 (Data.Maybe.Maybe (Data.Text.Text))
    | ContainerArchiveInfoResponse400 ErrorResponse
    | ContainerArchiveInfoResponse404 ErrorResponse
    | ContainerArchiveInfoResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerArchiveInfoResponse where
    toResponse (ContainerArchiveInfoResponse200 __X_Docker_Container_Path_Stat) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([("X-Docker-Container-Path-Stat", Web.HttpApiData.toHeader __X_Docker_Container_Path_Stat) | Just __X_Docker_Container_Path_Stat <- [__X_Docker_Container_Path_Stat]] ++ []) mempty
    toResponse (ContainerArchiveInfoResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerArchiveInfoResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerArchiveInfoResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerArchiveInfoResponse Network.HTTP.Types.Status where
    getField (ContainerArchiveInfoResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerArchiveInfoResponse400 {}) = Network.HTTP.Types.status400
    getField (ContainerArchiveInfoResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerArchiveInfoResponse500 {}) = Network.HTTP.Types.status500