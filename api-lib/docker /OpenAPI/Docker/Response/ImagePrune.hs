{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ImagePrune where

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
import OpenAPI.Docker.Schemas.ImageDeleteResponseItem

import OpenAPI.Docker.Response

data ImagePruneResponseBody200 = ImagePruneResponseBody200
    {
        imagesDeleted :: (Data.Maybe.Maybe ([ ImageDeleteResponseItem ])),
        spaceReclaimed :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImagePruneResponseBody200 where
    toJSON ImagePruneResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ImagesDeleted" Data.Aeson..= imagesDeleted | Just imagesDeleted <- [imagesDeleted] ]
        ++ [ "SpaceReclaimed" Data.Aeson..= spaceReclaimed | Just spaceReclaimed <- [spaceReclaimed] ])

    toEncoding ImagePruneResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ImagesDeleted" . Data.Aeson.toEncoding) imagesDeleted <>
          maybe mempty (Data.Aeson.Encoding.pair "SpaceReclaimed" . Data.Aeson.toEncoding) spaceReclaimed
        )

instance Data.Aeson.FromJSON ImagePruneResponseBody200 where
    parseJSON = Data.Aeson.withObject "ImagePruneResponseBody200" $ \o ->
        ImagePruneResponseBody200
            <$> o Data.Aeson..:? "ImagesDeleted"
            <*> o Data.Aeson..:? "SpaceReclaimed"

data ImagePruneResponse
    = ImagePruneResponse200 ImagePruneResponseBody200
    | ImagePruneResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ImagePruneResponse where
    toResponse (ImagePruneResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ImagePruneResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ImagePruneResponse Network.HTTP.Types.Status where
    getField (ImagePruneResponse200 {}) = Network.HTTP.Types.status200
    getField (ImagePruneResponse500 {}) = Network.HTTP.Types.status500