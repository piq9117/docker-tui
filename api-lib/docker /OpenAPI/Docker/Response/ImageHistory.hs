{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ImageHistory where

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

data ImageHistoryResponseBody200 = ImageHistoryResponseBody200
    {
        comment :: Data.Text.Text,
        created :: GHC.Int.Int64,
        createdBy :: Data.Text.Text,
        id :: Data.Text.Text,
        size :: GHC.Int.Int64,
        tags :: [ Data.Text.Text ]
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageHistoryResponseBody200 where
    toJSON ImageHistoryResponseBody200 {..} = Data.Aeson.object
        ([ "Comment" Data.Aeson..= comment,
           "Created" Data.Aeson..= created,
           "CreatedBy" Data.Aeson..= createdBy,
           "Id" Data.Aeson..= id,
           "Size" Data.Aeson..= size,
           "Tags" Data.Aeson..= tags
        ]
        )

    toEncoding ImageHistoryResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Comment" (Data.Aeson.toEncoding comment) <>
          Data.Aeson.Encoding.pair "Created" (Data.Aeson.toEncoding created) <>
          Data.Aeson.Encoding.pair "CreatedBy" (Data.Aeson.toEncoding createdBy) <>
          Data.Aeson.Encoding.pair "Id" (Data.Aeson.toEncoding id) <>
          Data.Aeson.Encoding.pair "Size" (Data.Aeson.toEncoding size) <>
          Data.Aeson.Encoding.pair "Tags" (Data.Aeson.toEncoding tags)
        )

instance Data.Aeson.FromJSON ImageHistoryResponseBody200 where
    parseJSON = Data.Aeson.withObject "ImageHistoryResponseBody200" $ \o ->
        ImageHistoryResponseBody200
            <$> o Data.Aeson..: "Comment"
            <*> o Data.Aeson..: "Created"
            <*> o Data.Aeson..: "CreatedBy"
            <*> o Data.Aeson..: "Id"
            <*> o Data.Aeson..: "Size"
            <*> o Data.Aeson..: "Tags"

data ImageHistoryResponse
    = ImageHistoryResponse200 [ ImageHistoryResponseBody200 ]
    | ImageHistoryResponse404 ErrorResponse
    | ImageHistoryResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ImageHistoryResponse where
    toResponse (ImageHistoryResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ImageHistoryResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ImageHistoryResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ImageHistoryResponse Network.HTTP.Types.Status where
    getField (ImageHistoryResponse200 {}) = Network.HTTP.Types.status200
    getField (ImageHistoryResponse404 {}) = Network.HTTP.Types.status404
    getField (ImageHistoryResponse500 {}) = Network.HTTP.Types.status500