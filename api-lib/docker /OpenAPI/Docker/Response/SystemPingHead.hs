{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SystemPingHead where

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

data SystemPingHeadResponse
    = SystemPingHeadResponse200 Network.Wai.StreamingBody (Data.Maybe.Maybe (GHC.Types.Bool)) (Data.Maybe.Maybe (Data.Text.Text)) (Data.Maybe.Maybe (Data.Text.Text)) (Data.Maybe.Maybe (Data.Text.Text)) (Data.Maybe.Maybe (Data.Text.Text)) (Data.Maybe.Maybe (data Swarm
        = SwarmInactive
        | SwarmPending
        | SwarmError
        | SwarmLocked
        | SwarmActive/worker
        | SwarmActive/manager
        deriving (Eq, Show)

    instance Data.Aeson.ToJSON Swarm where
        toJSON x = case x of
            SwarmInactive -> "inactive"
            SwarmPending -> "pending"
            SwarmError -> "error"
            SwarmLocked -> "locked"
            SwarmActive/worker -> "active/worker"
            SwarmActive/manager -> "active/manager"

        toEncoding x = case x of
            SwarmInactive -> Data.Aeson.Encoding.text "inactive"
            SwarmPending -> Data.Aeson.Encoding.text "pending"
            SwarmError -> Data.Aeson.Encoding.text "error"
            SwarmLocked -> Data.Aeson.Encoding.text "locked"
            SwarmActive/worker -> Data.Aeson.Encoding.text "active/worker"
            SwarmActive/manager -> Data.Aeson.Encoding.text "active/manager"

    instance Data.Aeson.FromJSON Swarm where
        parseJSON = Data.Aeson.withText "Swarm" $ \s ->
            case s of
                "inactive" -> pure SwarmInactive
                "pending" -> pure SwarmPending
                "error" -> pure SwarmError
                "locked" -> pure SwarmLocked
                "active/worker" -> pure SwarmActive/worker
                "active/manager" -> pure SwarmActive/manager
                _ -> fail "invalid enum value"

    instance Web.HttpApiData.ToHttpApiData Swarm where
        toQueryParam x = case x of
            SwarmInactive -> "inactive"
            SwarmPending -> "pending"
            SwarmError -> "error"
            SwarmLocked -> "locked"
            SwarmActive/worker -> "active/worker"
            SwarmActive/manager -> "active/manager"

    instance Web.HttpApiData.FromHttpApiData Swarm where
        parseUrlPiece x =
            case x of
                "inactive" -> pure SwarmInactive
                "pending" -> pure SwarmPending
                "error" -> pure SwarmError
                "locked" -> pure SwarmLocked
                "active/worker" -> pure SwarmActive/worker
                "active/manager" -> pure SwarmActive/manager
                _ -> Left "invalid enum value"))
    | SystemPingHeadResponse500 Network.Wai.StreamingBody

instance ToResponse SystemPingHeadResponse where
    toResponse (SystemPingHeadResponse200 x __Docker_Experimental __Api_Version __Cache_Control __Pragma __Builder_Version __Swarm) =
        Network.Wai.responseStream Network.HTTP.Types.status200 ([("Docker-Experimental", Web.HttpApiData.toHeader __Docker_Experimental) | Just __Docker_Experimental <- [__Docker_Experimental]] ++ [("Api-Version", Web.HttpApiData.toHeader __Api_Version) | Just __Api_Version <- [__Api_Version]] ++ [("Cache-Control", Web.HttpApiData.toHeader __Cache_Control) | Just __Cache_Control <- [__Cache_Control]] ++ [("Pragma", Web.HttpApiData.toHeader __Pragma) | Just __Pragma <- [__Pragma]] ++ [("Builder-Version", Web.HttpApiData.toHeader __Builder_Version) | Just __Builder_Version <- [__Builder_Version]] ++ [("Swarm", Web.HttpApiData.toHeader __Swarm) | Just __Swarm <- [__Swarm]] ++ [(Network.HTTP.Types.hContentType, "text/plain")]) x
    toResponse (SystemPingHeadResponse500 x) =
        Network.Wai.responseStream Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "text/plain")]) x

instance GHC.Records.HasField "status" SystemPingHeadResponse Network.HTTP.Types.Status where
    getField (SystemPingHeadResponse200 {}) = Network.HTTP.Types.status200
    getField (SystemPingHeadResponse500 {}) = Network.HTTP.Types.status500

instance Show SystemPingHeadResponse where
    show _ = "SystemPingHeadResponse {}"