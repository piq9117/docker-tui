{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerExec where

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
import OpenAPI.Docker.Schemas.IdResponse

import OpenAPI.Docker.Response

data ContainerExecRequestBody = ContainerExecRequestBody
    {
        attachStderr :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStdin :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStdout :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        cmd :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        consoleSize :: (Data.Maybe.Maybe ([ GHC.Int.Int ])),
        detachKeys :: (Data.Maybe.Maybe (Data.Text.Text)),
        env :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        privileged :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        tty :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        user :: (Data.Maybe.Maybe (Data.Text.Text)),
        workingDir :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerExecRequestBody where
    toJSON ContainerExecRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AttachStderr" Data.Aeson..= attachStderr | Just attachStderr <- [attachStderr] ]
        ++ [ "AttachStdin" Data.Aeson..= attachStdin | Just attachStdin <- [attachStdin] ]
        ++ [ "AttachStdout" Data.Aeson..= attachStdout | Just attachStdout <- [attachStdout] ]
        ++ [ "Cmd" Data.Aeson..= cmd | Just cmd <- [cmd] ]
        ++ [ "ConsoleSize" Data.Aeson..= consoleSize | Just consoleSize <- [consoleSize] ]
        ++ [ "DetachKeys" Data.Aeson..= detachKeys | Just detachKeys <- [detachKeys] ]
        ++ [ "Env" Data.Aeson..= env | Just env <- [env] ]
        ++ [ "Privileged" Data.Aeson..= privileged | Just privileged <- [privileged] ]
        ++ [ "Tty" Data.Aeson..= tty | Just tty <- [tty] ]
        ++ [ "User" Data.Aeson..= user | Just user <- [user] ]
        ++ [ "WorkingDir" Data.Aeson..= workingDir | Just workingDir <- [workingDir] ])

    toEncoding ContainerExecRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AttachStderr" . Data.Aeson.toEncoding) attachStderr <>
          maybe mempty (Data.Aeson.Encoding.pair "AttachStdin" . Data.Aeson.toEncoding) attachStdin <>
          maybe mempty (Data.Aeson.Encoding.pair "AttachStdout" . Data.Aeson.toEncoding) attachStdout <>
          maybe mempty (Data.Aeson.Encoding.pair "Cmd" . Data.Aeson.toEncoding) cmd <>
          maybe mempty (Data.Aeson.Encoding.pair "ConsoleSize" . Data.Aeson.toEncoding) consoleSize <>
          maybe mempty (Data.Aeson.Encoding.pair "DetachKeys" . Data.Aeson.toEncoding) detachKeys <>
          maybe mempty (Data.Aeson.Encoding.pair "Env" . Data.Aeson.toEncoding) env <>
          maybe mempty (Data.Aeson.Encoding.pair "Privileged" . Data.Aeson.toEncoding) privileged <>
          maybe mempty (Data.Aeson.Encoding.pair "Tty" . Data.Aeson.toEncoding) tty <>
          maybe mempty (Data.Aeson.Encoding.pair "User" . Data.Aeson.toEncoding) user <>
          maybe mempty (Data.Aeson.Encoding.pair "WorkingDir" . Data.Aeson.toEncoding) workingDir
        )

instance Data.Aeson.FromJSON ContainerExecRequestBody where
    parseJSON = Data.Aeson.withObject "ContainerExecRequestBody" $ \o ->
        ContainerExecRequestBody
            <$> o Data.Aeson..:? "AttachStderr"
            <*> o Data.Aeson..:? "AttachStdin"
            <*> o Data.Aeson..:? "AttachStdout"
            <*> o Data.Aeson..:? "Cmd"
            <*> o Data.Aeson..:? "ConsoleSize"
            <*> o Data.Aeson..:? "DetachKeys"
            <*> o Data.Aeson..:? "Env"
            <*> o Data.Aeson..:? "Privileged"
            <*> o Data.Aeson..:? "Tty"
            <*> o Data.Aeson..:? "User"
            <*> o Data.Aeson..:? "WorkingDir"

data ContainerExecResponse
    = ContainerExecResponse201 IdResponse
    | ContainerExecResponse404 ErrorResponse
    | ContainerExecResponse409 ErrorResponse
    | ContainerExecResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerExecResponse where
    toResponse (ContainerExecResponse201 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status201 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerExecResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerExecResponse409 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status409 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerExecResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerExecResponse Network.HTTP.Types.Status where
    getField (ContainerExecResponse201 {}) = Network.HTTP.Types.status201
    getField (ContainerExecResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerExecResponse409 {}) = Network.HTTP.Types.status409
    getField (ContainerExecResponse500 {}) = Network.HTTP.Types.status500