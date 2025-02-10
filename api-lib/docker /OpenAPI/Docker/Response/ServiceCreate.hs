{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ServiceCreate where

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
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.NetworkAttachmentConfig
import OpenAPI.Docker.Schemas.ServiceCreateResponse
import OpenAPI.Docker.Schemas.ServiceSpec
import OpenAPI.Docker.Schemas.TaskSpec

import OpenAPI.Docker.Response

data ServiceCreateRequestBody = ServiceCreateRequestBody
    {
        endpointSpec :: (Data.Maybe.Maybe (EndpointSpec)),
        labels :: (Data.Maybe.Maybe (ServiceCreateRequestBodyLabels)),
        mode :: (Data.Maybe.Maybe (ServiceCreateRequestBodyMode)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        networks :: (Data.Maybe.Maybe ([ NetworkAttachmentConfig ])),
        rollbackConfig :: (Data.Maybe.Maybe (ServiceCreateRequestBodyRollbackConfig)),
        taskTemplate :: (Data.Maybe.Maybe (TaskSpec)),
        updateConfig :: (Data.Maybe.Maybe (ServiceCreateRequestBodyUpdateConfig))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBody where
    toJSON ServiceCreateRequestBody {..} = Data.Aeson.object
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

    toEncoding ServiceCreateRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "EndpointSpec" . Data.Aeson.toEncoding) endpointSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Networks" . Data.Aeson.toEncoding) networks <>
          maybe mempty (Data.Aeson.Encoding.pair "RollbackConfig" . Data.Aeson.toEncoding) rollbackConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "TaskTemplate" . Data.Aeson.toEncoding) taskTemplate <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdateConfig" . Data.Aeson.toEncoding) updateConfig
        )

instance Data.Aeson.FromJSON ServiceCreateRequestBody where
    parseJSON = Data.Aeson.withObject "ServiceCreateRequestBody" $ \o ->
        ServiceCreateRequestBody
            <$> o Data.Aeson..:? "EndpointSpec"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Networks"
            <*> o Data.Aeson..:? "RollbackConfig"
            <*> o Data.Aeson..:? "TaskTemplate"
            <*> o Data.Aeson..:? "UpdateConfig"

newtype ServiceCreateRequestBodyLabels = ServiceCreateRequestBodyLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyLabels where
    toJSON (ServiceCreateRequestBodyLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ServiceCreateRequestBodyLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ServiceCreateRequestBodyLabels where
    parseJSON x =
        ServiceCreateRequestBodyLabels <$> Data.Aeson.parseJSON x

data ServiceCreateRequestBodyMode = ServiceCreateRequestBodyMode
    {
        global :: (Data.Maybe.Maybe (ServiceCreateRequestBodyModeGlobal)),
        globalJob :: (Data.Maybe.Maybe (ServiceCreateRequestBodyModeGlobalJob)),
        replicated :: (Data.Maybe.Maybe (ServiceCreateRequestBodyModeReplicated)),
        replicatedJob :: (Data.Maybe.Maybe (ServiceCreateRequestBodyModeReplicatedJob))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyMode where
    toJSON ServiceCreateRequestBodyMode {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Global" Data.Aeson..= global | Just global <- [global] ]
        ++ [ "GlobalJob" Data.Aeson..= globalJob | Just globalJob <- [globalJob] ]
        ++ [ "Replicated" Data.Aeson..= replicated | Just replicated <- [replicated] ]
        ++ [ "ReplicatedJob" Data.Aeson..= replicatedJob | Just replicatedJob <- [replicatedJob] ])

    toEncoding ServiceCreateRequestBodyMode {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Global" . Data.Aeson.toEncoding) global <>
          maybe mempty (Data.Aeson.Encoding.pair "GlobalJob" . Data.Aeson.toEncoding) globalJob <>
          maybe mempty (Data.Aeson.Encoding.pair "Replicated" . Data.Aeson.toEncoding) replicated <>
          maybe mempty (Data.Aeson.Encoding.pair "ReplicatedJob" . Data.Aeson.toEncoding) replicatedJob
        )

instance Data.Aeson.FromJSON ServiceCreateRequestBodyMode where
    parseJSON = Data.Aeson.withObject "ServiceCreateRequestBodyMode" $ \o ->
        ServiceCreateRequestBodyMode
            <$> o Data.Aeson..:? "Global"
            <*> o Data.Aeson..:? "GlobalJob"
            <*> o Data.Aeson..:? "Replicated"
            <*> o Data.Aeson..:? "ReplicatedJob"

data ServiceCreateRequestBodyModeGlobal = ServiceCreateRequestBodyModeGlobal
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyModeGlobal where
    toJSON ServiceCreateRequestBodyModeGlobal {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ServiceCreateRequestBodyModeGlobal {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ServiceCreateRequestBodyModeGlobal where
    parseJSON = Data.Aeson.withObject "ServiceCreateRequestBodyModeGlobal" $ \o ->
        ServiceCreateRequestBodyModeGlobal
            

data ServiceCreateRequestBodyModeGlobalJob = ServiceCreateRequestBodyModeGlobalJob
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyModeGlobalJob where
    toJSON ServiceCreateRequestBodyModeGlobalJob {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ServiceCreateRequestBodyModeGlobalJob {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ServiceCreateRequestBodyModeGlobalJob where
    parseJSON = Data.Aeson.withObject "ServiceCreateRequestBodyModeGlobalJob" $ \o ->
        ServiceCreateRequestBodyModeGlobalJob
            

newtype ServiceCreateRequestBodyModeReplicated = ServiceCreateRequestBodyModeReplicated
    {
        replicas :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyModeReplicated where
    toJSON ServiceCreateRequestBodyModeReplicated {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Replicas" Data.Aeson..= replicas | Just replicas <- [replicas] ])

    toEncoding ServiceCreateRequestBodyModeReplicated {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Replicas" . Data.Aeson.toEncoding) replicas
        )

instance Data.Aeson.FromJSON ServiceCreateRequestBodyModeReplicated where
    parseJSON = Data.Aeson.withObject "ServiceCreateRequestBodyModeReplicated" $ \o ->
        ServiceCreateRequestBodyModeReplicated
            <$> o Data.Aeson..:? "Replicas"

data ServiceCreateRequestBodyModeReplicatedJob = ServiceCreateRequestBodyModeReplicatedJob
    {
        maxConcurrent :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        totalCompletions :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyModeReplicatedJob where
    toJSON ServiceCreateRequestBodyModeReplicatedJob {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "MaxConcurrent" Data.Aeson..= maxConcurrent | Just maxConcurrent <- [maxConcurrent] ]
        ++ [ "TotalCompletions" Data.Aeson..= totalCompletions | Just totalCompletions <- [totalCompletions] ])

    toEncoding ServiceCreateRequestBodyModeReplicatedJob {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "MaxConcurrent" . Data.Aeson.toEncoding) maxConcurrent <>
          maybe mempty (Data.Aeson.Encoding.pair "TotalCompletions" . Data.Aeson.toEncoding) totalCompletions
        )

instance Data.Aeson.FromJSON ServiceCreateRequestBodyModeReplicatedJob where
    parseJSON = Data.Aeson.withObject "ServiceCreateRequestBodyModeReplicatedJob" $ \o ->
        ServiceCreateRequestBodyModeReplicatedJob
            <$> o Data.Aeson..:? "MaxConcurrent"
            <*> o Data.Aeson..:? "TotalCompletions"

data ServiceCreateRequestBodyRollbackConfig = ServiceCreateRequestBodyRollbackConfig
    {
        delay :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        failureAction :: (Data.Maybe.Maybe (ServiceCreateRequestBodyRollbackConfigFailureAction)),
        maxFailureRatio :: (Data.Maybe.Maybe (GHC.Float.Double)),
        monitor :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        order :: (Data.Maybe.Maybe (ServiceCreateRequestBodyRollbackConfigOrder)),
        parallelism :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyRollbackConfig where
    toJSON ServiceCreateRequestBodyRollbackConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Delay" Data.Aeson..= delay | Just delay <- [delay] ]
        ++ [ "FailureAction" Data.Aeson..= failureAction | Just failureAction <- [failureAction] ]
        ++ [ "MaxFailureRatio" Data.Aeson..= maxFailureRatio | Just maxFailureRatio <- [maxFailureRatio] ]
        ++ [ "Monitor" Data.Aeson..= monitor | Just monitor <- [monitor] ]
        ++ [ "Order" Data.Aeson..= order | Just order <- [order] ]
        ++ [ "Parallelism" Data.Aeson..= parallelism | Just parallelism <- [parallelism] ])

    toEncoding ServiceCreateRequestBodyRollbackConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Delay" . Data.Aeson.toEncoding) delay <>
          maybe mempty (Data.Aeson.Encoding.pair "FailureAction" . Data.Aeson.toEncoding) failureAction <>
          maybe mempty (Data.Aeson.Encoding.pair "MaxFailureRatio" . Data.Aeson.toEncoding) maxFailureRatio <>
          maybe mempty (Data.Aeson.Encoding.pair "Monitor" . Data.Aeson.toEncoding) monitor <>
          maybe mempty (Data.Aeson.Encoding.pair "Order" . Data.Aeson.toEncoding) order <>
          maybe mempty (Data.Aeson.Encoding.pair "Parallelism" . Data.Aeson.toEncoding) parallelism
        )

instance Data.Aeson.FromJSON ServiceCreateRequestBodyRollbackConfig where
    parseJSON = Data.Aeson.withObject "ServiceCreateRequestBodyRollbackConfig" $ \o ->
        ServiceCreateRequestBodyRollbackConfig
            <$> o Data.Aeson..:? "Delay"
            <*> o Data.Aeson..:? "FailureAction"
            <*> o Data.Aeson..:? "MaxFailureRatio"
            <*> o Data.Aeson..:? "Monitor"
            <*> o Data.Aeson..:? "Order"
            <*> o Data.Aeson..:? "Parallelism"

data ServiceCreateRequestBodyRollbackConfigFailureAction
    = ServiceCreateRequestBodyRollbackConfigFailureActionContinue
    | ServiceCreateRequestBodyRollbackConfigFailureActionPause
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyRollbackConfigFailureAction where
    toJSON x = case x of
        ServiceCreateRequestBodyRollbackConfigFailureActionContinue -> "continue"
        ServiceCreateRequestBodyRollbackConfigFailureActionPause -> "pause"

    toEncoding x = case x of
        ServiceCreateRequestBodyRollbackConfigFailureActionContinue -> Data.Aeson.Encoding.text "continue"
        ServiceCreateRequestBodyRollbackConfigFailureActionPause -> Data.Aeson.Encoding.text "pause"

instance Data.Aeson.FromJSON ServiceCreateRequestBodyRollbackConfigFailureAction where
    parseJSON = Data.Aeson.withText "ServiceCreateRequestBodyRollbackConfigFailureAction" $ \s ->
        case s of
            "continue" -> pure ServiceCreateRequestBodyRollbackConfigFailureActionContinue
            "pause" -> pure ServiceCreateRequestBodyRollbackConfigFailureActionPause
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceCreateRequestBodyRollbackConfigFailureAction where
    toQueryParam x = case x of
        ServiceCreateRequestBodyRollbackConfigFailureActionContinue -> "continue"
        ServiceCreateRequestBodyRollbackConfigFailureActionPause -> "pause"

instance Web.HttpApiData.FromHttpApiData ServiceCreateRequestBodyRollbackConfigFailureAction where
    parseUrlPiece x =
        case x of
            "continue" -> pure ServiceCreateRequestBodyRollbackConfigFailureActionContinue
            "pause" -> pure ServiceCreateRequestBodyRollbackConfigFailureActionPause
            _ -> Left "invalid enum value"

data ServiceCreateRequestBodyRollbackConfigOrder
    = ServiceCreateRequestBodyRollbackConfigOrderStopFirst
    | ServiceCreateRequestBodyRollbackConfigOrderStartFirst
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyRollbackConfigOrder where
    toJSON x = case x of
        ServiceCreateRequestBodyRollbackConfigOrderStopFirst -> "stop-first"
        ServiceCreateRequestBodyRollbackConfigOrderStartFirst -> "start-first"

    toEncoding x = case x of
        ServiceCreateRequestBodyRollbackConfigOrderStopFirst -> Data.Aeson.Encoding.text "stop-first"
        ServiceCreateRequestBodyRollbackConfigOrderStartFirst -> Data.Aeson.Encoding.text "start-first"

instance Data.Aeson.FromJSON ServiceCreateRequestBodyRollbackConfigOrder where
    parseJSON = Data.Aeson.withText "ServiceCreateRequestBodyRollbackConfigOrder" $ \s ->
        case s of
            "stop-first" -> pure ServiceCreateRequestBodyRollbackConfigOrderStopFirst
            "start-first" -> pure ServiceCreateRequestBodyRollbackConfigOrderStartFirst
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceCreateRequestBodyRollbackConfigOrder where
    toQueryParam x = case x of
        ServiceCreateRequestBodyRollbackConfigOrderStopFirst -> "stop-first"
        ServiceCreateRequestBodyRollbackConfigOrderStartFirst -> "start-first"

instance Web.HttpApiData.FromHttpApiData ServiceCreateRequestBodyRollbackConfigOrder where
    parseUrlPiece x =
        case x of
            "stop-first" -> pure ServiceCreateRequestBodyRollbackConfigOrderStopFirst
            "start-first" -> pure ServiceCreateRequestBodyRollbackConfigOrderStartFirst
            _ -> Left "invalid enum value"

data ServiceCreateRequestBodyUpdateConfig = ServiceCreateRequestBodyUpdateConfig
    {
        delay :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        failureAction :: (Data.Maybe.Maybe (ServiceCreateRequestBodyUpdateConfigFailureAction)),
        maxFailureRatio :: (Data.Maybe.Maybe (GHC.Float.Double)),
        monitor :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        order :: (Data.Maybe.Maybe (ServiceCreateRequestBodyUpdateConfigOrder)),
        parallelism :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyUpdateConfig where
    toJSON ServiceCreateRequestBodyUpdateConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Delay" Data.Aeson..= delay | Just delay <- [delay] ]
        ++ [ "FailureAction" Data.Aeson..= failureAction | Just failureAction <- [failureAction] ]
        ++ [ "MaxFailureRatio" Data.Aeson..= maxFailureRatio | Just maxFailureRatio <- [maxFailureRatio] ]
        ++ [ "Monitor" Data.Aeson..= monitor | Just monitor <- [monitor] ]
        ++ [ "Order" Data.Aeson..= order | Just order <- [order] ]
        ++ [ "Parallelism" Data.Aeson..= parallelism | Just parallelism <- [parallelism] ])

    toEncoding ServiceCreateRequestBodyUpdateConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Delay" . Data.Aeson.toEncoding) delay <>
          maybe mempty (Data.Aeson.Encoding.pair "FailureAction" . Data.Aeson.toEncoding) failureAction <>
          maybe mempty (Data.Aeson.Encoding.pair "MaxFailureRatio" . Data.Aeson.toEncoding) maxFailureRatio <>
          maybe mempty (Data.Aeson.Encoding.pair "Monitor" . Data.Aeson.toEncoding) monitor <>
          maybe mempty (Data.Aeson.Encoding.pair "Order" . Data.Aeson.toEncoding) order <>
          maybe mempty (Data.Aeson.Encoding.pair "Parallelism" . Data.Aeson.toEncoding) parallelism
        )

instance Data.Aeson.FromJSON ServiceCreateRequestBodyUpdateConfig where
    parseJSON = Data.Aeson.withObject "ServiceCreateRequestBodyUpdateConfig" $ \o ->
        ServiceCreateRequestBodyUpdateConfig
            <$> o Data.Aeson..:? "Delay"
            <*> o Data.Aeson..:? "FailureAction"
            <*> o Data.Aeson..:? "MaxFailureRatio"
            <*> o Data.Aeson..:? "Monitor"
            <*> o Data.Aeson..:? "Order"
            <*> o Data.Aeson..:? "Parallelism"

data ServiceCreateRequestBodyUpdateConfigFailureAction
    = ServiceCreateRequestBodyUpdateConfigFailureActionContinue
    | ServiceCreateRequestBodyUpdateConfigFailureActionPause
    | ServiceCreateRequestBodyUpdateConfigFailureActionRollback
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyUpdateConfigFailureAction where
    toJSON x = case x of
        ServiceCreateRequestBodyUpdateConfigFailureActionContinue -> "continue"
        ServiceCreateRequestBodyUpdateConfigFailureActionPause -> "pause"
        ServiceCreateRequestBodyUpdateConfigFailureActionRollback -> "rollback"

    toEncoding x = case x of
        ServiceCreateRequestBodyUpdateConfigFailureActionContinue -> Data.Aeson.Encoding.text "continue"
        ServiceCreateRequestBodyUpdateConfigFailureActionPause -> Data.Aeson.Encoding.text "pause"
        ServiceCreateRequestBodyUpdateConfigFailureActionRollback -> Data.Aeson.Encoding.text "rollback"

instance Data.Aeson.FromJSON ServiceCreateRequestBodyUpdateConfigFailureAction where
    parseJSON = Data.Aeson.withText "ServiceCreateRequestBodyUpdateConfigFailureAction" $ \s ->
        case s of
            "continue" -> pure ServiceCreateRequestBodyUpdateConfigFailureActionContinue
            "pause" -> pure ServiceCreateRequestBodyUpdateConfigFailureActionPause
            "rollback" -> pure ServiceCreateRequestBodyUpdateConfigFailureActionRollback
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceCreateRequestBodyUpdateConfigFailureAction where
    toQueryParam x = case x of
        ServiceCreateRequestBodyUpdateConfigFailureActionContinue -> "continue"
        ServiceCreateRequestBodyUpdateConfigFailureActionPause -> "pause"
        ServiceCreateRequestBodyUpdateConfigFailureActionRollback -> "rollback"

instance Web.HttpApiData.FromHttpApiData ServiceCreateRequestBodyUpdateConfigFailureAction where
    parseUrlPiece x =
        case x of
            "continue" -> pure ServiceCreateRequestBodyUpdateConfigFailureActionContinue
            "pause" -> pure ServiceCreateRequestBodyUpdateConfigFailureActionPause
            "rollback" -> pure ServiceCreateRequestBodyUpdateConfigFailureActionRollback
            _ -> Left "invalid enum value"

data ServiceCreateRequestBodyUpdateConfigOrder
    = ServiceCreateRequestBodyUpdateConfigOrderStopFirst
    | ServiceCreateRequestBodyUpdateConfigOrderStartFirst
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceCreateRequestBodyUpdateConfigOrder where
    toJSON x = case x of
        ServiceCreateRequestBodyUpdateConfigOrderStopFirst -> "stop-first"
        ServiceCreateRequestBodyUpdateConfigOrderStartFirst -> "start-first"

    toEncoding x = case x of
        ServiceCreateRequestBodyUpdateConfigOrderStopFirst -> Data.Aeson.Encoding.text "stop-first"
        ServiceCreateRequestBodyUpdateConfigOrderStartFirst -> Data.Aeson.Encoding.text "start-first"

instance Data.Aeson.FromJSON ServiceCreateRequestBodyUpdateConfigOrder where
    parseJSON = Data.Aeson.withText "ServiceCreateRequestBodyUpdateConfigOrder" $ \s ->
        case s of
            "stop-first" -> pure ServiceCreateRequestBodyUpdateConfigOrderStopFirst
            "start-first" -> pure ServiceCreateRequestBodyUpdateConfigOrderStartFirst
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceCreateRequestBodyUpdateConfigOrder where
    toQueryParam x = case x of
        ServiceCreateRequestBodyUpdateConfigOrderStopFirst -> "stop-first"
        ServiceCreateRequestBodyUpdateConfigOrderStartFirst -> "start-first"

instance Web.HttpApiData.FromHttpApiData ServiceCreateRequestBodyUpdateConfigOrder where
    parseUrlPiece x =
        case x of
            "stop-first" -> pure ServiceCreateRequestBodyUpdateConfigOrderStopFirst
            "start-first" -> pure ServiceCreateRequestBodyUpdateConfigOrderStartFirst
            _ -> Left "invalid enum value"

data ServiceCreateResponse
    = ServiceCreateResponse201 ServiceCreateResponse
    | ServiceCreateResponse400 ErrorResponse
    | ServiceCreateResponse403 ErrorResponse
    | ServiceCreateResponse409 ErrorResponse
    | ServiceCreateResponse500 ErrorResponse
    | ServiceCreateResponse503 ErrorResponse
    deriving (Show)

instance ToResponse ServiceCreateResponse where
    toResponse (ServiceCreateResponse201 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status201 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceCreateResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceCreateResponse403 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status403 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceCreateResponse409 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status409 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceCreateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceCreateResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ServiceCreateResponse Network.HTTP.Types.Status where
    getField (ServiceCreateResponse201 {}) = Network.HTTP.Types.status201
    getField (ServiceCreateResponse400 {}) = Network.HTTP.Types.status400
    getField (ServiceCreateResponse403 {}) = Network.HTTP.Types.status403
    getField (ServiceCreateResponse409 {}) = Network.HTTP.Types.status409
    getField (ServiceCreateResponse500 {}) = Network.HTTP.Types.status500
    getField (ServiceCreateResponse503 {}) = Network.HTTP.Types.status503