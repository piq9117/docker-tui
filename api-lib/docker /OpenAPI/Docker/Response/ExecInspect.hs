{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ExecInspect where

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

import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.ProcessConfig

import OpenAPI.Docker.Response

data ExecInspectResponseBody200 = ExecInspectResponseBody200
    {
        canRemove :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        containerID :: (Data.Maybe.Maybe (Data.Text.Text)),
        detachKeys :: (Data.Maybe.Maybe (Data.Text.Text)),
        exitCode :: (Data.Maybe.Maybe (GHC.Int.Int)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        openStderr :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        openStdin :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        openStdout :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        pid :: (Data.Maybe.Maybe (GHC.Int.Int)),
        processConfig :: (Data.Maybe.Maybe (ProcessConfig)),
        running :: (Data.Maybe.Maybe (GHC.Types.Bool))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ExecInspectResponseBody200 where
    toJSON ExecInspectResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CanRemove" Data.Aeson..= canRemove | Just canRemove <- [canRemove] ]
        ++ [ "ContainerID" Data.Aeson..= containerID | Just containerID <- [containerID] ]
        ++ [ "DetachKeys" Data.Aeson..= detachKeys | Just detachKeys <- [detachKeys] ]
        ++ [ "ExitCode" Data.Aeson..= exitCode | Just exitCode <- [exitCode] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "OpenStderr" Data.Aeson..= openStderr | Just openStderr <- [openStderr] ]
        ++ [ "OpenStdin" Data.Aeson..= openStdin | Just openStdin <- [openStdin] ]
        ++ [ "OpenStdout" Data.Aeson..= openStdout | Just openStdout <- [openStdout] ]
        ++ [ "Pid" Data.Aeson..= pid | Just pid <- [pid] ]
        ++ [ "ProcessConfig" Data.Aeson..= processConfig | Just processConfig <- [processConfig] ]
        ++ [ "Running" Data.Aeson..= running | Just running <- [running] ])

    toEncoding ExecInspectResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CanRemove" . Data.Aeson.toEncoding) canRemove <>
          maybe mempty (Data.Aeson.Encoding.pair "ContainerID" . Data.Aeson.toEncoding) containerID <>
          maybe mempty (Data.Aeson.Encoding.pair "DetachKeys" . Data.Aeson.toEncoding) detachKeys <>
          maybe mempty (Data.Aeson.Encoding.pair "ExitCode" . Data.Aeson.toEncoding) exitCode <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "OpenStderr" . Data.Aeson.toEncoding) openStderr <>
          maybe mempty (Data.Aeson.Encoding.pair "OpenStdin" . Data.Aeson.toEncoding) openStdin <>
          maybe mempty (Data.Aeson.Encoding.pair "OpenStdout" . Data.Aeson.toEncoding) openStdout <>
          maybe mempty (Data.Aeson.Encoding.pair "Pid" . Data.Aeson.toEncoding) pid <>
          maybe mempty (Data.Aeson.Encoding.pair "ProcessConfig" . Data.Aeson.toEncoding) processConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "Running" . Data.Aeson.toEncoding) running
        )

instance Data.Aeson.FromJSON ExecInspectResponseBody200 where
    parseJSON = Data.Aeson.withObject "ExecInspectResponseBody200" $ \o ->
        ExecInspectResponseBody200
            <$> o Data.Aeson..:? "CanRemove"
            <*> o Data.Aeson..:? "ContainerID"
            <*> o Data.Aeson..:? "DetachKeys"
            <*> o Data.Aeson..:? "ExitCode"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "OpenStderr"
            <*> o Data.Aeson..:? "OpenStdin"
            <*> o Data.Aeson..:? "OpenStdout"
            <*> o Data.Aeson..:? "Pid"
            <*> o Data.Aeson..:? "ProcessConfig"
            <*> o Data.Aeson..:? "Running"

data ExecInspectResponse
    = ExecInspectResponse200 ExecInspectResponseBody200
    | ExecInspectResponse404 ErrorResponse
    | ExecInspectResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ExecInspectResponse where
    toResponse (ExecInspectResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ExecInspectResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ExecInspectResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ExecInspectResponse Network.HTTP.Types.Status where
    getField (ExecInspectResponse200 {}) = Network.HTTP.Types.status200
    getField (ExecInspectResponse404 {}) = Network.HTTP.Types.status404
    getField (ExecInspectResponse500 {}) = Network.HTTP.Types.status500