{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.NodeState where

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





data NodeState
    = NodeStateUnknown
    | NodeStateDown
    | NodeStateReady
    | NodeStateDisconnected
    deriving (Eq, Show)

instance Data.Aeson.ToJSON NodeState where
    toJSON x = case x of
        NodeStateUnknown -> "unknown"
        NodeStateDown -> "down"
        NodeStateReady -> "ready"
        NodeStateDisconnected -> "disconnected"

    toEncoding x = case x of
        NodeStateUnknown -> Data.Aeson.Encoding.text "unknown"
        NodeStateDown -> Data.Aeson.Encoding.text "down"
        NodeStateReady -> Data.Aeson.Encoding.text "ready"
        NodeStateDisconnected -> Data.Aeson.Encoding.text "disconnected"

instance Data.Aeson.FromJSON NodeState where
    parseJSON = Data.Aeson.withText "NodeState" $ \s ->
        case s of
            "unknown" -> pure NodeStateUnknown
            "down" -> pure NodeStateDown
            "ready" -> pure NodeStateReady
            "disconnected" -> pure NodeStateDisconnected
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData NodeState where
    toQueryParam x = case x of
        NodeStateUnknown -> "unknown"
        NodeStateDown -> "down"
        NodeStateReady -> "ready"
        NodeStateDisconnected -> "disconnected"

instance Web.HttpApiData.FromHttpApiData NodeState where
    parseUrlPiece x =
        case x of
            "unknown" -> pure NodeStateUnknown
            "down" -> pure NodeStateDown
            "ready" -> pure NodeStateReady
            "disconnected" -> pure NodeStateDisconnected
            _ -> Left "invalid enum value"