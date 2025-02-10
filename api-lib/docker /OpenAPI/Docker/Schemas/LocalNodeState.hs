{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.LocalNodeState where

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





data LocalNodeState
    = LocalNodeState
    | LocalNodeStateInactive
    | LocalNodeStatePending
    | LocalNodeStateActive
    | LocalNodeStateError
    | LocalNodeStateLocked
    deriving (Eq, Show)

instance Data.Aeson.ToJSON LocalNodeState where
    toJSON x = case x of
        LocalNodeState -> ""
        LocalNodeStateInactive -> "inactive"
        LocalNodeStatePending -> "pending"
        LocalNodeStateActive -> "active"
        LocalNodeStateError -> "error"
        LocalNodeStateLocked -> "locked"

    toEncoding x = case x of
        LocalNodeState -> Data.Aeson.Encoding.text ""
        LocalNodeStateInactive -> Data.Aeson.Encoding.text "inactive"
        LocalNodeStatePending -> Data.Aeson.Encoding.text "pending"
        LocalNodeStateActive -> Data.Aeson.Encoding.text "active"
        LocalNodeStateError -> Data.Aeson.Encoding.text "error"
        LocalNodeStateLocked -> Data.Aeson.Encoding.text "locked"

instance Data.Aeson.FromJSON LocalNodeState where
    parseJSON = Data.Aeson.withText "LocalNodeState" $ \s ->
        case s of
            "" -> pure LocalNodeState
            "inactive" -> pure LocalNodeStateInactive
            "pending" -> pure LocalNodeStatePending
            "active" -> pure LocalNodeStateActive
            "error" -> pure LocalNodeStateError
            "locked" -> pure LocalNodeStateLocked
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData LocalNodeState where
    toQueryParam x = case x of
        LocalNodeState -> ""
        LocalNodeStateInactive -> "inactive"
        LocalNodeStatePending -> "pending"
        LocalNodeStateActive -> "active"
        LocalNodeStateError -> "error"
        LocalNodeStateLocked -> "locked"

instance Web.HttpApiData.FromHttpApiData LocalNodeState where
    parseUrlPiece x =
        case x of
            "" -> pure LocalNodeState
            "inactive" -> pure LocalNodeStateInactive
            "pending" -> pure LocalNodeStatePending
            "active" -> pure LocalNodeStateActive
            "error" -> pure LocalNodeStateError
            "locked" -> pure LocalNodeStateLocked
            _ -> Left "invalid enum value"