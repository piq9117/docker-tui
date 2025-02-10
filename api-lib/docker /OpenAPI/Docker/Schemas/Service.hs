{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Service where

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



import OpenAPI.Docker.Schemas.EndpointPortConfig
import OpenAPI.Docker.Schemas.EndpointSpec
import OpenAPI.Docker.Schemas.ObjectVersion
import OpenAPI.Docker.Schemas.ServiceSpec

data ServiceEndpoint = ServiceEndpoint
    {
        ports :: (Data.Maybe.Maybe ([ EndpointPortConfig ])),
        spec :: (Data.Maybe.Maybe (EndpointSpec)),
        virtualIPs :: (Data.Maybe.Maybe ([ ServiceEndpointVirtualIPs ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceEndpoint where
    toJSON ServiceEndpoint {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Ports" Data.Aeson..= ports | Just ports <- [ports] ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ]
        ++ [ "VirtualIPs" Data.Aeson..= virtualIPs | Just virtualIPs <- [virtualIPs] ])

    toEncoding ServiceEndpoint {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Ports" . Data.Aeson.toEncoding) ports <>
          maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec <>
          maybe mempty (Data.Aeson.Encoding.pair "VirtualIPs" . Data.Aeson.toEncoding) virtualIPs
        )

instance Data.Aeson.FromJSON ServiceEndpoint where
    parseJSON = Data.Aeson.withObject "ServiceEndpoint" $ \o ->
        ServiceEndpoint
            <$> o Data.Aeson..:? "Ports"
            <*> o Data.Aeson..:? "Spec"
            <*> o Data.Aeson..:? "VirtualIPs"

data ServiceEndpointVirtualIPs = ServiceEndpointVirtualIPs
    {
        addr :: (Data.Maybe.Maybe (Data.Text.Text)),
        networkID :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceEndpointVirtualIPs where
    toJSON ServiceEndpointVirtualIPs {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Addr" Data.Aeson..= addr | Just addr <- [addr] ]
        ++ [ "NetworkID" Data.Aeson..= networkID | Just networkID <- [networkID] ])

    toEncoding ServiceEndpointVirtualIPs {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Addr" . Data.Aeson.toEncoding) addr <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkID" . Data.Aeson.toEncoding) networkID
        )

instance Data.Aeson.FromJSON ServiceEndpointVirtualIPs where
    parseJSON = Data.Aeson.withObject "ServiceEndpointVirtualIPs" $ \o ->
        ServiceEndpointVirtualIPs
            <$> o Data.Aeson..:? "Addr"
            <*> o Data.Aeson..:? "NetworkID"

data ServiceJobStatus = ServiceJobStatus
    {
        jobIteration :: (Data.Maybe.Maybe (ObjectVersion)),
        lastExecution :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceJobStatus where
    toJSON ServiceJobStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "JobIteration" Data.Aeson..= jobIteration | Just jobIteration <- [jobIteration] ]
        ++ [ "LastExecution" Data.Aeson..= lastExecution | Just lastExecution <- [lastExecution] ])

    toEncoding ServiceJobStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "JobIteration" . Data.Aeson.toEncoding) jobIteration <>
          maybe mempty (Data.Aeson.Encoding.pair "LastExecution" . Data.Aeson.toEncoding) lastExecution
        )

instance Data.Aeson.FromJSON ServiceJobStatus where
    parseJSON = Data.Aeson.withObject "ServiceJobStatus" $ \o ->
        ServiceJobStatus
            <$> o Data.Aeson..:? "JobIteration"
            <*> o Data.Aeson..:? "LastExecution"

data ServiceServiceStatus = ServiceServiceStatus
    {
        completedTasks :: (Data.Maybe.Maybe (GHC.Int.Int)),
        desiredTasks :: (Data.Maybe.Maybe (GHC.Int.Int)),
        runningTasks :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceServiceStatus where
    toJSON ServiceServiceStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CompletedTasks" Data.Aeson..= completedTasks | Just completedTasks <- [completedTasks] ]
        ++ [ "DesiredTasks" Data.Aeson..= desiredTasks | Just desiredTasks <- [desiredTasks] ]
        ++ [ "RunningTasks" Data.Aeson..= runningTasks | Just runningTasks <- [runningTasks] ])

    toEncoding ServiceServiceStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CompletedTasks" . Data.Aeson.toEncoding) completedTasks <>
          maybe mempty (Data.Aeson.Encoding.pair "DesiredTasks" . Data.Aeson.toEncoding) desiredTasks <>
          maybe mempty (Data.Aeson.Encoding.pair "RunningTasks" . Data.Aeson.toEncoding) runningTasks
        )

instance Data.Aeson.FromJSON ServiceServiceStatus where
    parseJSON = Data.Aeson.withObject "ServiceServiceStatus" $ \o ->
        ServiceServiceStatus
            <$> o Data.Aeson..:? "CompletedTasks"
            <*> o Data.Aeson..:? "DesiredTasks"
            <*> o Data.Aeson..:? "RunningTasks"

data ServiceUpdateStatus = ServiceUpdateStatus
    {
        completedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        message :: (Data.Maybe.Maybe (Data.Text.Text)),
        startedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        state :: (Data.Maybe.Maybe (ServiceUpdateStatusState))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceUpdateStatus where
    toJSON ServiceUpdateStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CompletedAt" Data.Aeson..= completedAt | Just completedAt <- [completedAt] ]
        ++ [ "Message" Data.Aeson..= message | Just message <- [message] ]
        ++ [ "StartedAt" Data.Aeson..= startedAt | Just startedAt <- [startedAt] ]
        ++ [ "State" Data.Aeson..= state | Just state <- [state] ])

    toEncoding ServiceUpdateStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CompletedAt" . Data.Aeson.toEncoding) completedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Message" . Data.Aeson.toEncoding) message <>
          maybe mempty (Data.Aeson.Encoding.pair "StartedAt" . Data.Aeson.toEncoding) startedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "State" . Data.Aeson.toEncoding) state
        )

instance Data.Aeson.FromJSON ServiceUpdateStatus where
    parseJSON = Data.Aeson.withObject "ServiceUpdateStatus" $ \o ->
        ServiceUpdateStatus
            <$> o Data.Aeson..:? "CompletedAt"
            <*> o Data.Aeson..:? "Message"
            <*> o Data.Aeson..:? "StartedAt"
            <*> o Data.Aeson..:? "State"

data ServiceUpdateStatusState
    = ServiceUpdateStatusStateUpdating
    | ServiceUpdateStatusStatePaused
    | ServiceUpdateStatusStateCompleted
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ServiceUpdateStatusState where
    toJSON x = case x of
        ServiceUpdateStatusStateUpdating -> "updating"
        ServiceUpdateStatusStatePaused -> "paused"
        ServiceUpdateStatusStateCompleted -> "completed"

    toEncoding x = case x of
        ServiceUpdateStatusStateUpdating -> Data.Aeson.Encoding.text "updating"
        ServiceUpdateStatusStatePaused -> Data.Aeson.Encoding.text "paused"
        ServiceUpdateStatusStateCompleted -> Data.Aeson.Encoding.text "completed"

instance Data.Aeson.FromJSON ServiceUpdateStatusState where
    parseJSON = Data.Aeson.withText "ServiceUpdateStatusState" $ \s ->
        case s of
            "updating" -> pure ServiceUpdateStatusStateUpdating
            "paused" -> pure ServiceUpdateStatusStatePaused
            "completed" -> pure ServiceUpdateStatusStateCompleted
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ServiceUpdateStatusState where
    toQueryParam x = case x of
        ServiceUpdateStatusStateUpdating -> "updating"
        ServiceUpdateStatusStatePaused -> "paused"
        ServiceUpdateStatusStateCompleted -> "completed"

instance Web.HttpApiData.FromHttpApiData ServiceUpdateStatusState where
    parseUrlPiece x =
        case x of
            "updating" -> pure ServiceUpdateStatusStateUpdating
            "paused" -> pure ServiceUpdateStatusStatePaused
            "completed" -> pure ServiceUpdateStatusStateCompleted
            _ -> Left "invalid enum value"

data Service = Service
    {
        createdAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        endpoint :: (Data.Maybe.Maybe (ServiceEndpoint)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        jobStatus :: (Data.Maybe.Maybe (ServiceJobStatus)),
        serviceStatus :: (Data.Maybe.Maybe (ServiceServiceStatus)),
        spec :: (Data.Maybe.Maybe (ServiceSpec)),
        updateStatus :: (Data.Maybe.Maybe (ServiceUpdateStatus)),
        updatedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        version :: (Data.Maybe.Maybe (ObjectVersion))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Service where
    toJSON Service {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CreatedAt" Data.Aeson..= createdAt | Just createdAt <- [createdAt] ]
        ++ [ "Endpoint" Data.Aeson..= endpoint | Just endpoint <- [endpoint] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "JobStatus" Data.Aeson..= jobStatus | Just jobStatus <- [jobStatus] ]
        ++ [ "ServiceStatus" Data.Aeson..= serviceStatus | Just serviceStatus <- [serviceStatus] ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ]
        ++ [ "UpdateStatus" Data.Aeson..= updateStatus | Just updateStatus <- [updateStatus] ]
        ++ [ "UpdatedAt" Data.Aeson..= updatedAt | Just updatedAt <- [updatedAt] ]
        ++ [ "Version" Data.Aeson..= version | Just version <- [version] ])

    toEncoding Service {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CreatedAt" . Data.Aeson.toEncoding) createdAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Endpoint" . Data.Aeson.toEncoding) endpoint <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "JobStatus" . Data.Aeson.toEncoding) jobStatus <>
          maybe mempty (Data.Aeson.Encoding.pair "ServiceStatus" . Data.Aeson.toEncoding) serviceStatus <>
          maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdateStatus" . Data.Aeson.toEncoding) updateStatus <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdatedAt" . Data.Aeson.toEncoding) updatedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Version" . Data.Aeson.toEncoding) version
        )

instance Data.Aeson.FromJSON Service where
    parseJSON = Data.Aeson.withObject "Service" $ \o ->
        Service
            <$> o Data.Aeson..:? "CreatedAt"
            <*> o Data.Aeson..:? "Endpoint"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "JobStatus"
            <*> o Data.Aeson..:? "ServiceStatus"
            <*> o Data.Aeson..:? "Spec"
            <*> o Data.Aeson..:? "UpdateStatus"
            <*> o Data.Aeson..:? "UpdatedAt"
            <*> o Data.Aeson..:? "Version"