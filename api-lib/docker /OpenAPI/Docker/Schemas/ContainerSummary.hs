{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ContainerSummary where

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



import OpenAPI.Docker.Schemas.EndpointSettings
import OpenAPI.Docker.Schemas.MountPoint
import OpenAPI.Docker.Schemas.Port

data ContainerSummaryHostConfig = ContainerSummaryHostConfig
    {
        annotations :: (Data.Maybe.Maybe (ContainerSummaryHostConfigAnnotations)),
        networkMode :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerSummaryHostConfig where
    toJSON ContainerSummaryHostConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Annotations" Data.Aeson..= annotations | Just annotations <- [annotations] ]
        ++ [ "NetworkMode" Data.Aeson..= networkMode | Just networkMode <- [networkMode] ])

    toEncoding ContainerSummaryHostConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Annotations" . Data.Aeson.toEncoding) annotations <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkMode" . Data.Aeson.toEncoding) networkMode
        )

instance Data.Aeson.FromJSON ContainerSummaryHostConfig where
    parseJSON = Data.Aeson.withObject "ContainerSummaryHostConfig" $ \o ->
        ContainerSummaryHostConfig
            <$> o Data.Aeson..:? "Annotations"
            <*> o Data.Aeson..:? "NetworkMode"

newtype ContainerSummaryHostConfigAnnotations = ContainerSummaryHostConfigAnnotations
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerSummaryHostConfigAnnotations where
    toJSON (ContainerSummaryHostConfigAnnotations x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerSummaryHostConfigAnnotations x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerSummaryHostConfigAnnotations where
    parseJSON x =
        ContainerSummaryHostConfigAnnotations <$> Data.Aeson.parseJSON x

newtype ContainerSummaryLabels = ContainerSummaryLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerSummaryLabels where
    toJSON (ContainerSummaryLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerSummaryLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerSummaryLabels where
    parseJSON x =
        ContainerSummaryLabels <$> Data.Aeson.parseJSON x

newtype ContainerSummaryNetworkSettings = ContainerSummaryNetworkSettings
    {
        networks :: (Data.Maybe.Maybe (ContainerSummaryNetworkSettingsNetworks))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerSummaryNetworkSettings where
    toJSON ContainerSummaryNetworkSettings {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Networks" Data.Aeson..= networks | Just networks <- [networks] ])

    toEncoding ContainerSummaryNetworkSettings {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Networks" . Data.Aeson.toEncoding) networks
        )

instance Data.Aeson.FromJSON ContainerSummaryNetworkSettings where
    parseJSON = Data.Aeson.withObject "ContainerSummaryNetworkSettings" $ \o ->
        ContainerSummaryNetworkSettings
            <$> o Data.Aeson..:? "Networks"

newtype ContainerSummaryNetworkSettingsNetworks = ContainerSummaryNetworkSettingsNetworks
    (Data.Map.Map Data.Text.Text (EndpointSettings))
    deriving (Show)

instance Data.Aeson.ToJSON ContainerSummaryNetworkSettingsNetworks where
    toJSON (ContainerSummaryNetworkSettingsNetworks x) =
        Data.Aeson.toJSON x

    toEncoding (ContainerSummaryNetworkSettingsNetworks x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ContainerSummaryNetworkSettingsNetworks where
    parseJSON x =
        ContainerSummaryNetworkSettingsNetworks <$> Data.Aeson.parseJSON x

data ContainerSummary = ContainerSummary
    {
        command :: (Data.Maybe.Maybe (Data.Text.Text)),
        created :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        hostConfig :: (Data.Maybe.Maybe (ContainerSummaryHostConfig)),
        id :: (Data.Maybe.Maybe (Data.Text.Text)),
        image :: (Data.Maybe.Maybe (Data.Text.Text)),
        imageID :: (Data.Maybe.Maybe (Data.Text.Text)),
        labels :: (Data.Maybe.Maybe (ContainerSummaryLabels)),
        mounts :: (Data.Maybe.Maybe ([ MountPoint ])),
        names :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        networkSettings :: (Data.Maybe.Maybe (ContainerSummaryNetworkSettings)),
        ports :: (Data.Maybe.Maybe ([ Port ])),
        sizeRootFs :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        sizeRw :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        state :: (Data.Maybe.Maybe (Data.Text.Text)),
        status :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerSummary where
    toJSON ContainerSummary {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Command" Data.Aeson..= command | Just command <- [command] ]
        ++ [ "Created" Data.Aeson..= created | Just created <- [created] ]
        ++ [ "HostConfig" Data.Aeson..= hostConfig | Just hostConfig <- [hostConfig] ]
        ++ [ "Id" Data.Aeson..= id | Just id <- [id] ]
        ++ [ "Image" Data.Aeson..= image | Just image <- [image] ]
        ++ [ "ImageID" Data.Aeson..= imageID | Just imageID <- [imageID] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Mounts" Data.Aeson..= mounts | Just mounts <- [mounts] ]
        ++ [ "Names" Data.Aeson..= names | Just names <- [names] ]
        ++ [ "NetworkSettings" Data.Aeson..= networkSettings | Just networkSettings <- [networkSettings] ]
        ++ [ "Ports" Data.Aeson..= ports | Just ports <- [ports] ]
        ++ [ "SizeRootFs" Data.Aeson..= sizeRootFs | Just sizeRootFs <- [sizeRootFs] ]
        ++ [ "SizeRw" Data.Aeson..= sizeRw | Just sizeRw <- [sizeRw] ]
        ++ [ "State" Data.Aeson..= state | Just state <- [state] ]
        ++ [ "Status" Data.Aeson..= status | Just status <- [status] ])

    toEncoding ContainerSummary {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Command" . Data.Aeson.toEncoding) command <>
          maybe mempty (Data.Aeson.Encoding.pair "Created" . Data.Aeson.toEncoding) created <>
          maybe mempty (Data.Aeson.Encoding.pair "HostConfig" . Data.Aeson.toEncoding) hostConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "Id" . Data.Aeson.toEncoding) id <>
          maybe mempty (Data.Aeson.Encoding.pair "Image" . Data.Aeson.toEncoding) image <>
          maybe mempty (Data.Aeson.Encoding.pair "ImageID" . Data.Aeson.toEncoding) imageID <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Mounts" . Data.Aeson.toEncoding) mounts <>
          maybe mempty (Data.Aeson.Encoding.pair "Names" . Data.Aeson.toEncoding) names <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkSettings" . Data.Aeson.toEncoding) networkSettings <>
          maybe mempty (Data.Aeson.Encoding.pair "Ports" . Data.Aeson.toEncoding) ports <>
          maybe mempty (Data.Aeson.Encoding.pair "SizeRootFs" . Data.Aeson.toEncoding) sizeRootFs <>
          maybe mempty (Data.Aeson.Encoding.pair "SizeRw" . Data.Aeson.toEncoding) sizeRw <>
          maybe mempty (Data.Aeson.Encoding.pair "State" . Data.Aeson.toEncoding) state <>
          maybe mempty (Data.Aeson.Encoding.pair "Status" . Data.Aeson.toEncoding) status
        )

instance Data.Aeson.FromJSON ContainerSummary where
    parseJSON = Data.Aeson.withObject "ContainerSummary" $ \o ->
        ContainerSummary
            <$> o Data.Aeson..:? "Command"
            <*> o Data.Aeson..:? "Created"
            <*> o Data.Aeson..:? "HostConfig"
            <*> o Data.Aeson..:? "Id"
            <*> o Data.Aeson..:? "Image"
            <*> o Data.Aeson..:? "ImageID"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Mounts"
            <*> o Data.Aeson..:? "Names"
            <*> o Data.Aeson..:? "NetworkSettings"
            <*> o Data.Aeson..:? "Ports"
            <*> o Data.Aeson..:? "SizeRootFs"
            <*> o Data.Aeson..:? "SizeRw"
            <*> o Data.Aeson..:? "State"
            <*> o Data.Aeson..:? "Status"