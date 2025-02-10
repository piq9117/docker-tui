{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.TaskState where

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





data TaskState
    = TaskStateNew
    | TaskStateAllocated
    | TaskStatePending
    | TaskStateAssigned
    | TaskStateAccepted
    | TaskStatePreparing
    | TaskStateReady
    | TaskStateStarting
    | TaskStateRunning
    | TaskStateComplete
    | TaskStateShutdown
    | TaskStateFailed
    | TaskStateRejected
    | TaskStateRemove
    | TaskStateOrphaned
    deriving (Eq, Show)

instance Data.Aeson.ToJSON TaskState where
    toJSON x = case x of
        TaskStateNew -> "new"
        TaskStateAllocated -> "allocated"
        TaskStatePending -> "pending"
        TaskStateAssigned -> "assigned"
        TaskStateAccepted -> "accepted"
        TaskStatePreparing -> "preparing"
        TaskStateReady -> "ready"
        TaskStateStarting -> "starting"
        TaskStateRunning -> "running"
        TaskStateComplete -> "complete"
        TaskStateShutdown -> "shutdown"
        TaskStateFailed -> "failed"
        TaskStateRejected -> "rejected"
        TaskStateRemove -> "remove"
        TaskStateOrphaned -> "orphaned"

    toEncoding x = case x of
        TaskStateNew -> Data.Aeson.Encoding.text "new"
        TaskStateAllocated -> Data.Aeson.Encoding.text "allocated"
        TaskStatePending -> Data.Aeson.Encoding.text "pending"
        TaskStateAssigned -> Data.Aeson.Encoding.text "assigned"
        TaskStateAccepted -> Data.Aeson.Encoding.text "accepted"
        TaskStatePreparing -> Data.Aeson.Encoding.text "preparing"
        TaskStateReady -> Data.Aeson.Encoding.text "ready"
        TaskStateStarting -> Data.Aeson.Encoding.text "starting"
        TaskStateRunning -> Data.Aeson.Encoding.text "running"
        TaskStateComplete -> Data.Aeson.Encoding.text "complete"
        TaskStateShutdown -> Data.Aeson.Encoding.text "shutdown"
        TaskStateFailed -> Data.Aeson.Encoding.text "failed"
        TaskStateRejected -> Data.Aeson.Encoding.text "rejected"
        TaskStateRemove -> Data.Aeson.Encoding.text "remove"
        TaskStateOrphaned -> Data.Aeson.Encoding.text "orphaned"

instance Data.Aeson.FromJSON TaskState where
    parseJSON = Data.Aeson.withText "TaskState" $ \s ->
        case s of
            "new" -> pure TaskStateNew
            "allocated" -> pure TaskStateAllocated
            "pending" -> pure TaskStatePending
            "assigned" -> pure TaskStateAssigned
            "accepted" -> pure TaskStateAccepted
            "preparing" -> pure TaskStatePreparing
            "ready" -> pure TaskStateReady
            "starting" -> pure TaskStateStarting
            "running" -> pure TaskStateRunning
            "complete" -> pure TaskStateComplete
            "shutdown" -> pure TaskStateShutdown
            "failed" -> pure TaskStateFailed
            "rejected" -> pure TaskStateRejected
            "remove" -> pure TaskStateRemove
            "orphaned" -> pure TaskStateOrphaned
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData TaskState where
    toQueryParam x = case x of
        TaskStateNew -> "new"
        TaskStateAllocated -> "allocated"
        TaskStatePending -> "pending"
        TaskStateAssigned -> "assigned"
        TaskStateAccepted -> "accepted"
        TaskStatePreparing -> "preparing"
        TaskStateReady -> "ready"
        TaskStateStarting -> "starting"
        TaskStateRunning -> "running"
        TaskStateComplete -> "complete"
        TaskStateShutdown -> "shutdown"
        TaskStateFailed -> "failed"
        TaskStateRejected -> "rejected"
        TaskStateRemove -> "remove"
        TaskStateOrphaned -> "orphaned"

instance Web.HttpApiData.FromHttpApiData TaskState where
    parseUrlPiece x =
        case x of
            "new" -> pure TaskStateNew
            "allocated" -> pure TaskStateAllocated
            "pending" -> pure TaskStatePending
            "assigned" -> pure TaskStateAssigned
            "accepted" -> pure TaskStateAccepted
            "preparing" -> pure TaskStatePreparing
            "ready" -> pure TaskStateReady
            "starting" -> pure TaskStateStarting
            "running" -> pure TaskStateRunning
            "complete" -> pure TaskStateComplete
            "shutdown" -> pure TaskStateShutdown
            "failed" -> pure TaskStateFailed
            "rejected" -> pure TaskStateRejected
            "remove" -> pure TaskStateRemove
            "orphaned" -> pure TaskStateOrphaned
            _ -> Left "invalid enum value"