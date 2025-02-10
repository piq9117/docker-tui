{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerWait where

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

import OpenAPI.Docker.Schemas.ContainerWaitResponse
import OpenAPI.Docker.Schemas.ErrorResponse

import OpenAPI.Docker.Response

data ContainerWaitConditionParam
    = ContainerWaitConditionParamNotRunning
    | ContainerWaitConditionParamNextExit
    | ContainerWaitConditionParamRemoved
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ContainerWaitConditionParam where
    toJSON x = case x of
        ContainerWaitConditionParamNotRunning -> "not-running"
        ContainerWaitConditionParamNextExit -> "next-exit"
        ContainerWaitConditionParamRemoved -> "removed"

    toEncoding x = case x of
        ContainerWaitConditionParamNotRunning -> Data.Aeson.Encoding.text "not-running"
        ContainerWaitConditionParamNextExit -> Data.Aeson.Encoding.text "next-exit"
        ContainerWaitConditionParamRemoved -> Data.Aeson.Encoding.text "removed"

instance Data.Aeson.FromJSON ContainerWaitConditionParam where
    parseJSON = Data.Aeson.withText "ContainerWaitConditionParam" $ \s ->
        case s of
            "not-running" -> pure ContainerWaitConditionParamNotRunning
            "next-exit" -> pure ContainerWaitConditionParamNextExit
            "removed" -> pure ContainerWaitConditionParamRemoved
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ContainerWaitConditionParam where
    toQueryParam x = case x of
        ContainerWaitConditionParamNotRunning -> "not-running"
        ContainerWaitConditionParamNextExit -> "next-exit"
        ContainerWaitConditionParamRemoved -> "removed"

instance Web.HttpApiData.FromHttpApiData ContainerWaitConditionParam where
    parseUrlPiece x =
        case x of
            "not-running" -> pure ContainerWaitConditionParamNotRunning
            "next-exit" -> pure ContainerWaitConditionParamNextExit
            "removed" -> pure ContainerWaitConditionParamRemoved
            _ -> Left "invalid enum value"

data ContainerWaitResponse
    = ContainerWaitResponse200 ContainerWaitResponse
    | ContainerWaitResponse400 ErrorResponse
    | ContainerWaitResponse404 ErrorResponse
    | ContainerWaitResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerWaitResponse where
    toResponse (ContainerWaitResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerWaitResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerWaitResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerWaitResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerWaitResponse Network.HTTP.Types.Status where
    getField (ContainerWaitResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerWaitResponse400 {}) = Network.HTTP.Types.status400
    getField (ContainerWaitResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerWaitResponse500 {}) = Network.HTTP.Types.status500