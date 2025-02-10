{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ImageConfig where

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

newtype ImageConfigExposedPorts = ImageConfigExposedPorts
    (Data.Map.Map Data.Text.Text (ImageConfigExposedPortsAdditionalProperties))
    deriving (Show)

instance Data.Aeson.ToJSON ImageConfigExposedPorts where
    toJSON (ImageConfigExposedPorts x) =
        Data.Aeson.toJSON x

    toEncoding (ImageConfigExposedPorts x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ImageConfigExposedPorts where
    parseJSON x =
        ImageConfigExposedPorts <$> Data.Aeson.parseJSON x

data ImageConfigExposedPortsAdditionalProperties = ImageConfigExposedPortsAdditionalProperties
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageConfigExposedPortsAdditionalProperties where
    toJSON ImageConfigExposedPortsAdditionalProperties {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ImageConfigExposedPortsAdditionalProperties {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ImageConfigExposedPortsAdditionalProperties where
    parseJSON = Data.Aeson.withObject "ImageConfigExposedPortsAdditionalProperties" $ \o ->
        ImageConfigExposedPortsAdditionalProperties
            

newtype ImageConfigLabels = ImageConfigLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ImageConfigLabels where
    toJSON (ImageConfigLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ImageConfigLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ImageConfigLabels where
    parseJSON x =
        ImageConfigLabels <$> Data.Aeson.parseJSON x

newtype ImageConfigVolumes = ImageConfigVolumes
    (Data.Map.Map Data.Text.Text (ImageConfigVolumesAdditionalProperties))
    deriving (Show)

instance Data.Aeson.ToJSON ImageConfigVolumes where
    toJSON (ImageConfigVolumes x) =
        Data.Aeson.toJSON x

    toEncoding (ImageConfigVolumes x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ImageConfigVolumes where
    parseJSON x =
        ImageConfigVolumes <$> Data.Aeson.parseJSON x

data ImageConfigVolumesAdditionalProperties = ImageConfigVolumesAdditionalProperties
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageConfigVolumesAdditionalProperties where
    toJSON ImageConfigVolumesAdditionalProperties {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ImageConfigVolumesAdditionalProperties {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ImageConfigVolumesAdditionalProperties where
    parseJSON = Data.Aeson.withObject "ImageConfigVolumesAdditionalProperties" $ \o ->
        ImageConfigVolumesAdditionalProperties
            

data ImageConfig = ImageConfig
    {
        argsEscaped :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStderr :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStdin :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        attachStdout :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        cmd :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        domainname :: (Data.Maybe.Maybe (Data.Text.Text)),
        entrypoint :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        env :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        exposedPorts :: (Data.Maybe.Maybe (ImageConfigExposedPorts)),
        healthcheck :: (Data.Maybe.Maybe (HealthConfig)),
        hostname :: (Data.Maybe.Maybe (Data.Text.Text)),
        image :: (Data.Maybe.Maybe (Data.Text.Text)),
        labels :: (Data.Maybe.Maybe (ImageConfigLabels)),
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
        volumes :: (Data.Maybe.Maybe (ImageConfigVolumes)),
        workingDir :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageConfig where
    toJSON ImageConfig {..} = Data.Aeson.object
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

    toEncoding ImageConfig {..} = Data.Aeson.Encoding.pairs
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

instance Data.Aeson.FromJSON ImageConfig where
    parseJSON = Data.Aeson.withObject "ImageConfig" $ \o ->
        ImageConfig
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