{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Volume where

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



import OpenAPI.Docker.Schemas.ClusterVolume

newtype VolumeLabels = VolumeLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON VolumeLabels where
    toJSON (VolumeLabels x) =
        Data.Aeson.toJSON x

    toEncoding (VolumeLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON VolumeLabels where
    parseJSON x =
        VolumeLabels <$> Data.Aeson.parseJSON x

newtype VolumeOptions = VolumeOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON VolumeOptions where
    toJSON (VolumeOptions x) =
        Data.Aeson.toJSON x

    toEncoding (VolumeOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON VolumeOptions where
    parseJSON x =
        VolumeOptions <$> Data.Aeson.parseJSON x

data VolumeScope
    = VolumeScopeLocal
    | VolumeScopeGlobal
    deriving (Eq, Show)

instance Data.Aeson.ToJSON VolumeScope where
    toJSON x = case x of
        VolumeScopeLocal -> "local"
        VolumeScopeGlobal -> "global"

    toEncoding x = case x of
        VolumeScopeLocal -> Data.Aeson.Encoding.text "local"
        VolumeScopeGlobal -> Data.Aeson.Encoding.text "global"

instance Data.Aeson.FromJSON VolumeScope where
    parseJSON = Data.Aeson.withText "VolumeScope" $ \s ->
        case s of
            "local" -> pure VolumeScopeLocal
            "global" -> pure VolumeScopeGlobal
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData VolumeScope where
    toQueryParam x = case x of
        VolumeScopeLocal -> "local"
        VolumeScopeGlobal -> "global"

instance Web.HttpApiData.FromHttpApiData VolumeScope where
    parseUrlPiece x =
        case x of
            "local" -> pure VolumeScopeLocal
            "global" -> pure VolumeScopeGlobal
            _ -> Left "invalid enum value"

newtype VolumeStatus = VolumeStatus
    (Data.Map.Map Data.Text.Text (VolumeStatusAdditionalProperties))
    deriving (Show)

instance Data.Aeson.ToJSON VolumeStatus where
    toJSON (VolumeStatus x) =
        Data.Aeson.toJSON x

    toEncoding (VolumeStatus x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON VolumeStatus where
    parseJSON x =
        VolumeStatus <$> Data.Aeson.parseJSON x

data VolumeStatusAdditionalProperties = VolumeStatusAdditionalProperties
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON VolumeStatusAdditionalProperties where
    toJSON VolumeStatusAdditionalProperties {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding VolumeStatusAdditionalProperties {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON VolumeStatusAdditionalProperties where
    parseJSON = Data.Aeson.withObject "VolumeStatusAdditionalProperties" $ \o ->
        VolumeStatusAdditionalProperties
            

data VolumeUsageData = VolumeUsageData
    {
        refCount :: GHC.Int.Int64,
        size :: GHC.Int.Int64
    }
    deriving (Show)

instance Data.Aeson.ToJSON VolumeUsageData where
    toJSON VolumeUsageData {..} = Data.Aeson.object
        ([ "RefCount" Data.Aeson..= refCount,
           "Size" Data.Aeson..= size
        ]
        )

    toEncoding VolumeUsageData {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "RefCount" (Data.Aeson.toEncoding refCount) <>
          Data.Aeson.Encoding.pair "Size" (Data.Aeson.toEncoding size)
        )

instance Data.Aeson.FromJSON VolumeUsageData where
    parseJSON = Data.Aeson.withObject "VolumeUsageData" $ \o ->
        VolumeUsageData
            <$> o Data.Aeson..: "RefCount"
            <*> o Data.Aeson..: "Size"

data Volume = Volume
    {
        clusterVolume :: (Data.Maybe.Maybe (ClusterVolume)),
        createdAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        driver :: Data.Text.Text,
        labels :: VolumeLabels,
        mountpoint :: Data.Text.Text,
        name :: Data.Text.Text,
        options :: VolumeOptions,
        scope :: VolumeScope,
        status :: (Data.Maybe.Maybe (VolumeStatus)),
        usageData :: (Data.Maybe.Maybe (VolumeUsageData))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Volume where
    toJSON Volume {..} = Data.Aeson.object
        ([ "Driver" Data.Aeson..= driver,
           "Labels" Data.Aeson..= labels,
           "Mountpoint" Data.Aeson..= mountpoint,
           "Name" Data.Aeson..= name,
           "Options" Data.Aeson..= options,
           "Scope" Data.Aeson..= scope
        ]
        ++ [ "ClusterVolume" Data.Aeson..= clusterVolume | Just clusterVolume <- [clusterVolume] ]
        ++ [ "CreatedAt" Data.Aeson..= createdAt | Just createdAt <- [createdAt] ]
        ++ [ "Status" Data.Aeson..= status | Just status <- [status] ]
        ++ [ "UsageData" Data.Aeson..= usageData | Just usageData <- [usageData] ])

    toEncoding Volume {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ClusterVolume" . Data.Aeson.toEncoding) clusterVolume <>
          maybe mempty (Data.Aeson.Encoding.pair "CreatedAt" . Data.Aeson.toEncoding) createdAt <>
          Data.Aeson.Encoding.pair "Driver" (Data.Aeson.toEncoding driver) <>
          Data.Aeson.Encoding.pair "Labels" (Data.Aeson.toEncoding labels) <>
          Data.Aeson.Encoding.pair "Mountpoint" (Data.Aeson.toEncoding mountpoint) <>
          Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name) <>
          Data.Aeson.Encoding.pair "Options" (Data.Aeson.toEncoding options) <>
          Data.Aeson.Encoding.pair "Scope" (Data.Aeson.toEncoding scope) <>
          maybe mempty (Data.Aeson.Encoding.pair "Status" . Data.Aeson.toEncoding) status <>
          maybe mempty (Data.Aeson.Encoding.pair "UsageData" . Data.Aeson.toEncoding) usageData
        )

instance Data.Aeson.FromJSON Volume where
    parseJSON = Data.Aeson.withObject "Volume" $ \o ->
        Volume
            <$> o Data.Aeson..:? "ClusterVolume"
            <*> o Data.Aeson..:? "CreatedAt"
            <*> o Data.Aeson..: "Driver"
            <*> o Data.Aeson..: "Labels"
            <*> o Data.Aeson..: "Mountpoint"
            <*> o Data.Aeson..: "Name"
            <*> o Data.Aeson..: "Options"
            <*> o Data.Aeson..: "Scope"
            <*> o Data.Aeson..:? "Status"
            <*> o Data.Aeson..:? "UsageData"