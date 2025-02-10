{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.EventMessage where

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



import OpenAPI.Docker.Schemas.EventActor

data EventMessageScope
    = EventMessageScopeLocal
    | EventMessageScopeSwarm
    deriving (Eq, Show)

instance Data.Aeson.ToJSON EventMessageScope where
    toJSON x = case x of
        EventMessageScopeLocal -> "local"
        EventMessageScopeSwarm -> "swarm"

    toEncoding x = case x of
        EventMessageScopeLocal -> Data.Aeson.Encoding.text "local"
        EventMessageScopeSwarm -> Data.Aeson.Encoding.text "swarm"

instance Data.Aeson.FromJSON EventMessageScope where
    parseJSON = Data.Aeson.withText "EventMessageScope" $ \s ->
        case s of
            "local" -> pure EventMessageScopeLocal
            "swarm" -> pure EventMessageScopeSwarm
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData EventMessageScope where
    toQueryParam x = case x of
        EventMessageScopeLocal -> "local"
        EventMessageScopeSwarm -> "swarm"

instance Web.HttpApiData.FromHttpApiData EventMessageScope where
    parseUrlPiece x =
        case x of
            "local" -> pure EventMessageScopeLocal
            "swarm" -> pure EventMessageScopeSwarm
            _ -> Left "invalid enum value"

data EventMessageType
    = EventMessageTypeBuilder
    | EventMessageTypeConfig
    | EventMessageTypeContainer
    | EventMessageTypeDaemon
    | EventMessageTypeImage
    | EventMessageTypeNetwork
    | EventMessageTypeNode
    | EventMessageTypePlugin
    | EventMessageTypeSecret
    | EventMessageTypeService
    | EventMessageTypeVolume
    deriving (Eq, Show)

instance Data.Aeson.ToJSON EventMessageType where
    toJSON x = case x of
        EventMessageTypeBuilder -> "builder"
        EventMessageTypeConfig -> "config"
        EventMessageTypeContainer -> "container"
        EventMessageTypeDaemon -> "daemon"
        EventMessageTypeImage -> "image"
        EventMessageTypeNetwork -> "network"
        EventMessageTypeNode -> "node"
        EventMessageTypePlugin -> "plugin"
        EventMessageTypeSecret -> "secret"
        EventMessageTypeService -> "service"
        EventMessageTypeVolume -> "volume"

    toEncoding x = case x of
        EventMessageTypeBuilder -> Data.Aeson.Encoding.text "builder"
        EventMessageTypeConfig -> Data.Aeson.Encoding.text "config"
        EventMessageTypeContainer -> Data.Aeson.Encoding.text "container"
        EventMessageTypeDaemon -> Data.Aeson.Encoding.text "daemon"
        EventMessageTypeImage -> Data.Aeson.Encoding.text "image"
        EventMessageTypeNetwork -> Data.Aeson.Encoding.text "network"
        EventMessageTypeNode -> Data.Aeson.Encoding.text "node"
        EventMessageTypePlugin -> Data.Aeson.Encoding.text "plugin"
        EventMessageTypeSecret -> Data.Aeson.Encoding.text "secret"
        EventMessageTypeService -> Data.Aeson.Encoding.text "service"
        EventMessageTypeVolume -> Data.Aeson.Encoding.text "volume"

instance Data.Aeson.FromJSON EventMessageType where
    parseJSON = Data.Aeson.withText "EventMessageType" $ \s ->
        case s of
            "builder" -> pure EventMessageTypeBuilder
            "config" -> pure EventMessageTypeConfig
            "container" -> pure EventMessageTypeContainer
            "daemon" -> pure EventMessageTypeDaemon
            "image" -> pure EventMessageTypeImage
            "network" -> pure EventMessageTypeNetwork
            "node" -> pure EventMessageTypeNode
            "plugin" -> pure EventMessageTypePlugin
            "secret" -> pure EventMessageTypeSecret
            "service" -> pure EventMessageTypeService
            "volume" -> pure EventMessageTypeVolume
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData EventMessageType where
    toQueryParam x = case x of
        EventMessageTypeBuilder -> "builder"
        EventMessageTypeConfig -> "config"
        EventMessageTypeContainer -> "container"
        EventMessageTypeDaemon -> "daemon"
        EventMessageTypeImage -> "image"
        EventMessageTypeNetwork -> "network"
        EventMessageTypeNode -> "node"
        EventMessageTypePlugin -> "plugin"
        EventMessageTypeSecret -> "secret"
        EventMessageTypeService -> "service"
        EventMessageTypeVolume -> "volume"

instance Web.HttpApiData.FromHttpApiData EventMessageType where
    parseUrlPiece x =
        case x of
            "builder" -> pure EventMessageTypeBuilder
            "config" -> pure EventMessageTypeConfig
            "container" -> pure EventMessageTypeContainer
            "daemon" -> pure EventMessageTypeDaemon
            "image" -> pure EventMessageTypeImage
            "network" -> pure EventMessageTypeNetwork
            "node" -> pure EventMessageTypeNode
            "plugin" -> pure EventMessageTypePlugin
            "secret" -> pure EventMessageTypeSecret
            "service" -> pure EventMessageTypeService
            "volume" -> pure EventMessageTypeVolume
            _ -> Left "invalid enum value"

data EventMessage = EventMessage
    {
        action :: (Data.Maybe.Maybe (Data.Text.Text)),
        actor :: (Data.Maybe.Maybe (EventActor)),
        type' :: (Data.Maybe.Maybe (EventMessageType)),
        scope :: (Data.Maybe.Maybe (EventMessageScope)),
        time :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        timeNano :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON EventMessage where
    toJSON EventMessage {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Action" Data.Aeson..= action | Just action <- [action] ]
        ++ [ "Actor" Data.Aeson..= actor | Just actor <- [actor] ]
        ++ [ "Type" Data.Aeson..= type' | Just type' <- [type'] ]
        ++ [ "scope" Data.Aeson..= scope | Just scope <- [scope] ]
        ++ [ "time" Data.Aeson..= time | Just time <- [time] ]
        ++ [ "timeNano" Data.Aeson..= timeNano | Just timeNano <- [timeNano] ])

    toEncoding EventMessage {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Action" . Data.Aeson.toEncoding) action <>
          maybe mempty (Data.Aeson.Encoding.pair "Actor" . Data.Aeson.toEncoding) actor <>
          maybe mempty (Data.Aeson.Encoding.pair "Type" . Data.Aeson.toEncoding) type' <>
          maybe mempty (Data.Aeson.Encoding.pair "scope" . Data.Aeson.toEncoding) scope <>
          maybe mempty (Data.Aeson.Encoding.pair "time" . Data.Aeson.toEncoding) time <>
          maybe mempty (Data.Aeson.Encoding.pair "timeNano" . Data.Aeson.toEncoding) timeNano
        )

instance Data.Aeson.FromJSON EventMessage where
    parseJSON = Data.Aeson.withObject "EventMessage" $ \o ->
        EventMessage
            <$> o Data.Aeson..:? "Action"
            <*> o Data.Aeson..:? "Actor"
            <*> o Data.Aeson..:? "Type"
            <*> o Data.Aeson..:? "scope"
            <*> o Data.Aeson..:? "time"
            <*> o Data.Aeson..:? "timeNano"