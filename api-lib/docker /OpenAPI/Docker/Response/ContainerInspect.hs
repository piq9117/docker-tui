{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerInspect where

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

import OpenAPI.Docker.Schemas.ContainerConfig
import OpenAPI.Docker.Schemas.ContainerState
import OpenAPI.Docker.Schemas.DriverData
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.HostConfig
import OpenAPI.Docker.Schemas.MountPoint
import OpenAPI.Docker.Schemas.NetworkSettings

import OpenAPI.Docker.Response

data ContainerInspectResponseBody200 = ContainerInspectResponseBody200
    {
        appArmorProfile :: (Data.Maybe.Maybe (Data.Text.Text)),
        args :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        config :: (Data.Maybe.Maybe (ContainerConfig)),
        created :: (Data.Maybe.Maybe (Data.Text.Text)),
        driver :: (Data.Maybe.Maybe (Data.Text.Text)),
        execIDs :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        graphDriver :: (Data.Maybe.Maybe (DriverData)),
        hostConfig :: (Data.Maybe.Maybe (HostConfig)),
        hostnamePath :: (Data.Maybe.Maybe (Data.Text.Text)),
        hostsPath :: (Data.Maybe.Maybe (Data.Text.Text)),
        id :: (Data.Maybe.Maybe (Data.Text.Text)),
        image :: (Data.Maybe.Maybe (Data.Text.Text)),
        logPath :: (Data.Maybe.Maybe (Data.Text.Text)),
        mountLabel :: (Data.Maybe.Maybe (Data.Text.Text)),
        mounts :: (Data.Maybe.Maybe ([ MountPoint ])),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        networkSettings :: (Data.Maybe.Maybe (NetworkSettings)),
        path :: (Data.Maybe.Maybe (Data.Text.Text)),
        platform :: (Data.Maybe.Maybe (Data.Text.Text)),
        processLabel :: (Data.Maybe.Maybe (Data.Text.Text)),
        resolvConfPath :: (Data.Maybe.Maybe (Data.Text.Text)),
        restartCount :: (Data.Maybe.Maybe (GHC.Int.Int)),
        sizeRootFs :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        sizeRw :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        state :: (Data.Maybe.Maybe (ContainerState))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerInspectResponseBody200 where
    toJSON ContainerInspectResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AppArmorProfile" Data.Aeson..= appArmorProfile | Just appArmorProfile <- [appArmorProfile] ]
        ++ [ "Args" Data.Aeson..= args | Just args <- [args] ]
        ++ [ "Config" Data.Aeson..= config | Just config <- [config] ]
        ++ [ "Created" Data.Aeson..= created | Just created <- [created] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "ExecIDs" Data.Aeson..= execIDs | Just execIDs <- [execIDs] ]
        ++ [ "GraphDriver" Data.Aeson..= graphDriver | Just graphDriver <- [graphDriver] ]
        ++ [ "HostConfig" Data.Aeson..= hostConfig | Just hostConfig <- [hostConfig] ]
        ++ [ "HostnamePath" Data.Aeson..= hostnamePath | Just hostnamePath <- [hostnamePath] ]
        ++ [ "HostsPath" Data.Aeson..= hostsPath | Just hostsPath <- [hostsPath] ]
        ++ [ "Id" Data.Aeson..= id | Just id <- [id] ]
        ++ [ "Image" Data.Aeson..= image | Just image <- [image] ]
        ++ [ "LogPath" Data.Aeson..= logPath | Just logPath <- [logPath] ]
        ++ [ "MountLabel" Data.Aeson..= mountLabel | Just mountLabel <- [mountLabel] ]
        ++ [ "Mounts" Data.Aeson..= mounts | Just mounts <- [mounts] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "NetworkSettings" Data.Aeson..= networkSettings | Just networkSettings <- [networkSettings] ]
        ++ [ "Path" Data.Aeson..= path | Just path <- [path] ]
        ++ [ "Platform" Data.Aeson..= platform | Just platform <- [platform] ]
        ++ [ "ProcessLabel" Data.Aeson..= processLabel | Just processLabel <- [processLabel] ]
        ++ [ "ResolvConfPath" Data.Aeson..= resolvConfPath | Just resolvConfPath <- [resolvConfPath] ]
        ++ [ "RestartCount" Data.Aeson..= restartCount | Just restartCount <- [restartCount] ]
        ++ [ "SizeRootFs" Data.Aeson..= sizeRootFs | Just sizeRootFs <- [sizeRootFs] ]
        ++ [ "SizeRw" Data.Aeson..= sizeRw | Just sizeRw <- [sizeRw] ]
        ++ [ "State" Data.Aeson..= state | Just state <- [state] ])

    toEncoding ContainerInspectResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AppArmorProfile" . Data.Aeson.toEncoding) appArmorProfile <>
          maybe mempty (Data.Aeson.Encoding.pair "Args" . Data.Aeson.toEncoding) args <>
          maybe mempty (Data.Aeson.Encoding.pair "Config" . Data.Aeson.toEncoding) config <>
          maybe mempty (Data.Aeson.Encoding.pair "Created" . Data.Aeson.toEncoding) created <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "ExecIDs" . Data.Aeson.toEncoding) execIDs <>
          maybe mempty (Data.Aeson.Encoding.pair "GraphDriver" . Data.Aeson.toEncoding) graphDriver <>
          maybe mempty (Data.Aeson.Encoding.pair "HostConfig" . Data.Aeson.toEncoding) hostConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "HostnamePath" . Data.Aeson.toEncoding) hostnamePath <>
          maybe mempty (Data.Aeson.Encoding.pair "HostsPath" . Data.Aeson.toEncoding) hostsPath <>
          maybe mempty (Data.Aeson.Encoding.pair "Id" . Data.Aeson.toEncoding) id <>
          maybe mempty (Data.Aeson.Encoding.pair "Image" . Data.Aeson.toEncoding) image <>
          maybe mempty (Data.Aeson.Encoding.pair "LogPath" . Data.Aeson.toEncoding) logPath <>
          maybe mempty (Data.Aeson.Encoding.pair "MountLabel" . Data.Aeson.toEncoding) mountLabel <>
          maybe mempty (Data.Aeson.Encoding.pair "Mounts" . Data.Aeson.toEncoding) mounts <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkSettings" . Data.Aeson.toEncoding) networkSettings <>
          maybe mempty (Data.Aeson.Encoding.pair "Path" . Data.Aeson.toEncoding) path <>
          maybe mempty (Data.Aeson.Encoding.pair "Platform" . Data.Aeson.toEncoding) platform <>
          maybe mempty (Data.Aeson.Encoding.pair "ProcessLabel" . Data.Aeson.toEncoding) processLabel <>
          maybe mempty (Data.Aeson.Encoding.pair "ResolvConfPath" . Data.Aeson.toEncoding) resolvConfPath <>
          maybe mempty (Data.Aeson.Encoding.pair "RestartCount" . Data.Aeson.toEncoding) restartCount <>
          maybe mempty (Data.Aeson.Encoding.pair "SizeRootFs" . Data.Aeson.toEncoding) sizeRootFs <>
          maybe mempty (Data.Aeson.Encoding.pair "SizeRw" . Data.Aeson.toEncoding) sizeRw <>
          maybe mempty (Data.Aeson.Encoding.pair "State" . Data.Aeson.toEncoding) state
        )

instance Data.Aeson.FromJSON ContainerInspectResponseBody200 where
    parseJSON = Data.Aeson.withObject "ContainerInspectResponseBody200" $ \o ->
        ContainerInspectResponseBody200
            <$> o Data.Aeson..:? "AppArmorProfile"
            <*> o Data.Aeson..:? "Args"
            <*> o Data.Aeson..:? "Config"
            <*> o Data.Aeson..:? "Created"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "ExecIDs"
            <*> o Data.Aeson..:? "GraphDriver"
            <*> o Data.Aeson..:? "HostConfig"
            <*> o Data.Aeson..:? "HostnamePath"
            <*> o Data.Aeson..:? "HostsPath"
            <*> o Data.Aeson..:? "Id"
            <*> o Data.Aeson..:? "Image"
            <*> o Data.Aeson..:? "LogPath"
            <*> o Data.Aeson..:? "MountLabel"
            <*> o Data.Aeson..:? "Mounts"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "NetworkSettings"
            <*> o Data.Aeson..:? "Path"
            <*> o Data.Aeson..:? "Platform"
            <*> o Data.Aeson..:? "ProcessLabel"
            <*> o Data.Aeson..:? "ResolvConfPath"
            <*> o Data.Aeson..:? "RestartCount"
            <*> o Data.Aeson..:? "SizeRootFs"
            <*> o Data.Aeson..:? "SizeRw"
            <*> o Data.Aeson..:? "State"

data ContainerInspectResponse
    = ContainerInspectResponse200 ContainerInspectResponseBody200
    | ContainerInspectResponse404 ErrorResponse
    | ContainerInspectResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerInspectResponse where
    toResponse (ContainerInspectResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerInspectResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerInspectResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerInspectResponse Network.HTTP.Types.Status where
    getField (ContainerInspectResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerInspectResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerInspectResponse500 {}) = Network.HTTP.Types.status500