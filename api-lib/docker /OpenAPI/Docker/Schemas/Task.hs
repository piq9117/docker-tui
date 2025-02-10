{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Task where

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



import OpenAPI.Docker.Schemas.GenericResources
import OpenAPI.Docker.Schemas.ObjectVersion
import OpenAPI.Docker.Schemas.TaskSpec
import OpenAPI.Docker.Schemas.TaskState
import OpenAPI.Docker.Schemas.TaskStatus

newtype TaskLabels = TaskLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON TaskLabels where
    toJSON (TaskLabels x) =
        Data.Aeson.toJSON x

    toEncoding (TaskLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON TaskLabels where
    parseJSON x =
        TaskLabels <$> Data.Aeson.parseJSON x

data Task = Task
    {
        assignedGenericResources :: (Data.Maybe.Maybe (GenericResources)),
        createdAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        desiredState :: (Data.Maybe.Maybe (TaskState)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        jobIteration :: (Data.Maybe.Maybe (ObjectVersion)),
        labels :: (Data.Maybe.Maybe (TaskLabels)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        nodeID :: (Data.Maybe.Maybe (Data.Text.Text)),
        serviceID :: (Data.Maybe.Maybe (Data.Text.Text)),
        slot :: (Data.Maybe.Maybe (GHC.Int.Int)),
        spec :: (Data.Maybe.Maybe (TaskSpec)),
        status :: (Data.Maybe.Maybe (TaskStatus)),
        updatedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        version :: (Data.Maybe.Maybe (ObjectVersion))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Task where
    toJSON Task {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AssignedGenericResources" Data.Aeson..= assignedGenericResources | Just assignedGenericResources <- [assignedGenericResources] ]
        ++ [ "CreatedAt" Data.Aeson..= createdAt | Just createdAt <- [createdAt] ]
        ++ [ "DesiredState" Data.Aeson..= desiredState | Just desiredState <- [desiredState] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "JobIteration" Data.Aeson..= jobIteration | Just jobIteration <- [jobIteration] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "NodeID" Data.Aeson..= nodeID | Just nodeID <- [nodeID] ]
        ++ [ "ServiceID" Data.Aeson..= serviceID | Just serviceID <- [serviceID] ]
        ++ [ "Slot" Data.Aeson..= slot | Just slot <- [slot] ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ]
        ++ [ "Status" Data.Aeson..= status | Just status <- [status] ]
        ++ [ "UpdatedAt" Data.Aeson..= updatedAt | Just updatedAt <- [updatedAt] ]
        ++ [ "Version" Data.Aeson..= version | Just version <- [version] ])

    toEncoding Task {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AssignedGenericResources" . Data.Aeson.toEncoding) assignedGenericResources <>
          maybe mempty (Data.Aeson.Encoding.pair "CreatedAt" . Data.Aeson.toEncoding) createdAt <>
          maybe mempty (Data.Aeson.Encoding.pair "DesiredState" . Data.Aeson.toEncoding) desiredState <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "JobIteration" . Data.Aeson.toEncoding) jobIteration <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "NodeID" . Data.Aeson.toEncoding) nodeID <>
          maybe mempty (Data.Aeson.Encoding.pair "ServiceID" . Data.Aeson.toEncoding) serviceID <>
          maybe mempty (Data.Aeson.Encoding.pair "Slot" . Data.Aeson.toEncoding) slot <>
          maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec <>
          maybe mempty (Data.Aeson.Encoding.pair "Status" . Data.Aeson.toEncoding) status <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdatedAt" . Data.Aeson.toEncoding) updatedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Version" . Data.Aeson.toEncoding) version
        )

instance Data.Aeson.FromJSON Task where
    parseJSON = Data.Aeson.withObject "Task" $ \o ->
        Task
            <$> o Data.Aeson..:? "AssignedGenericResources"
            <*> o Data.Aeson..:? "CreatedAt"
            <*> o Data.Aeson..:? "DesiredState"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "JobIteration"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "NodeID"
            <*> o Data.Aeson..:? "ServiceID"
            <*> o Data.Aeson..:? "Slot"
            <*> o Data.Aeson..:? "Spec"
            <*> o Data.Aeson..:? "Status"
            <*> o Data.Aeson..:? "UpdatedAt"
            <*> o Data.Aeson..:? "Version"