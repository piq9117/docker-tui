{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SwarmUnlockkey where

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

newtype SwarmUnlockkeyResponseBody200 = SwarmUnlockkeyResponseBody200
    {
        unlockKey :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmUnlockkeyResponseBody200 where
    toJSON SwarmUnlockkeyResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "UnlockKey" Data.Aeson..= unlockKey | Just unlockKey <- [unlockKey] ])

    toEncoding SwarmUnlockkeyResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "UnlockKey" . Data.Aeson.toEncoding) unlockKey
        )

instance Data.Aeson.FromJSON SwarmUnlockkeyResponseBody200 where
    parseJSON = Data.Aeson.withObject "SwarmUnlockkeyResponseBody200" $ \o ->
        SwarmUnlockkeyResponseBody200
            <$> o Data.Aeson..:? "UnlockKey"

newtype SwarmUnlockkeyResponseBody200 = SwarmUnlockkeyResponseBody200
    {
        unlockKey :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmUnlockkeyResponseBody200 where
    toJSON SwarmUnlockkeyResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "UnlockKey" Data.Aeson..= unlockKey | Just unlockKey <- [unlockKey] ])

    toEncoding SwarmUnlockkeyResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "UnlockKey" . Data.Aeson.toEncoding) unlockKey
        )

instance Data.Aeson.FromJSON SwarmUnlockkeyResponseBody200 where
    parseJSON = Data.Aeson.withObject "SwarmUnlockkeyResponseBody200" $ \o ->
        SwarmUnlockkeyResponseBody200
            <$> o Data.Aeson..:? "UnlockKey"

data SwarmUnlockkeyResponse
    = SwarmUnlockkeyResponse200 SwarmUnlockkeyResponseBody200
    | SwarmUnlockkeyResponse500 ErrorResponse
    | SwarmUnlockkeyResponse503 ErrorResponse
    deriving (Show)

instance ToResponse SwarmUnlockkeyResponse where
    toResponse (SwarmUnlockkeyResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmUnlockkeyResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmUnlockkeyResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" SwarmUnlockkeyResponse Network.HTTP.Types.Status where
    getField (SwarmUnlockkeyResponse200 {}) = Network.HTTP.Types.status200
    getField (SwarmUnlockkeyResponse500 {}) = Network.HTTP.Types.status500
    getField (SwarmUnlockkeyResponse503 {}) = Network.HTTP.Types.status503