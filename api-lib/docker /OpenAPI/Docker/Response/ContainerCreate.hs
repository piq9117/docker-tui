{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerCreate where

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
import OpenAPI.Docker.Schemas.ContainerCreateResponse
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.HealthConfig
import OpenAPI.Docker.Schemas.HostConfig
import OpenAPI.Docker.Schemas.NetworkingConfig

import OpenAPI.Docker.Response

data ContainerCreateRequestBody = ContainerCreateRequestBody
    {
        argsEscaped :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStderr :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStdin :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStdout :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        cmd :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        domainname :: (Data.Maybe.Maybe (Data.Text.Text)),
        entrypoint :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        env :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        exposedPorts :: (Data.Maybe.Maybe (ContainerCreateRequestBodyExposedPorts)),
        healthcheck :: (Data.Maybe.Maybe (HealthConfig)),
        hostConfig :: (Data.Maybe.Maybe (HostConfig)),
        hostname :: (Data.Maybe.Maybe (Data.Text.Text)),
        image :: (Data.Maybe.Maybe (Data.Text.Text)),
        labels :: (Data.Maybe.Maybe (ContainerCreateRequestBodyLabels)),
        macAddress :: (Data.Maybe.Maybe (Data.Text.Text)),
        networkDisabled :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        networkingConfig :: (Data.Maybe.Maybe (NetworkingConfig)),
        onBuild :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        openStdin :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        shell :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        stdinOnce :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        stopSignal :: (Data.Maybe.Maybe (Data.Text.Text)),
        stopTimeout :: (Data.Maybe.Maybe (GHC.Int.Int)),
        tty :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        user :: (Data.Maybe.Maybe (Data.Text.Text)),
        volumes :: (Data.Maybe.Maybe (ContainerCreateRequestBodyVolumes)),
        workingDir :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerCreateRequestBody where
    toJSON ContainerCreateRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ArgsEscaped" Data.Aeson..= argsEscaped | Just argsEscaped <- [argsEscaped] ]
        ++ [ "AttachStderr" Data.Aeson..= attachStderr | Just attachStderr <- [attachStderr] ]
        ++ [ "AttachStdin" Data.Aeson..= attachStdin | Just attachStdin <- [attachStdin] ]
        ++ [ "AttachStdout" Data.Aeson..= attachStdout | Just attachStdout <- [attachStdout] ]
        ++ [ "Cmd" Data.Aeson..= cmd | Just cmd <- [cmd] ]
        ++ [ "Domainname" Data.Aeson..= domainname | Just domainname <- [domainname] ]
        ++ [ "Entrypoint" Data.Aeson..= entrypoint | Just entrypoint <- [entrypoint] ]
        ++ [ "Env" Data.Aeson..= env | Just env <- [env] ]
        ++ [ "ExposedPorts" Data.Aeson..= exposedPorts | Just exposedPorts <- [exposedPorts] ]
        ++ [ "Healthcheck" Data.Aeson..= healthcheck | Just healthcheck <- [healthcheck] ]
        ++ [ "HostConfig" Data.Aeson..= hostConfig | Just hostConfig <- [hostConfig] ]
        ++ [ "Hostname" Data.Aeson..= hostname | Just hostname <- [hostname] ]
        ++ [ "Image" Data.Aeson..= image | Just image <- [image] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "MacAddress" Data.Aeson..= macAddress | Just macAddress <- [macAddress] ]
        ++ [ "NetworkDisabled" Data.Aeson..= networkDisabled | Just networkDisabled <- [networkDisabled] ]
        ++ [ "NetworkingConfig" Data.Aeson..= networkingConfig | Just networkingConfig <- [networkingConfig] ]
        ++ [ "OnBuild" Data.Aeson..= onBuild | Just onBuild <- [onBuild] ]
        ++ [ "OpenStdin" Data.Aeson..= openStdin | Just openStdin <- [openStdin] ]
        ++ [ "Shell" Data.Aeson..= shell | Just shell <- [shell] ]
        ++ [ "StdinOnce" Data.Aeson..= stdinOnce | Just stdinOnce <- [stdinOnce] ]
        ++ [ "StopSignal" Data.Aeson..= stopSignal | Just stopSignal <- [stopSignal] ]
        ++ [ "StopTimeout" Data.Aeson..= stopTimeout | Just stopTimeout <- [stopTimeout] ]
        ++ [ "Tty" Data.Aeson..= tty | Just tty <- [tty] ]
        ++ [ "User" Data.Aeson..= user | Just user <- [user] ]
        ++ [ "Volumes" Data.Aeson..= volumes | Just volumes <- [volumes] ]
        ++ [ "WorkingDir" Data.Aeson..= workingDir | Just workingDir <- [workingDir] ])

    toEncoding ContainerCreateRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ArgsEscaped" . Data.Aeson.toEncoding) argsEscaped <>
          maybe mempty (Data.Aeson.Encoding.pair "AttachStderr" . Data.Aeson.toEncoding) attachStderr <>
          maybe mempty (Data.Aeson.Encoding.pair "AttachStdin" . Data.Aeson.toEncoding) attachStdin <>
          maybe mempty (Data.Aeson.Encoding.pair "AttachStdout" . Data.Aeson.toEncoding) attachStdout <>
          maybe mempty (Data.Aeson.Encoding.pair "Cmd" . Data.Aeson.toEncoding) cmd <>
          maybe mempty (Data.Aeson.Encoding.pair "Domainname" . Data.Aeson.toEncoding) domainname <>
          maybe mempty (Data.Aeson.Encoding.pair "Entrypoint" . Data.Aeson.toEncoding) entrypoint <>
          maybe mempty (Data.Aeson.Encoding.pair "Env" . Data.Aeson.toEncoding) env <>
          maybe mempty (Data.Aeson.Encoding.pair "ExposedPorts" . Data.Aeson.toEncoding) exposedPorts <>
          maybe mempty (Data.Aeson.Encoding.pair "Healthcheck" . Data.Aeson.toEncoding) healthcheck <>
          maybe mempty (Data.Aeson.Encoding.pair "HostConfig" . Data.Aeson.toEncoding) hostConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "Hostname" . Data.Aeson.toEncoding) hostname <>
          maybe mempty (Data.Aeson.Encoding.pair "Image" . Data.Aeson.toEncoding) image <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "MacAddress" . Data.Aeson.toEncoding) macAddress <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkDisabled" . Data.Aeson.toEncoding) networkDisabled <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkingConfig" . Data.Aeson.toEncoding) networkingConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "OnBuild" . Data.Aeson.toEncoding) onBuild <>
          maybe mempty (Data.Aeson.Encoding.pair "OpenStdin" . Data.Aeson.toEncoding) openStdin <>
          maybe mempty (Data.Aeson.Encoding.pair "Shell" . Data.Aeson.toEncoding) shell <>
          maybe mempty (Data.Aeson.Encoding.pair "StdinOnce" . Data.Aeson.toEncoding) stdinOnce <>
          maybe mempty (Data.Aeson.Encoding.pair "StopSignal" . Data.Aeson.toEncoding) stopSignal <>
          maybe mempty (Data.Aeson.Encoding.pair "StopTimeout" . Data.Aeson.toEncoding) stopTimeout <>
          maybe mempty (Data.Aeson.Encoding.pair "Tty" . Data.Aeson.toEncoding) tty <>
          maybe mempty (Data.Aeson.Encoding.pair "User" . Data.Aeson.toEncoding) user <>
          maybe mempty (Data.Aeson.Encoding.pair "Volumes" . Data.Aeson.toEncoding) volumes <>
          maybe mempty (Data.Aeson.Encoding.pair "WorkingDir" . Data.Aeson.toEncoding) workingDir
        )

instance Data.Aeson.FromJSON ContainerCreateRequestBody where
    parseJSON = Data.Aeson.withObject "ContainerCreateRequestBody" $ \o ->
        ContainerCreateRequestBody
            <$> o Data.Aeson..:? "ArgsEscaped"
            <*> o Data.Aeson..:? "AttachStderr"
            <*> o Data.Aeson..:? "AttachStdin"
            <*> o Data.Aeson..:? "AttachStdout"
            <*> o Data.Aeson..:? "Cmd"
            <*> o Data.Aeson..:? "Domainname"
            <*> o Data.Aeson..:? "Entrypoint"
            <*> o Data.Aeson..:? "Env"
            <*> o Data.Aeson..:? "ExposedPorts"
            <*> o Data.Aeson..:? "Healthcheck"
            <*> o Data.Aeson..:? "HostConfig"
            <*> o Data.Aeson..:? "Hostname"
            <*> o Data.Aeson..:? "Image"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "MacAddress"
            <*> o Data.Aeson..:? "NetworkDisabled"
            <*> o Data.Aeson..:? "NetworkingConfig"
            <*> o Data.Aeson..:? "OnBuild"
            <*> o Data.Aeson..:? "OpenStdin"
            <*> o Data.Aeson..:? "Shell"
            <*> o Data.Aeson..:? "StdinOnce"
            <*> o Data.Aeson..:? "StopSignal"
            <*> o Data.Aeson..:? "StopTimeout"
            <*> o Data.Aeson..:? "Tty"
            <*> o Data.Aeson..:? "User"
            <*> o Data.Aeson..:? "Volumes"
            <*> o Data.Aeson..:? "WorkingDir"

newtype ContainerCreateRequestBodyExposedPorts = ContainerCreateRequestBodyExposedPorts
    (Data.Map.Map Data.Text.Text (ContainerCreateRequestBodyExposedPortsAdditionalProperties))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerCreateRequestBodyExposedPorts where
    toJSON (ContainerCreateRequestBodyExposedPorts x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerCreateRequestBodyExposedPorts x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerCreateRequestBodyExposedPorts where
    parseJSON x =
        ContainerCreateRequestBodyExposedPorts <$> Data.Aeson.parseJSON x

data ContainerCreateRequestBodyExposedPortsAdditionalProperties = ContainerCreateRequestBodyExposedPortsAdditionalProperties
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerCreateRequestBodyExposedPortsAdditionalProperties where
    toJSON ContainerCreateRequestBodyExposedPortsAdditionalProperties {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ContainerCreateRequestBodyExposedPortsAdditionalProperties {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ContainerCreateRequestBodyExposedPortsAdditionalProperties where
    parseJSON = Data.Aeson.withObject "ContainerCreateRequestBodyExposedPortsAdditionalProperties" $ \o ->
        ContainerCreateRequestBodyExposedPortsAdditionalProperties
            

newtype ContainerCreateRequestBodyLabels = ContainerCreateRequestBodyLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerCreateRequestBodyLabels where
    toJSON (ContainerCreateRequestBodyLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerCreateRequestBodyLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerCreateRequestBodyLabels where
    parseJSON x =
        ContainerCreateRequestBodyLabels <$> Data.Aeson.parseJSON x

newtype ContainerCreateRequestBodyVolumes = ContainerCreateRequestBodyVolumes
    (Data.Map.Map Data.Text.Text (ContainerCreateRequestBodyVolumesAdditionalProperties))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerCreateRequestBodyVolumes where
    toJSON (ContainerCreateRequestBodyVolumes x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerCreateRequestBodyVolumes x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerCreateRequestBodyVolumes where
    parseJSON x =
        ContainerCreateRequestBodyVolumes <$> Data.Aeson.parseJSON x

data ContainerCreateRequestBodyVolumesAdditionalProperties = ContainerCreateRequestBodyVolumesAdditionalProperties
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerCreateRequestBodyVolumesAdditionalProperties where
    toJSON ContainerCreateRequestBodyVolumesAdditionalProperties {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ContainerCreateRequestBodyVolumesAdditionalProperties {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ContainerCreateRequestBodyVolumesAdditionalProperties where
    parseJSON = Data.Aeson.withObject "ContainerCreateRequestBodyVolumesAdditionalProperties" $ \o ->
        ContainerCreateRequestBodyVolumesAdditionalProperties
            

data ContainerCreateResponse
    = ContainerCreateResponse201 ContainerCreateResponse
    | ContainerCreateResponse400 ErrorResponse
    | ContainerCreateResponse404 ErrorResponse
    | ContainerCreateResponse409 ErrorResponse
    | ContainerCreateResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerCreateResponse where
    toResponse (ContainerCreateResponse201 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status201 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerCreateResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerCreateResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerCreateResponse409 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status409 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerCreateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerCreateResponse Network.HTTP.Types.Status where
    getField (ContainerCreateResponse201 {}) = Network.HTTP.Types.status201
    getField (ContainerCreateResponse400 {}) = Network.HTTP.Types.status400
    getField (ContainerCreateResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerCreateResponse409 {}) = Network.HTTP.Types.status409
    getField (ContainerCreateResponse500 {}) = Network.HTTP.Types.status500