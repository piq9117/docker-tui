{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ServiceUpdate where

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
import OpenAPI.Docker.Schemas.ServiceSpec
import OpenAPI.Docker.Schemas.ServiceUpdateResponse
import OpenAPI.Docker.Schemas.TaskSpec

import OpenAPI.Docker.Response

data ServiceUpdateRegistryAuthFromParam
    = ServiceUpdateRegistryAuthFromParamSpec
    | ServiceUpdateRegistryAuthFromParamPreviousSpec
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceUpdateRegistryAuthFromParam where
    toJSON x = case x of
        ServiceUpdateRegistryAuthFromParamSpec -> "spec"
        ServiceUpdateRegistryAuthFromParamPreviousSpec -> "previous-spec"

    toEncoding x = case x of
        ServiceUpdateRegistryAuthFromParamSpec -> Data.Aeson.Encoding.text "spec"
        ServiceUpdateRegistryAuthFromParamPreviousSpec -> Data.Aeson.Encoding.text "previous-spec"

instance Data.Aeson.FromJSON ServiceUpdateRegistryAuthFromParam where
    parseJSON = Data.Aeson.withText "ServiceUpdateRegistryAuthFromParam" $ \s ->
        case s of
            "spec" -> pure ServiceUpdateRegistryAuthFromParamSpec
            "previous-spec" -> pure ServiceUpdateRegistryAuthFromParamPreviousSpec
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceUpdateRegistryAuthFromParam where
    toQueryParam x = case x of
        ServiceUpdateRegistryAuthFromParamSpec -> "spec"
        ServiceUpdateRegistryAuthFromParamPreviousSpec -> "previous-spec"

instance Web.HttpApiData.FromHttpApiData ServiceUpdateRegistryAuthFromParam where
    parseUrlPiece x =
        case x of
            "spec" -> pure ServiceUpdateRegistryAuthFromParamSpec
            "previous-spec" -> pure ServiceUpdateRegistryAuthFromParamPreviousSpec
            _ -> Left "invalid enum value"

data ServiceUpdateRequestBody = ServiceUpdateRequestBody
    {
        endpointSpec :: (Data.Maybe.Maybe (EndpointSpec)),
        labels :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyLabels)),
        mode :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyMode)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        networks :: (Data.Maybe.Maybe ([ NetworkAttachmentConfig ])),
        rollbackConfig :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyRollbackConfig)),
        taskTemplate :: (Data.Maybe.Maybe (TaskSpec)),
        updateConfig :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyUpdateConfig))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBody where
    toJSON ServiceUpdateRequestBody {..} = Data.Aeson.object
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

    toEncoding ServiceUpdateRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "EndpointSpec" . Data.Aeson.toEncoding) endpointSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Networks" . Data.Aeson.toEncoding) networks <>
          maybe mempty (Data.Aeson.Encoding.pair "RollbackConfig" . Data.Aeson.toEncoding) rollbackConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "TaskTemplate" . Data.Aeson.toEncoding) taskTemplate <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdateConfig" . Data.Aeson.toEncoding) updateConfig
        )

instance Data.Aeson.FromJSON ServiceUpdateRequestBody where
    parseJSON = Data.Aeson.withObject "ServiceUpdateRequestBody" $ \o ->
        ServiceUpdateRequestBody
            <$> o Data.Aeson..:? "EndpointSpec"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Networks"
            <*> o Data.Aeson..:? "RollbackConfig"
            <*> o Data.Aeson..:? "TaskTemplate"
            <*> o Data.Aeson..:? "UpdateConfig"

newtype ServiceUpdateRequestBodyLabels = ServiceUpdateRequestBodyLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyLabels where
    toJSON (ServiceUpdateRequestBodyLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ServiceUpdateRequestBodyLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyLabels where
    parseJSON x =
        ServiceUpdateRequestBodyLabels <$> Data.Aeson.parseJSON x

data ServiceUpdateRequestBodyMode = ServiceUpdateRequestBodyMode
    {
        global :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyModeGlobal)),
        globalJob :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyModeGlobalJob)),
        replicated :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyModeReplicated)),
        replicatedJob :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyModeReplicatedJob))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyMode where
    toJSON ServiceUpdateRequestBodyMode {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Global" Data.Aeson..= global | Just global <- [global] ]
        ++ [ "GlobalJob" Data.Aeson..= globalJob | Just globalJob <- [globalJob] ]
        ++ [ "Replicated" Data.Aeson..= replicated | Just replicated <- [replicated] ]
        ++ [ "ReplicatedJob" Data.Aeson..= replicatedJob | Just replicatedJob <- [replicatedJob] ])

    toEncoding ServiceUpdateRequestBodyMode {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Global" . Data.Aeson.toEncoding) global <>
          maybe mempty (Data.Aeson.Encoding.pair "GlobalJob" . Data.Aeson.toEncoding) globalJob <>
          maybe mempty (Data.Aeson.Encoding.pair "Replicated" . Data.Aeson.toEncoding) replicated <>
          maybe mempty (Data.Aeson.Encoding.pair "ReplicatedJob" . Data.Aeson.toEncoding) replicatedJob
        )

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyMode where
    parseJSON = Data.Aeson.withObject "ServiceUpdateRequestBodyMode" $ \o ->
        ServiceUpdateRequestBodyMode
            <$> o Data.Aeson..:? "Global"
            <*> o Data.Aeson..:? "GlobalJob"
            <*> o Data.Aeson..:? "Replicated"
            <*> o Data.Aeson..:? "ReplicatedJob"

data ServiceUpdateRequestBodyModeGlobal = ServiceUpdateRequestBodyModeGlobal
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyModeGlobal where
    toJSON ServiceUpdateRequestBodyModeGlobal {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ServiceUpdateRequestBodyModeGlobal {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyModeGlobal where
    parseJSON = Data.Aeson.withObject "ServiceUpdateRequestBodyModeGlobal" $ \o ->
        ServiceUpdateRequestBodyModeGlobal
            

data ServiceUpdateRequestBodyModeGlobalJob = ServiceUpdateRequestBodyModeGlobalJob
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyModeGlobalJob where
    toJSON ServiceUpdateRequestBodyModeGlobalJob {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ServiceUpdateRequestBodyModeGlobalJob {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyModeGlobalJob where
    parseJSON = Data.Aeson.withObject "ServiceUpdateRequestBodyModeGlobalJob" $ \o ->
        ServiceUpdateRequestBodyModeGlobalJob
            

newtype ServiceUpdateRequestBodyModeReplicated = ServiceUpdateRequestBodyModeReplicated
    {
        replicas :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyModeReplicated where
    toJSON ServiceUpdateRequestBodyModeReplicated {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Replicas" Data.Aeson..= replicas | Just replicas <- [replicas] ])

    toEncoding ServiceUpdateRequestBodyModeReplicated {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Replicas" . Data.Aeson.toEncoding) replicas
        )

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyModeReplicated where
    parseJSON = Data.Aeson.withObject "ServiceUpdateRequestBodyModeReplicated" $ \o ->
        ServiceUpdateRequestBodyModeReplicated
            <$> o Data.Aeson..:? "Replicas"

data ServiceUpdateRequestBodyModeReplicatedJob = ServiceUpdateRequestBodyModeReplicatedJob
    {
        maxConcurrent :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        totalCompletions :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyModeReplicatedJob where
    toJSON ServiceUpdateRequestBodyModeReplicatedJob {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "MaxConcurrent" Data.Aeson..= maxConcurrent | Just maxConcurrent <- [maxConcurrent] ]
        ++ [ "TotalCompletions" Data.Aeson..= totalCompletions | Just totalCompletions <- [totalCompletions] ])

    toEncoding ServiceUpdateRequestBodyModeReplicatedJob {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "MaxConcurrent" . Data.Aeson.toEncoding) maxConcurrent <>
          maybe mempty (Data.Aeson.Encoding.pair "TotalCompletions" . Data.Aeson.toEncoding) totalCompletions
        )

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyModeReplicatedJob where
    parseJSON = Data.Aeson.withObject "ServiceUpdateRequestBodyModeReplicatedJob" $ \o ->
        ServiceUpdateRequestBodyModeReplicatedJob
            <$> o Data.Aeson..:? "MaxConcurrent"
            <*> o Data.Aeson..:? "TotalCompletions"

data ServiceUpdateRequestBodyRollbackConfig = ServiceUpdateRequestBodyRollbackConfig
    {
        delay :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        failureAction :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyRollbackConfigFailureAction)),
        maxFailureRatio :: (Data.Maybe.Maybe (GHC.Float.Double)),
        monitor :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        order :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyRollbackConfigOrder)),
        parallelism :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyRollbackConfig where
    toJSON ServiceUpdateRequestBodyRollbackConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Delay" Data.Aeson..= delay | Just delay <- [delay] ]
        ++ [ "FailureAction" Data.Aeson..= failureAction | Just failureAction <- [failureAction] ]
        ++ [ "MaxFailureRatio" Data.Aeson..= maxFailureRatio | Just maxFailureRatio <- [maxFailureRatio] ]
        ++ [ "Monitor" Data.Aeson..= monitor | Just monitor <- [monitor] ]
        ++ [ "Order" Data.Aeson..= order | Just order <- [order] ]
        ++ [ "Parallelism" Data.Aeson..= parallelism | Just parallelism <- [parallelism] ])

    toEncoding ServiceUpdateRequestBodyRollbackConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Delay" . Data.Aeson.toEncoding) delay <>
          maybe mempty (Data.Aeson.Encoding.pair "FailureAction" . Data.Aeson.toEncoding) failureAction <>
          maybe mempty (Data.Aeson.Encoding.pair "MaxFailureRatio" . Data.Aeson.toEncoding) maxFailureRatio <>
          maybe mempty (Data.Aeson.Encoding.pair "Monitor" . Data.Aeson.toEncoding) monitor <>
          maybe mempty (Data.Aeson.Encoding.pair "Order" . Data.Aeson.toEncoding) order <>
          maybe mempty (Data.Aeson.Encoding.pair "Parallelism" . Data.Aeson.toEncoding) parallelism
        )

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyRollbackConfig where
    parseJSON = Data.Aeson.withObject "ServiceUpdateRequestBodyRollbackConfig" $ \o ->
        ServiceUpdateRequestBodyRollbackConfig
            <$> o Data.Aeson..:? "Delay"
            <*> o Data.Aeson..:? "FailureAction"
            <*> o Data.Aeson..:? "MaxFailureRatio"
            <*> o Data.Aeson..:? "Monitor"
            <*> o Data.Aeson..:? "Order"
            <*> o Data.Aeson..:? "Parallelism"

data ServiceUpdateRequestBodyRollbackConfigFailureAction
    = ServiceUpdateRequestBodyRollbackConfigFailureActionContinue
    | ServiceUpdateRequestBodyRollbackConfigFailureActionPause
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyRollbackConfigFailureAction where
    toJSON x = case x of
        ServiceUpdateRequestBodyRollbackConfigFailureActionContinue -> "continue"
        ServiceUpdateRequestBodyRollbackConfigFailureActionPause -> "pause"

    toEncoding x = case x of
        ServiceUpdateRequestBodyRollbackConfigFailureActionContinue -> Data.Aeson.Encoding.text "continue"
        ServiceUpdateRequestBodyRollbackConfigFailureActionPause -> Data.Aeson.Encoding.text "pause"

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyRollbackConfigFailureAction where
    parseJSON = Data.Aeson.withText "ServiceUpdateRequestBodyRollbackConfigFailureAction" $ \s ->
        case s of
            "continue" -> pure ServiceUpdateRequestBodyRollbackConfigFailureActionContinue
            "pause" -> pure ServiceUpdateRequestBodyRollbackConfigFailureActionPause
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceUpdateRequestBodyRollbackConfigFailureAction where
    toQueryParam x = case x of
        ServiceUpdateRequestBodyRollbackConfigFailureActionContinue -> "continue"
        ServiceUpdateRequestBodyRollbackConfigFailureActionPause -> "pause"

instance Web.HttpApiData.FromHttpApiData ServiceUpdateRequestBodyRollbackConfigFailureAction where
    parseUrlPiece x =
        case x of
            "continue" -> pure ServiceUpdateRequestBodyRollbackConfigFailureActionContinue
            "pause" -> pure ServiceUpdateRequestBodyRollbackConfigFailureActionPause
            _ -> Left "invalid enum value"

data ServiceUpdateRequestBodyRollbackConfigOrder
    = ServiceUpdateRequestBodyRollbackConfigOrderStopFirst
    | ServiceUpdateRequestBodyRollbackConfigOrderStartFirst
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyRollbackConfigOrder where
    toJSON x = case x of
        ServiceUpdateRequestBodyRollbackConfigOrderStopFirst -> "stop-first"
        ServiceUpdateRequestBodyRollbackConfigOrderStartFirst -> "start-first"

    toEncoding x = case x of
        ServiceUpdateRequestBodyRollbackConfigOrderStopFirst -> Data.Aeson.Encoding.text "stop-first"
        ServiceUpdateRequestBodyRollbackConfigOrderStartFirst -> Data.Aeson.Encoding.text "start-first"

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyRollbackConfigOrder where
    parseJSON = Data.Aeson.withText "ServiceUpdateRequestBodyRollbackConfigOrder" $ \s ->
        case s of
            "stop-first" -> pure ServiceUpdateRequestBodyRollbackConfigOrderStopFirst
            "start-first" -> pure ServiceUpdateRequestBodyRollbackConfigOrderStartFirst
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceUpdateRequestBodyRollbackConfigOrder where
    toQueryParam x = case x of
        ServiceUpdateRequestBodyRollbackConfigOrderStopFirst -> "stop-first"
        ServiceUpdateRequestBodyRollbackConfigOrderStartFirst -> "start-first"

instance Web.HttpApiData.FromHttpApiData ServiceUpdateRequestBodyRollbackConfigOrder where
    parseUrlPiece x =
        case x of
            "stop-first" -> pure ServiceUpdateRequestBodyRollbackConfigOrderStopFirst
            "start-first" -> pure ServiceUpdateRequestBodyRollbackConfigOrderStartFirst
            _ -> Left "invalid enum value"

data ServiceUpdateRequestBodyUpdateConfig = ServiceUpdateRequestBodyUpdateConfig
    {
        delay :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        failureAction :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyUpdateConfigFailureAction)),
        maxFailureRatio :: (Data.Maybe.Maybe (GHC.Float.Double)),
        monitor :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        order :: (Data.Maybe.Maybe (ServiceUpdateRequestBodyUpdateConfigOrder)),
        parallelism :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyUpdateConfig where
    toJSON ServiceUpdateRequestBodyUpdateConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Delay" Data.Aeson..= delay | Just delay <- [delay] ]
        ++ [ "FailureAction" Data.Aeson..= failureAction | Just failureAction <- [failureAction] ]
        ++ [ "MaxFailureRatio" Data.Aeson..= maxFailureRatio | Just maxFailureRatio <- [maxFailureRatio] ]
        ++ [ "Monitor" Data.Aeson..= monitor | Just monitor <- [monitor] ]
        ++ [ "Order" Data.Aeson..= order | Just order <- [order] ]
        ++ [ "Parallelism" Data.Aeson..= parallelism | Just parallelism <- [parallelism] ])

    toEncoding ServiceUpdateRequestBodyUpdateConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Delay" . Data.Aeson.toEncoding) delay <>
          maybe mempty (Data.Aeson.Encoding.pair "FailureAction" . Data.Aeson.toEncoding) failureAction <>
          maybe mempty (Data.Aeson.Encoding.pair "MaxFailureRatio" . Data.Aeson.toEncoding) maxFailureRatio <>
          maybe mempty (Data.Aeson.Encoding.pair "Monitor" . Data.Aeson.toEncoding) monitor <>
          maybe mempty (Data.Aeson.Encoding.pair "Order" . Data.Aeson.toEncoding) order <>
          maybe mempty (Data.Aeson.Encoding.pair "Parallelism" . Data.Aeson.toEncoding) parallelism
        )

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyUpdateConfig where
    parseJSON = Data.Aeson.withObject "ServiceUpdateRequestBodyUpdateConfig" $ \o ->
        ServiceUpdateRequestBodyUpdateConfig
            <$> o Data.Aeson..:? "Delay"
            <*> o Data.Aeson..:? "FailureAction"
            <*> o Data.Aeson..:? "MaxFailureRatio"
            <*> o Data.Aeson..:? "Monitor"
            <*> o Data.Aeson..:? "Order"
            <*> o Data.Aeson..:? "Parallelism"

data ServiceUpdateRequestBodyUpdateConfigFailureAction
    = ServiceUpdateRequestBodyUpdateConfigFailureActionContinue
    | ServiceUpdateRequestBodyUpdateConfigFailureActionPause
    | ServiceUpdateRequestBodyUpdateConfigFailureActionRollback
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyUpdateConfigFailureAction where
    toJSON x = case x of
        ServiceUpdateRequestBodyUpdateConfigFailureActionContinue -> "continue"
        ServiceUpdateRequestBodyUpdateConfigFailureActionPause -> "pause"
        ServiceUpdateRequestBodyUpdateConfigFailureActionRollback -> "rollback"

    toEncoding x = case x of
        ServiceUpdateRequestBodyUpdateConfigFailureActionContinue -> Data.Aeson.Encoding.text "continue"
        ServiceUpdateRequestBodyUpdateConfigFailureActionPause -> Data.Aeson.Encoding.text "pause"
        ServiceUpdateRequestBodyUpdateConfigFailureActionRollback -> Data.Aeson.Encoding.text "rollback"

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyUpdateConfigFailureAction where
    parseJSON = Data.Aeson.withText "ServiceUpdateRequestBodyUpdateConfigFailureAction" $ \s ->
        case s of
            "continue" -> pure ServiceUpdateRequestBodyUpdateConfigFailureActionContinue
            "pause" -> pure ServiceUpdateRequestBodyUpdateConfigFailureActionPause
            "rollback" -> pure ServiceUpdateRequestBodyUpdateConfigFailureActionRollback
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceUpdateRequestBodyUpdateConfigFailureAction where
    toQueryParam x = case x of
        ServiceUpdateRequestBodyUpdateConfigFailureActionContinue -> "continue"
        ServiceUpdateRequestBodyUpdateConfigFailureActionPause -> "pause"
        ServiceUpdateRequestBodyUpdateConfigFailureActionRollback -> "rollback"

instance Web.HttpApiData.FromHttpApiData ServiceUpdateRequestBodyUpdateConfigFailureAction where
    parseUrlPiece x =
        case x of
            "continue" -> pure ServiceUpdateRequestBodyUpdateConfigFailureActionContinue
            "pause" -> pure ServiceUpdateRequestBodyUpdateConfigFailureActionPause
            "rollback" -> pure ServiceUpdateRequestBodyUpdateConfigFailureActionRollback
            _ -> Left "invalid enum value"

data ServiceUpdateRequestBodyUpdateConfigOrder
    = ServiceUpdateRequestBodyUpdateConfigOrderStopFirst
    | ServiceUpdateRequestBodyUpdateConfigOrderStartFirst
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceUpdateRequestBodyUpdateConfigOrder where
    toJSON x = case x of
        ServiceUpdateRequestBodyUpdateConfigOrderStopFirst -> "stop-first"
        ServiceUpdateRequestBodyUpdateConfigOrderStartFirst -> "start-first"

    toEncoding x = case x of
        ServiceUpdateRequestBodyUpdateConfigOrderStopFirst -> Data.Aeson.Encoding.text "stop-first"
        ServiceUpdateRequestBodyUpdateConfigOrderStartFirst -> Data.Aeson.Encoding.text "start-first"

instance Data.Aeson.FromJSON ServiceUpdateRequestBodyUpdateConfigOrder where
    parseJSON = Data.Aeson.withText "ServiceUpdateRequestBodyUpdateConfigOrder" $ \s ->
        case s of
            "stop-first" -> pure ServiceUpdateRequestBodyUpdateConfigOrderStopFirst
            "start-first" -> pure ServiceUpdateRequestBodyUpdateConfigOrderStartFirst
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceUpdateRequestBodyUpdateConfigOrder where
    toQueryParam x = case x of
        ServiceUpdateRequestBodyUpdateConfigOrderStopFirst -> "stop-first"
        ServiceUpdateRequestBodyUpdateConfigOrderStartFirst -> "start-first"

instance Web.HttpApiData.FromHttpApiData ServiceUpdateRequestBodyUpdateConfigOrder where
    parseUrlPiece x =
        case x of
            "stop-first" -> pure ServiceUpdateRequestBodyUpdateConfigOrderStopFirst
            "start-first" -> pure ServiceUpdateRequestBodyUpdateConfigOrderStartFirst
            _ -> Left "invalid enum value"

data ServiceUpdateResponse
    = ServiceUpdateResponse200 ServiceUpdateResponse
    | ServiceUpdateResponse400 ErrorResponse
    | ServiceUpdateResponse404 ErrorResponse
    | ServiceUpdateResponse500 ErrorResponse
    | ServiceUpdateResponse503 ErrorResponse
    deriving (Show)

instance ToResponse ServiceUpdateResponse where
    toResponse (ServiceUpdateResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceUpdateResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceUpdateResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceUpdateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ServiceUpdateResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ServiceUpdateResponse Network.HTTP.Types.Status where
    getField (ServiceUpdateResponse200 {}) = Network.HTTP.Types.status200
    getField (ServiceUpdateResponse400 {}) = Network.HTTP.Types.status400
    getField (ServiceUpdateResponse404 {}) = Network.HTTP.Types.status404
    getField (ServiceUpdateResponse500 {}) = Network.HTTP.Types.status500
    getField (ServiceUpdateResponse503 {}) = Network.HTTP.Types.status503