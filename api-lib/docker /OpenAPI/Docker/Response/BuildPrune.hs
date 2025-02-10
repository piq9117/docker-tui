{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.BuildPrune where

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

data BuildPruneResponseBody200 = BuildPruneResponseBody200
    {
        cachesDeleted :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        spaceReclaimed :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON BuildPruneResponseBody200 where
    toJSON BuildPruneResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CachesDeleted" Data.Aeson..= cachesDeleted | Just cachesDeleted <- [cachesDeleted] ]
        ++ [ "SpaceReclaimed" Data.Aeson..= spaceReclaimed | Just spaceReclaimed <- [spaceReclaimed] ])

    toEncoding BuildPruneResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CachesDeleted" . Data.Aeson.toEncoding) cachesDeleted <>
          maybe mempty (Data.Aeson.Encoding.pair "SpaceReclaimed" . Data.Aeson.toEncoding) spaceReclaimed
        )

instance Data.Aeson.FromJSON BuildPruneResponseBody200 where
    parseJSON = Data.Aeson.withObject "BuildPruneResponseBody200" $ \o ->
        BuildPruneResponseBody200
            <$> o Data.Aeson..:? "CachesDeleted"
            <*> o Data.Aeson..:? "SpaceReclaimed"

data BuildPruneResponse
    = BuildPruneResponse200 BuildPruneResponseBody200
    | BuildPruneResponse500 ErrorResponse
    deriving (Show)

instance ToResponse BuildPruneResponse where
    toResponse (BuildPruneResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (BuildPruneResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" BuildPruneResponse Network.HTTP.Types.Status where
    getField (BuildPruneResponse200 {}) = Network.HTTP.Types.status200
    getField (BuildPruneResponse500 {}) = Network.HTTP.Types.status500