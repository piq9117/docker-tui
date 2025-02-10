{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Node where

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



import OpenAPI.Docker.Schemas.ManagerStatus
import OpenAPI.Docker.Schemas.NodeDescription
import OpenAPI.Docker.Schemas.NodeSpec
import OpenAPI.Docker.Schemas.NodeStatus
import OpenAPI.Docker.Schemas.ObjectVersion

data Node = Node
    {
        createdAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        description :: (Data.Maybe.Maybe (NodeDescription)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        managerStatus :: (Data.Maybe.Maybe (ManagerStatus)),
        spec :: (Data.Maybe.Maybe (NodeSpec)),
        status :: (Data.Maybe.Maybe (NodeStatus)),
        updatedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        version :: (Data.Maybe.Maybe (ObjectVersion))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Node where
    toJSON Node {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CreatedAt" Data.Aeson..= createdAt | Just createdAt <- [createdAt] ]
        ++ [ "Description" Data.Aeson..= description | Just description <- [description] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "ManagerStatus" Data.Aeson..= managerStatus | Just managerStatus <- [managerStatus] ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ]
        ++ [ "Status" Data.Aeson..= status | Just status <- [status] ]
        ++ [ "UpdatedAt" Data.Aeson..= updatedAt | Just updatedAt <- [updatedAt] ]
        ++ [ "Version" Data.Aeson..= version | Just version <- [version] ])

    toEncoding Node {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CreatedAt" . Data.Aeson.toEncoding) createdAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Description" . Data.Aeson.toEncoding) description <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "ManagerStatus" . Data.Aeson.toEncoding) managerStatus <>
          maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec <>
          maybe mempty (Data.Aeson.Encoding.pair "Status" . Data.Aeson.toEncoding) status <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdatedAt" . Data.Aeson.toEncoding) updatedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Version" . Data.Aeson.toEncoding) version
        )

instance Data.Aeson.FromJSON Node where
    parseJSON = Data.Aeson.withObject "Node" $ \o ->
        Node
            <$> o Data.Aeson..:? "CreatedAt"
            <*> o Data.Aeson..:? "Description"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "ManagerStatus"
            <*> o Data.Aeson..:? "Spec"
            <*> o Data.Aeson..:? "Status"
            <*> o Data.Aeson..:? "UpdatedAt"
            <*> o Data.Aeson..:? "Version"