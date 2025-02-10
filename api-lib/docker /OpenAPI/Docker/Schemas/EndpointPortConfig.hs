{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.EndpointPortConfig where

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





data EndpointPortConfigProtocol
    = EndpointPortConfigProtocolTcp
    | EndpointPortConfigProtocolUdp
    | EndpointPortConfigProtocolSctp
    deriving (Eq, Show)

instance Data.Aeson.ToJSON EndpointPortConfigProtocol where
    toJSON x = case x of
        EndpointPortConfigProtocolTcp -> "tcp"
        EndpointPortConfigProtocolUdp -> "udp"
        EndpointPortConfigProtocolSctp -> "sctp"

    toEncoding x = case x of
        EndpointPortConfigProtocolTcp -> Data.Aeson.Encoding.text "tcp"
        EndpointPortConfigProtocolUdp -> Data.Aeson.Encoding.text "udp"
        EndpointPortConfigProtocolSctp -> Data.Aeson.Encoding.text "sctp"

instance Data.Aeson.FromJSON EndpointPortConfigProtocol where
    parseJSON = Data.Aeson.withText "EndpointPortConfigProtocol" $ \s ->
        case s of
            "tcp" -> pure EndpointPortConfigProtocolTcp
            "udp" -> pure EndpointPortConfigProtocolUdp
            "sctp" -> pure EndpointPortConfigProtocolSctp
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData EndpointPortConfigProtocol where
    toQueryParam x = case x of
        EndpointPortConfigProtocolTcp -> "tcp"
        EndpointPortConfigProtocolUdp -> "udp"
        EndpointPortConfigProtocolSctp -> "sctp"

instance Web.HttpApiData.FromHttpApiData EndpointPortConfigProtocol where
    parseUrlPiece x =
        case x of
            "tcp" -> pure EndpointPortConfigProtocolTcp
            "udp" -> pure EndpointPortConfigProtocolUdp
            "sctp" -> pure EndpointPortConfigProtocolSctp
            _ -> Left "invalid enum value"

data EndpointPortConfigPublishMode
    = EndpointPortConfigPublishModeIngress
    | EndpointPortConfigPublishModeHost
    deriving (Eq, Show)

instance Data.Aeson.ToJSON EndpointPortConfigPublishMode where
    toJSON x = case x of
        EndpointPortConfigPublishModeIngress -> "ingress"
        EndpointPortConfigPublishModeHost -> "host"

    toEncoding x = case x of
        EndpointPortConfigPublishModeIngress -> Data.Aeson.Encoding.text "ingress"
        EndpointPortConfigPublishModeHost -> Data.Aeson.Encoding.text "host"

instance Data.Aeson.FromJSON EndpointPortConfigPublishMode where
    parseJSON = Data.Aeson.withText "EndpointPortConfigPublishMode" $ \s ->
        case s of
            "ingress" -> pure EndpointPortConfigPublishModeIngress
            "host" -> pure EndpointPortConfigPublishModeHost
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData EndpointPortConfigPublishMode where
    toQueryParam x = case x of
        EndpointPortConfigPublishModeIngress -> "ingress"
        EndpointPortConfigPublishModeHost -> "host"

instance Web.HttpApiData.FromHttpApiData EndpointPortConfigPublishMode where
    parseUrlPiece x =
        case x of
            "ingress" -> pure EndpointPortConfigPublishModeIngress
            "host" -> pure EndpointPortConfigPublishModeHost
            _ -> Left "invalid enum value"

data EndpointPortConfig = EndpointPortConfig
    {
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        protocol :: (Data.Maybe.Maybe (EndpointPortConfigProtocol)),
        publishMode :: (Data.Maybe.Maybe (EndpointPortConfigPublishMode)),
        publishedPort :: (Data.Maybe.Maybe (GHC.Int.Int)),
        targetPort :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON EndpointPortConfig where
    toJSON EndpointPortConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Protocol" Data.Aeson..= protocol | Just protocol <- [protocol] ]
        ++ [ "PublishMode" Data.Aeson..= publishMode | Just publishMode <- [publishMode] ]
        ++ [ "PublishedPort" Data.Aeson..= publishedPort | Just publishedPort <- [publishedPort] ]
        ++ [ "TargetPort" Data.Aeson..= targetPort | Just targetPort <- [targetPort] ])

    toEncoding EndpointPortConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Protocol" . Data.Aeson.toEncoding) protocol <>
          maybe mempty (Data.Aeson.Encoding.pair "PublishMode" . Data.Aeson.toEncoding) publishMode <>
          maybe mempty (Data.Aeson.Encoding.pair "PublishedPort" . Data.Aeson.toEncoding) publishedPort <>
          maybe mempty (Data.Aeson.Encoding.pair "TargetPort" . Data.Aeson.toEncoding) targetPort
        )

instance Data.Aeson.FromJSON EndpointPortConfig where
    parseJSON = Data.Aeson.withObject "EndpointPortConfig" $ \o ->
        EndpointPortConfig
            <$> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Protocol"
            <*> o Data.Aeson..:? "PublishMode"
            <*> o Data.Aeson..:? "PublishedPort"
            <*> o Data.Aeson..:? "TargetPort"