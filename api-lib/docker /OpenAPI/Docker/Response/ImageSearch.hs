{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ImageSearch where

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

data ImageSearchResponseBody200 = ImageSearchResponseBody200
    {
        description :: (Data.Maybe.Maybe (Data.Text.Text)),
        isAutomated :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        isOfficial :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        starCount :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageSearchResponseBody200 where
    toJSON ImageSearchResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "description" Data.Aeson..= description | Just description <- [description] ]
        ++ [ "is_automated" Data.Aeson..= isAutomated | Just isAutomated <- [isAutomated] ]
        ++ [ "is_official" Data.Aeson..= isOfficial | Just isOfficial <- [isOfficial] ]
        ++ [ "name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "star_count" Data.Aeson..= starCount | Just starCount <- [starCount] ])

    toEncoding ImageSearchResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "description" . Data.Aeson.toEncoding) description <>
          maybe mempty (Data.Aeson.Encoding.pair "is_automated" . Data.Aeson.toEncoding) isAutomated <>
          maybe mempty (Data.Aeson.Encoding.pair "is_official" . Data.Aeson.toEncoding) isOfficial <>
          maybe mempty (Data.Aeson.Encoding.pair "name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "star_count" . Data.Aeson.toEncoding) starCount
        )

instance Data.Aeson.FromJSON ImageSearchResponseBody200 where
    parseJSON = Data.Aeson.withObject "ImageSearchResponseBody200" $ \o ->
        ImageSearchResponseBody200
            <$> o Data.Aeson..:? "description"
            <*> o Data.Aeson..:? "is_automated"
            <*> o Data.Aeson..:? "is_official"
            <*> o Data.Aeson..:? "name"
            <*> o Data.Aeson..:? "star_count"

data ImageSearchResponse
    = ImageSearchResponse200 [ ImageSearchResponseBody200 ]
    | ImageSearchResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ImageSearchResponse where
    toResponse (ImageSearchResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ImageSearchResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ImageSearchResponse Network.HTTP.Types.Status where
    getField (ImageSearchResponse200 {}) = Network.HTTP.Types.status200
    getField (ImageSearchResponse500 {}) = Network.HTTP.Types.status500