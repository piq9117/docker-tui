{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ClusterVolume where

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



import OpenAPI.Docker.Schemas.ClusterVolumeSpec
import OpenAPI.Docker.Schemas.ObjectVersion
import OpenAPI.Docker.Schemas.Topology

data ClusterVolumeInfo = ClusterVolumeInfo
    {
        accessibleTopology :: (Data.Maybe.Maybe ([ Topology ])),
        capacityBytes :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        volumeContext :: (Data.Maybe.Maybe (ClusterVolumeInfoVolumeContext)),
        volumeID :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumeInfo where
    toJSON ClusterVolumeInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AccessibleTopology" Data.Aeson..= accessibleTopology | Just accessibleTopology <- [accessibleTopology] ]
        ++ [ "CapacityBytes" Data.Aeson..= capacityBytes | Just capacityBytes <- [capacityBytes] ]
        ++ [ "VolumeContext" Data.Aeson..= volumeContext | Just volumeContext <- [volumeContext] ]
        ++ [ "VolumeID" Data.Aeson..= volumeID | Just volumeID <- [volumeID] ])

    toEncoding ClusterVolumeInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AccessibleTopology" . Data.Aeson.toEncoding) accessibleTopology <>
          maybe mempty (Data.Aeson.Encoding.pair "CapacityBytes" . Data.Aeson.toEncoding) capacityBytes <>
          maybe mempty (Data.Aeson.Encoding.pair "VolumeContext" . Data.Aeson.toEncoding) volumeContext <>
          maybe mempty (Data.Aeson.Encoding.pair "VolumeID" . Data.Aeson.toEncoding) volumeID
        )

instance Data.Aeson.FromJSON ClusterVolumeInfo where
    parseJSON = Data.Aeson.withObject "ClusterVolumeInfo" $ \o ->
        ClusterVolumeInfo
            <$> o Data.Aeson..:? "AccessibleTopology"
            <*> o Data.Aeson..:? "CapacityBytes"
            <*> o Data.Aeson..:? "VolumeContext"
            <*> o Data.Aeson..:? "VolumeID"

newtype ClusterVolumeInfoVolumeContext = ClusterVolumeInfoVolumeContext
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumeInfoVolumeContext where
    toJSON (ClusterVolumeInfoVolumeContext x) =
        Data.Aeson.toJSON x

    toEncoding (ClusterVolumeInfoVolumeContext x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ClusterVolumeInfoVolumeContext where
    parseJSON x =
        ClusterVolumeInfoVolumeContext <$> Data.Aeson.parseJSON x

data ClusterVolumePublishStatus = ClusterVolumePublishStatus
    {
        nodeID :: (Data.Maybe.Maybe (Data.Text.Text)),
        publishContext :: (Data.Maybe.Maybe (ClusterVolumePublishStatusPublishContext)),
        state :: (Data.Maybe.Maybe (ClusterVolumePublishStatusState))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumePublishStatus where
    toJSON ClusterVolumePublishStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "NodeID" Data.Aeson..= nodeID | Just nodeID <- [nodeID] ]
        ++ [ "PublishContext" Data.Aeson..= publishContext | Just publishContext <- [publishContext] ]
        ++ [ "State" Data.Aeson..= state | Just state <- [state] ])

    toEncoding ClusterVolumePublishStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "NodeID" . Data.Aeson.toEncoding) nodeID <>
          maybe mempty (Data.Aeson.Encoding.pair "PublishContext" . Data.Aeson.toEncoding) publishContext <>
          maybe mempty (Data.Aeson.Encoding.pair "State" . Data.Aeson.toEncoding) state
        )

instance Data.Aeson.FromJSON ClusterVolumePublishStatus where
    parseJSON = Data.Aeson.withObject "ClusterVolumePublishStatus" $ \o ->
        ClusterVolumePublishStatus
            <$> o Data.Aeson..:? "NodeID"
            <*> o Data.Aeson..:? "PublishContext"
            <*> o Data.Aeson..:? "State"

newtype ClusterVolumePublishStatusPublishContext = ClusterVolumePublishStatusPublishContext
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumePublishStatusPublishContext where
    toJSON (ClusterVolumePublishStatusPublishContext x) =
        Data.Aeson.toJSON x

    toEncoding (ClusterVolumePublishStatusPublishContext x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ClusterVolumePublishStatusPublishContext where
    parseJSON x =
        ClusterVolumePublishStatusPublishContext <$> Data.Aeson.parseJSON x

data ClusterVolumePublishStatusState
    = ClusterVolumePublishStatusStatePendingPublish
    | ClusterVolumePublishStatusStatePublished
    | ClusterVolumePublishStatusStatePendingNodeUnpublish
    | ClusterVolumePublishStatusStatePendingControllerUnpublish
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ClusterVolumePublishStatusState where
    toJSON x = case x of
        ClusterVolumePublishStatusStatePendingPublish -> "pending-publish"
        ClusterVolumePublishStatusStatePublished -> "published"
        ClusterVolumePublishStatusStatePendingNodeUnpublish -> "pending-node-unpublish"
        ClusterVolumePublishStatusStatePendingControllerUnpublish -> "pending-controller-unpublish"

    toEncoding x = case x of
        ClusterVolumePublishStatusStatePendingPublish -> Data.Aeson.Encoding.text "pending-publish"
        ClusterVolumePublishStatusStatePublished -> Data.Aeson.Encoding.text "published"
        ClusterVolumePublishStatusStatePendingNodeUnpublish -> Data.Aeson.Encoding.text "pending-node-unpublish"
        ClusterVolumePublishStatusStatePendingControllerUnpublish -> Data.Aeson.Encoding.text "pending-controller-unpublish"

instance Data.Aeson.FromJSON ClusterVolumePublishStatusState where
    parseJSON = Data.Aeson.withText "ClusterVolumePublishStatusState" $ \s ->
        case s of
            "pending-publish" -> pure ClusterVolumePublishStatusStatePendingPublish
            "published" -> pure ClusterVolumePublishStatusStatePublished
            "pending-node-unpublish" -> pure ClusterVolumePublishStatusStatePendingNodeUnpublish
            "pending-controller-unpublish" -> pure ClusterVolumePublishStatusStatePendingControllerUnpublish
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ClusterVolumePublishStatusState where
    toQueryParam x = case x of
        ClusterVolumePublishStatusStatePendingPublish -> "pending-publish"
        ClusterVolumePublishStatusStatePublished -> "published"
        ClusterVolumePublishStatusStatePendingNodeUnpublish -> "pending-node-unpublish"
        ClusterVolumePublishStatusStatePendingControllerUnpublish -> "pending-controller-unpublish"

instance Web.HttpApiData.FromHttpApiData ClusterVolumePublishStatusState where
    parseUrlPiece x =
        case x of
            "pending-publish" -> pure ClusterVolumePublishStatusStatePendingPublish
            "published" -> pure ClusterVolumePublishStatusStatePublished
            "pending-node-unpublish" -> pure ClusterVolumePublishStatusStatePendingNodeUnpublish
            "pending-controller-unpublish" -> pure ClusterVolumePublishStatusStatePendingControllerUnpublish
            _ -> Left "invalid enum value"

data ClusterVolume = ClusterVolume
    {
        createdAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        info :: (Data.Maybe.Maybe (ClusterVolumeInfo)),
        publishStatus :: (Data.Maybe.Maybe ([ ClusterVolumePublishStatus ])),
        spec :: (Data.Maybe.Maybe (ClusterVolumeSpec)),
        updatedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        version :: (Data.Maybe.Maybe (ObjectVersion))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolume where
    toJSON ClusterVolume {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CreatedAt" Data.Aeson..= createdAt | Just createdAt <- [createdAt] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "Info" Data.Aeson..= info | Just info <- [info] ]
        ++ [ "PublishStatus" Data.Aeson..= publishStatus | Just publishStatus <- [publishStatus] ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ]
        ++ [ "UpdatedAt" Data.Aeson..= updatedAt | Just updatedAt <- [updatedAt] ]
        ++ [ "Version" Data.Aeson..= version | Just version <- [version] ])

    toEncoding ClusterVolume {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CreatedAt" . Data.Aeson.toEncoding) createdAt <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "Info" . Data.Aeson.toEncoding) info <>
          maybe mempty (Data.Aeson.Encoding.pair "PublishStatus" . Data.Aeson.toEncoding) publishStatus <>
          maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdatedAt" . Data.Aeson.toEncoding) updatedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Version" . Data.Aeson.toEncoding) version
        )

instance Data.Aeson.FromJSON ClusterVolume where
    parseJSON = Data.Aeson.withObject "ClusterVolume" $ \o ->
        ClusterVolume
            <$> o Data.Aeson..:? "CreatedAt"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "Info"
            <*> o Data.Aeson..:? "PublishStatus"
            <*> o Data.Aeson..:? "Spec"
            <*> o Data.Aeson..:? "UpdatedAt"
            <*> o Data.Aeson..:? "Version"