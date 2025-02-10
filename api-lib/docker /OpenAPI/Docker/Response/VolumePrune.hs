{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.VolumePrune where

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

data VolumePruneResponseBody200 = VolumePruneResponseBody200
    {
        spaceReclaimed :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        volumesDeleted :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON VolumePruneResponseBody200 where
    toJSON VolumePruneResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "SpaceReclaimed" Data.Aeson..= spaceReclaimed | Just spaceReclaimed <- [spaceReclaimed] ]
        ++ [ "VolumesDeleted" Data.Aeson..= volumesDeleted | Just volumesDeleted <- [volumesDeleted] ])

    toEncoding VolumePruneResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "SpaceReclaimed" . Data.Aeson.toEncoding) spaceReclaimed <>
          maybe mempty (Data.Aeson.Encoding.pair "VolumesDeleted" . Data.Aeson.toEncoding) volumesDeleted
        )

instance Data.Aeson.FromJSON VolumePruneResponseBody200 where
    parseJSON = Data.Aeson.withObject "VolumePruneResponseBody200" $ \o ->
        VolumePruneResponseBody200
            <$> o Data.Aeson..:? "SpaceReclaimed"
            <*> o Data.Aeson..:? "VolumesDeleted"

data VolumePruneResponse
    = VolumePruneResponse200 VolumePruneResponseBody200
    | VolumePruneResponse500 ErrorResponse
    deriving (Show)

instance ToResponse VolumePruneResponse where
    toResponse (VolumePruneResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (VolumePruneResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" VolumePruneResponse Network.HTTP.Types.Status where
    getField (VolumePruneResponse200 {}) = Network.HTTP.Types.status200
    getField (VolumePruneResponse500 {}) = Network.HTTP.Types.status500