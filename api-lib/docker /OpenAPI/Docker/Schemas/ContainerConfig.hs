{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ContainerConfig where

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



import OpenAPI.Docker.Schemas.HealthConfig

newtype ContainerConfigExposedPorts = ContainerConfigExposedPorts
    (Data.Map.Map Data.Text.Text (ContainerConfigExposedPortsAdditionalProperties))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerConfigExposedPorts where
    toJSON (ContainerConfigExposedPorts x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerConfigExposedPorts x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerConfigExposedPorts where
    parseJSON x =
        ContainerConfigExposedPorts <$> Data.Aeson.parseJSON x

data ContainerConfigExposedPortsAdditionalProperties = ContainerConfigExposedPortsAdditionalProperties
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerConfigExposedPortsAdditionalProperties where
    toJSON ContainerConfigExposedPortsAdditionalProperties {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ContainerConfigExposedPortsAdditionalProperties {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ContainerConfigExposedPortsAdditionalProperties where
    parseJSON = Data.Aeson.withObject "ContainerConfigExposedPortsAdditionalProperties" $ \o ->
        ContainerConfigExposedPortsAdditionalProperties
            

newtype ContainerConfigLabels = ContainerConfigLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerConfigLabels where
    toJSON (ContainerConfigLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerConfigLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerConfigLabels where
    parseJSON x =
        ContainerConfigLabels <$> Data.Aeson.parseJSON x

newtype ContainerConfigVolumes = ContainerConfigVolumes
    (Data.Map.Map Data.Text.Text (ContainerConfigVolumesAdditionalProperties))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerConfigVolumes where
    toJSON (ContainerConfigVolumes x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerConfigVolumes x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerConfigVolumes where
    parseJSON x =
        ContainerConfigVolumes <$> Data.Aeson.parseJSON x

data ContainerConfigVolumesAdditionalProperties = ContainerConfigVolumesAdditionalProperties
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerConfigVolumesAdditionalProperties where
    toJSON ContainerConfigVolumesAdditionalProperties {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ContainerConfigVolumesAdditionalProperties {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ContainerConfigVolumesAdditionalProperties where
    parseJSON = Data.Aeson.withObject "ContainerConfigVolumesAdditionalProperties" $ \o ->
        ContainerConfigVolumesAdditionalProperties
            

data ContainerConfig = ContainerConfig
    {
        argsEscaped :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStderr :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStdin :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStdout :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        cmd :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        domainname :: (Data.Maybe.Maybe (Data.Text.Text)),
        entrypoint :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        env :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        exposedPorts :: (Data.Maybe.Maybe (ContainerConfigExposedPorts)),
        healthcheck :: (Data.Maybe.Maybe (HealthConfig)),
        hostname :: (Data.Maybe.Maybe (Data.Text.Text)),
        image :: (Data.Maybe.Maybe (Data.Text.Text)),
        labels :: (Data.Maybe.Maybe (ContainerConfigLabels)),
        macAddress :: (Data.Maybe.Maybe (Data.Text.Text)),
        networkDisabled :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        onBuild :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        openStdin :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        shell :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        stdinOnce :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        stopSignal :: (Data.Maybe.Maybe (Data.Text.Text)),
        stopTimeout :: (Data.Maybe.Maybe (GHC.Int.Int)),
        tty :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        user :: (Data.Maybe.Maybe (Data.Text.Text)),
        volumes :: (Data.Maybe.Maybe (ContainerConfigVolumes)),
        workingDir :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerConfig where
    toJSON ContainerConfig {..} = Data.Aeson.object
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
        ++ [ "Hostname" Data.Aeson..= hostname | Just hostname <- [hostname] ]
        ++ [ "Image" Data.Aeson..= image | Just image <- [image] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "MacAddress" Data.Aeson..= macAddress | Just macAddress <- [macAddress] ]
        ++ [ "NetworkDisabled" Data.Aeson..= networkDisabled | Just networkDisabled <- [networkDisabled] ]
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

    toEncoding ContainerConfig {..} = Data.Aeson.Encoding.pairs
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
          maybe mempty (Data.Aeson.Encoding.pair "Hostname" . Data.Aeson.toEncoding) hostname <>
          maybe mempty (Data.Aeson.Encoding.pair "Image" . Data.Aeson.toEncoding) image <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "MacAddress" . Data.Aeson.toEncoding) macAddress <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkDisabled" . Data.Aeson.toEncoding) networkDisabled <>
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

instance Data.Aeson.FromJSON ContainerConfig where
    parseJSON = Data.Aeson.withObject "ContainerConfig" $ \o ->
        ContainerConfig
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
            <*> o Data.Aeson..:? "Hostname"
            <*> o Data.Aeson..:? "Image"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "MacAddress"
            <*> o Data.Aeson..:? "NetworkDisabled"
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