{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.SwarmInfo where

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



import OpenAPI.Docker.Schemas.ClusterInfo
import OpenAPI.Docker.Schemas.LocalNodeState
import OpenAPI.Docker.Schemas.PeerNode

data SwarmInfo = SwarmInfo
    {
        cluster :: (Data.Maybe.Maybe (ClusterInfo)),
        controlAvailable :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        error :: (Data.Maybe.Maybe (Data.Text.Text)),
        localNodeState :: (Data.Maybe.Maybe (LocalNodeState)),
        managers :: (Data.Maybe.Maybe (GHC.Int.Int)),
        nodeAddr :: (Data.Maybe.Maybe (Data.Text.Text)),
        nodeID :: (Data.Maybe.Maybe (Data.Text.Text)),
        nodes :: (Data.Maybe.Maybe (GHC.Int.Int)),
        remoteManagers :: (Data.Maybe.Maybe ([ PeerNode ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmInfo where
    toJSON SwarmInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Cluster" Data.Aeson..= cluster | Just cluster <- [cluster] ]
        ++ [ "ControlAvailable" Data.Aeson..= controlAvailable | Just controlAvailable <- [controlAvailable] ]
        ++ [ "Error" Data.Aeson..= error | Just error <- [error] ]
        ++ [ "LocalNodeState" Data.Aeson..= localNodeState | Just localNodeState <- [localNodeState] ]
        ++ [ "Managers" Data.Aeson..= managers | Just managers <- [managers] ]
        ++ [ "NodeAddr" Data.Aeson..= nodeAddr | Just nodeAddr <- [nodeAddr] ]
        ++ [ "NodeID" Data.Aeson..= nodeID | Just nodeID <- [nodeID] ]
        ++ [ "Nodes" Data.Aeson..= nodes | Just nodes <- [nodes] ]
        ++ [ "RemoteManagers" Data.Aeson..= remoteManagers | Just remoteManagers <- [remoteManagers] ])

    toEncoding SwarmInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Cluster" . Data.Aeson.toEncoding) cluster <>
          maybe mempty (Data.Aeson.Encoding.pair "ControlAvailable" . Data.Aeson.toEncoding) controlAvailable <>
          maybe mempty (Data.Aeson.Encoding.pair "Error" . Data.Aeson.toEncoding) error <>
          maybe mempty (Data.Aeson.Encoding.pair "LocalNodeState" . Data.Aeson.toEncoding) localNodeState <>
          maybe mempty (Data.Aeson.Encoding.pair "Managers" . Data.Aeson.toEncoding) managers <>
          maybe mempty (Data.Aeson.Encoding.pair "NodeAddr" . Data.Aeson.toEncoding) nodeAddr <>
          maybe mempty (Data.Aeson.Encoding.pair "NodeID" . Data.Aeson.toEncoding) nodeID <>
          maybe mempty (Data.Aeson.Encoding.pair "Nodes" . Data.Aeson.toEncoding) nodes <>
          maybe mempty (Data.Aeson.Encoding.pair "RemoteManagers" . Data.Aeson.toEncoding) remoteManagers
        )

instance Data.Aeson.FromJSON SwarmInfo where
    parseJSON = Data.Aeson.withObject "SwarmInfo" $ \o ->
        SwarmInfo
            <$> o Data.Aeson..:? "Cluster"
            <*> o Data.Aeson..:? "ControlAvailable"
            <*> o Data.Aeson..:? "Error"
            <*> o Data.Aeson..:? "LocalNodeState"
            <*> o Data.Aeson..:? "Managers"
            <*> o Data.Aeson..:? "NodeAddr"
            <*> o Data.Aeson..:? "NodeID"
            <*> o Data.Aeson..:? "Nodes"
            <*> o Data.Aeson..:? "RemoteManagers"