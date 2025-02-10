{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.NetworkPrune where

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

newtype NetworkPruneResponseBody200 = NetworkPruneResponseBody200
    {
        networksDeleted :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NetworkPruneResponseBody200 where
    toJSON NetworkPruneResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "NetworksDeleted" Data.Aeson..= networksDeleted | Just networksDeleted <- [networksDeleted] ])

    toEncoding NetworkPruneResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "NetworksDeleted" . Data.Aeson.toEncoding) networksDeleted
        )

instance Data.Aeson.FromJSON NetworkPruneResponseBody200 where
    parseJSON = Data.Aeson.withObject "NetworkPruneResponseBody200" $ \o ->
        NetworkPruneResponseBody200
            <$> o Data.Aeson..:? "NetworksDeleted"

data NetworkPruneResponse
    = NetworkPruneResponse200 NetworkPruneResponseBody200
    | NetworkPruneResponse500 ErrorResponse
    deriving (Show)

instance ToResponse NetworkPruneResponse where
    toResponse (NetworkPruneResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (NetworkPruneResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" NetworkPruneResponse Network.HTTP.Types.Status where
    getField (NetworkPruneResponse200 {}) = Network.HTTP.Types.status200
    getField (NetworkPruneResponse500 {}) = Network.HTTP.Types.status500