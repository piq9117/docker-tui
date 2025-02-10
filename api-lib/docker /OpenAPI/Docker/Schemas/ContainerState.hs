{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ContainerState where

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



import OpenAPI.Docker.Schemas.Health

data ContainerStateStatus
    = ContainerStateStatusCreated
    | ContainerStateStatusRunning
    | ContainerStateStatusPaused
    | ContainerStateStatusRestarting
    | ContainerStateStatusRemoving
    | ContainerStateStatusExited
    | ContainerStateStatusDead
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ContainerStateStatus where
    toJSON x = case x of
        ContainerStateStatusCreated -> "created"
        ContainerStateStatusRunning -> "running"
        ContainerStateStatusPaused -> "paused"
        ContainerStateStatusRestarting -> "restarting"
        ContainerStateStatusRemoving -> "removing"
        ContainerStateStatusExited -> "exited"
        ContainerStateStatusDead -> "dead"

    toEncoding x = case x of
        ContainerStateStatusCreated -> Data.Aeson.Encoding.text "created"
        ContainerStateStatusRunning -> Data.Aeson.Encoding.text "running"
        ContainerStateStatusPaused -> Data.Aeson.Encoding.text "paused"
        ContainerStateStatusRestarting -> Data.Aeson.Encoding.text "restarting"
        ContainerStateStatusRemoving -> Data.Aeson.Encoding.text "removing"
        ContainerStateStatusExited -> Data.Aeson.Encoding.text "exited"
        ContainerStateStatusDead -> Data.Aeson.Encoding.text "dead"

instance Data.Aeson.FromJSON ContainerStateStatus where
    parseJSON = Data.Aeson.withText "ContainerStateStatus" $ \s ->
        case s of
            "created" -> pure ContainerStateStatusCreated
            "running" -> pure ContainerStateStatusRunning
            "paused" -> pure ContainerStateStatusPaused
            "restarting" -> pure ContainerStateStatusRestarting
            "removing" -> pure ContainerStateStatusRemoving
            "exited" -> pure ContainerStateStatusExited
            "dead" -> pure ContainerStateStatusDead
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ContainerStateStatus where
    toQueryParam x = case x of
        ContainerStateStatusCreated -> "created"
        ContainerStateStatusRunning -> "running"
        ContainerStateStatusPaused -> "paused"
        ContainerStateStatusRestarting -> "restarting"
        ContainerStateStatusRemoving -> "removing"
        ContainerStateStatusExited -> "exited"
        ContainerStateStatusDead -> "dead"

instance Web.HttpApiData.FromHttpApiData ContainerStateStatus where
    parseUrlPiece x =
        case x of
            "created" -> pure ContainerStateStatusCreated
            "running" -> pure ContainerStateStatusRunning
            "paused" -> pure ContainerStateStatusPaused
            "restarting" -> pure ContainerStateStatusRestarting
            "removing" -> pure ContainerStateStatusRemoving
            "exited" -> pure ContainerStateStatusExited
            "dead" -> pure ContainerStateStatusDead
            _ -> Left "invalid enum value"

data ContainerState = ContainerState
    {
        dead :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        error :: (Data.Maybe.Maybe (Data.Text.Text)),
        exitCode :: (Data.Maybe.Maybe (GHC.Int.Int)),
        finishedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        health :: (Data.Maybe.Maybe (Health)),
        oOMKilled :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        paused :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        pid :: (Data.Maybe.Maybe (GHC.Int.Int)),
        restarting :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        running :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        startedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        status :: (Data.Maybe.Maybe (ContainerStateStatus))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerState where
    toJSON ContainerState {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Dead" Data.Aeson..= dead | Just dead <- [dead] ]
        ++ [ "Error" Data.Aeson..= error | Just error <- [error] ]
        ++ [ "ExitCode" Data.Aeson..= exitCode | Just exitCode <- [exitCode] ]
        ++ [ "FinishedAt" Data.Aeson..= finishedAt | Just finishedAt <- [finishedAt] ]
        ++ [ "Health" Data.Aeson..= health | Just health <- [health] ]
        ++ [ "OOMKilled" Data.Aeson..= oOMKilled | Just oOMKilled <- [oOMKilled] ]
        ++ [ "Paused" Data.Aeson..= paused | Just paused <- [paused] ]
        ++ [ "Pid" Data.Aeson..= pid | Just pid <- [pid] ]
        ++ [ "Restarting" Data.Aeson..= restarting | Just restarting <- [restarting] ]
        ++ [ "Running" Data.Aeson..= running | Just running <- [running] ]
        ++ [ "StartedAt" Data.Aeson..= startedAt | Just startedAt <- [startedAt] ]
        ++ [ "Status" Data.Aeson..= status | Just status <- [status] ])

    toEncoding ContainerState {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Dead" . Data.Aeson.toEncoding) dead <>
          maybe mempty (Data.Aeson.Encoding.pair "Error" . Data.Aeson.toEncoding) error <>
          maybe mempty (Data.Aeson.Encoding.pair "ExitCode" . Data.Aeson.toEncoding) exitCode <>
          maybe mempty (Data.Aeson.Encoding.pair "FinishedAt" . Data.Aeson.toEncoding) finishedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Health" . Data.Aeson.toEncoding) health <>
          maybe mempty (Data.Aeson.Encoding.pair "OOMKilled" . Data.Aeson.toEncoding) oOMKilled <>
          maybe mempty (Data.Aeson.Encoding.pair "Paused" . Data.Aeson.toEncoding) paused <>
          maybe mempty (Data.Aeson.Encoding.pair "Pid" . Data.Aeson.toEncoding) pid <>
          maybe mempty (Data.Aeson.Encoding.pair "Restarting" . Data.Aeson.toEncoding) restarting <>
          maybe mempty (Data.Aeson.Encoding.pair "Running" . Data.Aeson.toEncoding) running <>
          maybe mempty (Data.Aeson.Encoding.pair "StartedAt" . Data.Aeson.toEncoding) startedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Status" . Data.Aeson.toEncoding) status
        )

instance Data.Aeson.FromJSON ContainerState where
    parseJSON = Data.Aeson.withObject "ContainerState" $ \o ->
        ContainerState
            <$> o Data.Aeson..:? "Dead"
            <*> o Data.Aeson..:? "Error"
            <*> o Data.Aeson..:? "ExitCode"
            <*> o Data.Aeson..:? "FinishedAt"
            <*> o Data.Aeson..:? "Health"
            <*> o Data.Aeson..:? "OOMKilled"
            <*> o Data.Aeson..:? "Paused"
            <*> o Data.Aeson..:? "Pid"
            <*> o Data.Aeson..:? "Restarting"
            <*> o Data.Aeson..:? "Running"
            <*> o Data.Aeson..:? "StartedAt"
            <*> o Data.Aeson..:? "Status"