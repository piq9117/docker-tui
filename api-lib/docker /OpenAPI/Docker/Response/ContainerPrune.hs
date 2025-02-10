{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerPrune where

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

import OpenAPI.Docker.Schemas.ErrorResponse

import OpenAPI.Docker.Response

data ContainerPruneResponseBody200 = ContainerPruneResponseBody200
    {
        containersDeleted :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        spaceReclaimed :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerPruneResponseBody200 where
    toJSON ContainerPruneResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ContainersDeleted" Data.Aeson..= containersDeleted | Just containersDeleted <- [containersDeleted] ]
        ++ [ "SpaceReclaimed" Data.Aeson..= spaceReclaimed | Just spaceReclaimed <- [spaceReclaimed] ])

    toEncoding ContainerPruneResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ContainersDeleted" . Data.Aeson.toEncoding) containersDeleted <>
          maybe mempty (Data.Aeson.Encoding.pair "SpaceReclaimed" . Data.Aeson.toEncoding) spaceReclaimed
        )

instance Data.Aeson.FromJSON ContainerPruneResponseBody200 where
    parseJSON = Data.Aeson.withObject "ContainerPruneResponseBody200" $ \o ->
        ContainerPruneResponseBody200
            <$> o Data.Aeson..:? "ContainersDeleted"
            <*> o Data.Aeson..:? "SpaceReclaimed"

data ContainerPruneResponse
    = ContainerPruneResponse200 ContainerPruneResponseBody200
    | ContainerPruneResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerPruneResponse where
    toResponse (ContainerPruneResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerPruneResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerPruneResponse Network.HTTP.Types.Status where
    getField (ContainerPruneResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerPruneResponse500 {}) = Network.HTTP.Types.status500