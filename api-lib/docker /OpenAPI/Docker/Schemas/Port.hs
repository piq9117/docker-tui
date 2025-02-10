{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Port where

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





data PortType
    = PortTypeTcp
    | PortTypeUdp
    | PortTypeSctp
    deriving (Eq, Show)

instance Data.Aeson.ToJSON PortType where
    toJSON x = case x of
        PortTypeTcp -> "tcp"
        PortTypeUdp -> "udp"
        PortTypeSctp -> "sctp"

    toEncoding x = case x of
        PortTypeTcp -> Data.Aeson.Encoding.text "tcp"
        PortTypeUdp -> Data.Aeson.Encoding.text "udp"
        PortTypeSctp -> Data.Aeson.Encoding.text "sctp"

instance Data.Aeson.FromJSON PortType where
    parseJSON = Data.Aeson.withText "PortType" $ \s ->
        case s of
            "tcp" -> pure PortTypeTcp
            "udp" -> pure PortTypeUdp
            "sctp" -> pure PortTypeSctp
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData PortType where
    toQueryParam x = case x of
        PortTypeTcp -> "tcp"
        PortTypeUdp -> "udp"
        PortTypeSctp -> "sctp"

instance Web.HttpApiData.FromHttpApiData PortType where
    parseUrlPiece x =
        case x of
            "tcp" -> pure PortTypeTcp
            "udp" -> pure PortTypeUdp
            "sctp" -> pure PortTypeSctp
            _ -> Left "invalid enum value"

data Port = Port
    {
        iP :: (Data.Maybe.Maybe (Data.Text.Text)),
        privatePort :: GHC.Int.Int,
        publicPort :: (Data.Maybe.Maybe (GHC.Int.Int)),
        type' :: PortType
    }
    deriving (Show)

instance Data.Aeson.ToJSON Port where
    toJSON Port {..} = Data.Aeson.object
        ([ "PrivatePort" Data.Aeson..= privatePort,
           "Type" Data.Aeson..= type'
        ]
        ++ [ "IP" Data.Aeson..= iP | Just iP <- [iP] ]
        ++ [ "PublicPort" Data.Aeson..= publicPort | Just publicPort <- [publicPort] ])

    toEncoding Port {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "IP" . Data.Aeson.toEncoding) iP <>
          Data.Aeson.Encoding.pair "PrivatePort" (Data.Aeson.toEncoding privatePort) <>
          maybe mempty (Data.Aeson.Encoding.pair "PublicPort" . Data.Aeson.toEncoding) publicPort <>
          Data.Aeson.Encoding.pair "Type" (Data.Aeson.toEncoding type')
        )

instance Data.Aeson.FromJSON Port where
    parseJSON = Data.Aeson.withObject "Port" $ \o ->
        Port
            <$> o Data.Aeson..:? "IP"
            <*> o Data.Aeson..: "PrivatePort"
            <*> o Data.Aeson..:? "PublicPort"
            <*> o Data.Aeson..: "Type"