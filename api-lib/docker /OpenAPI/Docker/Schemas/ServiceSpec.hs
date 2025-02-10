{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ServiceSpec where

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



import OpenAPI.Docker.Schemas.EndpointSpec
import OpenAPI.Docker.Schemas.NetworkAttachmentConfig
import OpenAPI.Docker.Schemas.TaskSpec

newtype ServiceSpecLabels = ServiceSpecLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpecLabels where
    toJSON (ServiceSpecLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ServiceSpecLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ServiceSpecLabels where
    parseJSON x =
        ServiceSpecLabels <$> Data.Aeson.parseJSON x

data ServiceSpecMode = ServiceSpecMode
    {
        global :: (Data.Maybe.Maybe (ServiceSpecModeGlobal)),
        globalJob :: (Data.Maybe.Maybe (ServiceSpecModeGlobalJob)),
        replicated :: (Data.Maybe.Maybe (ServiceSpecModeReplicated)),
        replicatedJob :: (Data.Maybe.Maybe (ServiceSpecModeReplicatedJob))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpecMode where
    toJSON ServiceSpecMode {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Global" Data.Aeson..= global | Just global <- [global] ]
        ++ [ "GlobalJob" Data.Aeson..= globalJob | Just globalJob <- [globalJob] ]
        ++ [ "Replicated" Data.Aeson..= replicated | Just replicated <- [replicated] ]
        ++ [ "ReplicatedJob" Data.Aeson..= replicatedJob | Just replicatedJob <- [replicatedJob] ])

    toEncoding ServiceSpecMode {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Global" . Data.Aeson.toEncoding) global <>
          maybe mempty (Data.Aeson.Encoding.pair "GlobalJob" . Data.Aeson.toEncoding) globalJob <>
          maybe mempty (Data.Aeson.Encoding.pair "Replicated" . Data.Aeson.toEncoding) replicated <>
          maybe mempty (Data.Aeson.Encoding.pair "ReplicatedJob" . Data.Aeson.toEncoding) replicatedJob
        )

instance Data.Aeson.FromJSON ServiceSpecMode where
    parseJSON = Data.Aeson.withObject "ServiceSpecMode" $ \o ->
        ServiceSpecMode
            <$> o Data.Aeson..:? "Global"
            <*> o Data.Aeson..:? "GlobalJob"
            <*> o Data.Aeson..:? "Replicated"
            <*> o Data.Aeson..:? "ReplicatedJob"

data ServiceSpecModeGlobal = ServiceSpecModeGlobal
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpecModeGlobal where
    toJSON ServiceSpecModeGlobal {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ServiceSpecModeGlobal {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ServiceSpecModeGlobal where
    parseJSON = Data.Aeson.withObject "ServiceSpecModeGlobal" $ \o ->
        ServiceSpecModeGlobal
            

data ServiceSpecModeGlobalJob = ServiceSpecModeGlobalJob
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpecModeGlobalJob where
    toJSON ServiceSpecModeGlobalJob {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ServiceSpecModeGlobalJob {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ServiceSpecModeGlobalJob where
    parseJSON = Data.Aeson.withObject "ServiceSpecModeGlobalJob" $ \o ->
        ServiceSpecModeGlobalJob
            

newtype ServiceSpecModeReplicated = ServiceSpecModeReplicated
    {
        replicas :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpecModeReplicated where
    toJSON ServiceSpecModeReplicated {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Replicas" Data.Aeson..= replicas | Just replicas <- [replicas] ])

    toEncoding ServiceSpecModeReplicated {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Replicas" . Data.Aeson.toEncoding) replicas
        )

instance Data.Aeson.FromJSON ServiceSpecModeReplicated where
    parseJSON = Data.Aeson.withObject "ServiceSpecModeReplicated" $ \o ->
        ServiceSpecModeReplicated
            <$> o Data.Aeson..:? "Replicas"

data ServiceSpecModeReplicatedJob = ServiceSpecModeReplicatedJob
    {
        maxConcurrent :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        totalCompletions :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpecModeReplicatedJob where
    toJSON ServiceSpecModeReplicatedJob {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "MaxConcurrent" Data.Aeson..= maxConcurrent | Just maxConcurrent <- [maxConcurrent] ]
        ++ [ "TotalCompletions" Data.Aeson..= totalCompletions | Just totalCompletions <- [totalCompletions] ])

    toEncoding ServiceSpecModeReplicatedJob {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "MaxConcurrent" . Data.Aeson.toEncoding) maxConcurrent <>
          maybe mempty (Data.Aeson.Encoding.pair "TotalCompletions" . Data.Aeson.toEncoding) totalCompletions
        )

instance Data.Aeson.FromJSON ServiceSpecModeReplicatedJob where
    parseJSON = Data.Aeson.withObject "ServiceSpecModeReplicatedJob" $ \o ->
        ServiceSpecModeReplicatedJob
            <$> o Data.Aeson..:? "MaxConcurrent"
            <*> o Data.Aeson..:? "TotalCompletions"

data ServiceSpecRollbackConfig = ServiceSpecRollbackConfig
    {
        delay :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        failureAction :: (Data.Maybe.Maybe (ServiceSpecRollbackConfigFailureAction)),
        maxFailureRatio :: (Data.Maybe.Maybe (GHC.Float.Double)),
        monitor :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        order :: (Data.Maybe.Maybe (ServiceSpecRollbackConfigOrder)),
        parallelism :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpecRollbackConfig where
    toJSON ServiceSpecRollbackConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Delay" Data.Aeson..= delay | Just delay <- [delay] ]
        ++ [ "FailureAction" Data.Aeson..= failureAction | Just failureAction <- [failureAction] ]
        ++ [ "MaxFailureRatio" Data.Aeson..= maxFailureRatio | Just maxFailureRatio <- [maxFailureRatio] ]
        ++ [ "Monitor" Data.Aeson..= monitor | Just monitor <- [monitor] ]
        ++ [ "Order" Data.Aeson..= order | Just order <- [order] ]
        ++ [ "Parallelism" Data.Aeson..= parallelism | Just parallelism <- [parallelism] ])

    toEncoding ServiceSpecRollbackConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Delay" . Data.Aeson.toEncoding) delay <>
          maybe mempty (Data.Aeson.Encoding.pair "FailureAction" . Data.Aeson.toEncoding) failureAction <>
          maybe mempty (Data.Aeson.Encoding.pair "MaxFailureRatio" . Data.Aeson.toEncoding) maxFailureRatio <>
          maybe mempty (Data.Aeson.Encoding.pair "Monitor" . Data.Aeson.toEncoding) monitor <>
          maybe mempty (Data.Aeson.Encoding.pair "Order" . Data.Aeson.toEncoding) order <>
          maybe mempty (Data.Aeson.Encoding.pair "Parallelism" . Data.Aeson.toEncoding) parallelism
        )

instance Data.Aeson.FromJSON ServiceSpecRollbackConfig where
    parseJSON = Data.Aeson.withObject "ServiceSpecRollbackConfig" $ \o ->
        ServiceSpecRollbackConfig
            <$> o Data.Aeson..:? "Delay"
            <*> o Data.Aeson..:? "FailureAction"
            <*> o Data.Aeson..:? "MaxFailureRatio"
            <*> o Data.Aeson..:? "Monitor"
            <*> o Data.Aeson..:? "Order"
            <*> o Data.Aeson..:? "Parallelism"

data ServiceSpecRollbackConfigFailureAction
    = ServiceSpecRollbackConfigFailureActionContinue
    | ServiceSpecRollbackConfigFailureActionPause
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceSpecRollbackConfigFailureAction where
    toJSON x = case x of
        ServiceSpecRollbackConfigFailureActionContinue -> "continue"
        ServiceSpecRollbackConfigFailureActionPause -> "pause"

    toEncoding x = case x of
        ServiceSpecRollbackConfigFailureActionContinue -> Data.Aeson.Encoding.text "continue"
        ServiceSpecRollbackConfigFailureActionPause -> Data.Aeson.Encoding.text "pause"

instance Data.Aeson.FromJSON ServiceSpecRollbackConfigFailureAction where
    parseJSON = Data.Aeson.withText "ServiceSpecRollbackConfigFailureAction" $ \s ->
        case s of
            "continue" -> pure ServiceSpecRollbackConfigFailureActionContinue
            "pause" -> pure ServiceSpecRollbackConfigFailureActionPause
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceSpecRollbackConfigFailureAction where
    toQueryParam x = case x of
        ServiceSpecRollbackConfigFailureActionContinue -> "continue"
        ServiceSpecRollbackConfigFailureActionPause -> "pause"

instance Web.HttpApiData.FromHttpApiData ServiceSpecRollbackConfigFailureAction where
    parseUrlPiece x =
        case x of
            "continue" -> pure ServiceSpecRollbackConfigFailureActionContinue
            "pause" -> pure ServiceSpecRollbackConfigFailureActionPause
            _ -> Left "invalid enum value"

data ServiceSpecRollbackConfigOrder
    = ServiceSpecRollbackConfigOrderStopFirst
    | ServiceSpecRollbackConfigOrderStartFirst
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceSpecRollbackConfigOrder where
    toJSON x = case x of
        ServiceSpecRollbackConfigOrderStopFirst -> "stop-first"
        ServiceSpecRollbackConfigOrderStartFirst -> "start-first"

    toEncoding x = case x of
        ServiceSpecRollbackConfigOrderStopFirst -> Data.Aeson.Encoding.text "stop-first"
        ServiceSpecRollbackConfigOrderStartFirst -> Data.Aeson.Encoding.text "start-first"

instance Data.Aeson.FromJSON ServiceSpecRollbackConfigOrder where
    parseJSON = Data.Aeson.withText "ServiceSpecRollbackConfigOrder" $ \s ->
        case s of
            "stop-first" -> pure ServiceSpecRollbackConfigOrderStopFirst
            "start-first" -> pure ServiceSpecRollbackConfigOrderStartFirst
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceSpecRollbackConfigOrder where
    toQueryParam x = case x of
        ServiceSpecRollbackConfigOrderStopFirst -> "stop-first"
        ServiceSpecRollbackConfigOrderStartFirst -> "start-first"

instance Web.HttpApiData.FromHttpApiData ServiceSpecRollbackConfigOrder where
    parseUrlPiece x =
        case x of
            "stop-first" -> pure ServiceSpecRollbackConfigOrderStopFirst
            "start-first" -> pure ServiceSpecRollbackConfigOrderStartFirst
            _ -> Left "invalid enum value"

data ServiceSpecUpdateConfig = ServiceSpecUpdateConfig
    {
        delay :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        failureAction :: (Data.Maybe.Maybe (ServiceSpecUpdateConfigFailureAction)),
        maxFailureRatio :: (Data.Maybe.Maybe (GHC.Float.Double)),
        monitor :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        order :: (Data.Maybe.Maybe (ServiceSpecUpdateConfigOrder)),
        parallelism :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpecUpdateConfig where
    toJSON ServiceSpecUpdateConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Delay" Data.Aeson..= delay | Just delay <- [delay] ]
        ++ [ "FailureAction" Data.Aeson..= failureAction | Just failureAction <- [failureAction] ]
        ++ [ "MaxFailureRatio" Data.Aeson..= maxFailureRatio | Just maxFailureRatio <- [maxFailureRatio] ]
        ++ [ "Monitor" Data.Aeson..= monitor | Just monitor <- [monitor] ]
        ++ [ "Order" Data.Aeson..= order | Just order <- [order] ]
        ++ [ "Parallelism" Data.Aeson..= parallelism | Just parallelism <- [parallelism] ])

    toEncoding ServiceSpecUpdateConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Delay" . Data.Aeson.toEncoding) delay <>
          maybe mempty (Data.Aeson.Encoding.pair "FailureAction" . Data.Aeson.toEncoding) failureAction <>
          maybe mempty (Data.Aeson.Encoding.pair "MaxFailureRatio" . Data.Aeson.toEncoding) maxFailureRatio <>
          maybe mempty (Data.Aeson.Encoding.pair "Monitor" . Data.Aeson.toEncoding) monitor <>
          maybe mempty (Data.Aeson.Encoding.pair "Order" . Data.Aeson.toEncoding) order <>
          maybe mempty (Data.Aeson.Encoding.pair "Parallelism" . Data.Aeson.toEncoding) parallelism
        )

instance Data.Aeson.FromJSON ServiceSpecUpdateConfig where
    parseJSON = Data.Aeson.withObject "ServiceSpecUpdateConfig" $ \o ->
        ServiceSpecUpdateConfig
            <$> o Data.Aeson..:? "Delay"
            <*> o Data.Aeson..:? "FailureAction"
            <*> o Data.Aeson..:? "MaxFailureRatio"
            <*> o Data.Aeson..:? "Monitor"
            <*> o Data.Aeson..:? "Order"
            <*> o Data.Aeson..:? "Parallelism"

data ServiceSpecUpdateConfigFailureAction
    = ServiceSpecUpdateConfigFailureActionContinue
    | ServiceSpecUpdateConfigFailureActionPause
    | ServiceSpecUpdateConfigFailureActionRollback
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceSpecUpdateConfigFailureAction where
    toJSON x = case x of
        ServiceSpecUpdateConfigFailureActionContinue -> "continue"
        ServiceSpecUpdateConfigFailureActionPause -> "pause"
        ServiceSpecUpdateConfigFailureActionRollback -> "rollback"

    toEncoding x = case x of
        ServiceSpecUpdateConfigFailureActionContinue -> Data.Aeson.Encoding.text "continue"
        ServiceSpecUpdateConfigFailureActionPause -> Data.Aeson.Encoding.text "pause"
        ServiceSpecUpdateConfigFailureActionRollback -> Data.Aeson.Encoding.text "rollback"

instance Data.Aeson.FromJSON ServiceSpecUpdateConfigFailureAction where
    parseJSON = Data.Aeson.withText "ServiceSpecUpdateConfigFailureAction" $ \s ->
        case s of
            "continue" -> pure ServiceSpecUpdateConfigFailureActionContinue
            "pause" -> pure ServiceSpecUpdateConfigFailureActionPause
            "rollback" -> pure ServiceSpecUpdateConfigFailureActionRollback
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceSpecUpdateConfigFailureAction where
    toQueryParam x = case x of
        ServiceSpecUpdateConfigFailureActionContinue -> "continue"
        ServiceSpecUpdateConfigFailureActionPause -> "pause"
        ServiceSpecUpdateConfigFailureActionRollback -> "rollback"

instance Web.HttpApiData.FromHttpApiData ServiceSpecUpdateConfigFailureAction where
    parseUrlPiece x =
        case x of
            "continue" -> pure ServiceSpecUpdateConfigFailureActionContinue
            "pause" -> pure ServiceSpecUpdateConfigFailureActionPause
            "rollback" -> pure ServiceSpecUpdateConfigFailureActionRollback
            _ -> Left "invalid enum value"

data ServiceSpecUpdateConfigOrder
    = ServiceSpecUpdateConfigOrderStopFirst
    | ServiceSpecUpdateConfigOrderStartFirst
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceSpecUpdateConfigOrder where
    toJSON x = case x of
        ServiceSpecUpdateConfigOrderStopFirst -> "stop-first"
        ServiceSpecUpdateConfigOrderStartFirst -> "start-first"

    toEncoding x = case x of
        ServiceSpecUpdateConfigOrderStopFirst -> Data.Aeson.Encoding.text "stop-first"
        ServiceSpecUpdateConfigOrderStartFirst -> Data.Aeson.Encoding.text "start-first"

instance Data.Aeson.FromJSON ServiceSpecUpdateConfigOrder where
    parseJSON = Data.Aeson.withText "ServiceSpecUpdateConfigOrder" $ \s ->
        case s of
            "stop-first" -> pure ServiceSpecUpdateConfigOrderStopFirst
            "start-first" -> pure ServiceSpecUpdateConfigOrderStartFirst
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceSpecUpdateConfigOrder where
    toQueryParam x = case x of
        ServiceSpecUpdateConfigOrderStopFirst -> "stop-first"
        ServiceSpecUpdateConfigOrderStartFirst -> "start-first"

instance Web.HttpApiData.FromHttpApiData ServiceSpecUpdateConfigOrder where
    parseUrlPiece x =
        case x of
            "stop-first" -> pure ServiceSpecUpdateConfigOrderStopFirst
            "start-first" -> pure ServiceSpecUpdateConfigOrderStartFirst
            _ -> Left "invalid enum value"

data ServiceSpec = ServiceSpec
    {
        endpointSpec :: (Data.Maybe.Maybe (EndpointSpec)),
        labels :: (Data.Maybe.Maybe (ServiceSpecLabels)),
        mode :: (Data.Maybe.Maybe (ServiceSpecMode)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        networks :: (Data.Maybe.Maybe ([ NetworkAttachmentConfig ])),
        rollbackConfig :: (Data.Maybe.Maybe (ServiceSpecRollbackConfig)),
        taskTemplate :: (Data.Maybe.Maybe (TaskSpec)),
        updateConfig :: (Data.Maybe.Maybe (ServiceSpecUpdateConfig))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceSpec where
    toJSON ServiceSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "EndpointSpec" Data.Aeson..= endpointSpec | Just endpointSpec <- [endpointSpec] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Mode" Data.Aeson..= mode | Just mode <- [mode] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Networks" Data.Aeson..= networks | Just networks <- [networks] ]
        ++ [ "RollbackConfig" Data.Aeson..= rollbackConfig | Just rollbackConfig <- [rollbackConfig] ]
        ++ [ "TaskTemplate" Data.Aeson..= taskTemplate | Just taskTemplate <- [taskTemplate] ]
        ++ [ "UpdateConfig" Data.Aeson..= updateConfig | Just updateConfig <- [updateConfig] ])

    toEncoding ServiceSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "EndpointSpec" . Data.Aeson.toEncoding) endpointSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Networks" . Data.Aeson.toEncoding) networks <>
          maybe mempty (Data.Aeson.Encoding.pair "RollbackConfig" . Data.Aeson.toEncoding) rollbackConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "TaskTemplate" . Data.Aeson.toEncoding) taskTemplate <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdateConfig" . Data.Aeson.toEncoding) updateConfig
        )

instance Data.Aeson.FromJSON ServiceSpec where
    parseJSON = Data.Aeson.withObject "ServiceSpec" $ \o ->
        ServiceSpec
            <$> o Data.Aeson..:? "EndpointSpec"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Networks"
            <*> o Data.Aeson..:? "RollbackConfig"
            <*> o Data.Aeson..:? "TaskTemplate"
            <*> o Data.Aeson..:? "UpdateConfig"