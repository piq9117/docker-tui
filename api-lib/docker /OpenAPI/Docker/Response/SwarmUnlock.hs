{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SwarmUnlock where

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

newtype SwarmUnlockRequestBody = SwarmUnlockRequestBody
    {
        unlockKey :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmUnlockRequestBody where
    toJSON SwarmUnlockRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "UnlockKey" Data.Aeson..= unlockKey | Just unlockKey <- [unlockKey] ])

    toEncoding SwarmUnlockRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "UnlockKey" . Data.Aeson.toEncoding) unlockKey
        )

instance Data.Aeson.FromJSON SwarmUnlockRequestBody where
    parseJSON = Data.Aeson.withObject "SwarmUnlockRequestBody" $ \o ->
        SwarmUnlockRequestBody
            <$> o Data.Aeson..:? "UnlockKey"

data SwarmUnlockResponse
    = SwarmUnlockResponse200
    | SwarmUnlockResponse500 ErrorResponse
    | SwarmUnlockResponse503 ErrorResponse
    deriving (Show)

instance ToResponse SwarmUnlockResponse where
    toResponse (SwarmUnlockResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (SwarmUnlockResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmUnlockResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" SwarmUnlockResponse Network.HTTP.Types.Status where
    getField (SwarmUnlockResponse200 {}) = Network.HTTP.Types.status200
    getField (SwarmUnlockResponse500 {}) = Network.HTTP.Types.status500
    getField (SwarmUnlockResponse503 {}) = Network.HTTP.Types.status503