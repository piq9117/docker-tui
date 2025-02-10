{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SwarmJoin where

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

data SwarmJoinRequestBody = SwarmJoinRequestBody
    {
        advertiseAddr :: (Data.Maybe.Maybe (Data.Text.Text)),
        dataPathAddr :: (Data.Maybe.Maybe (Data.Text.Text)),
        joinToken :: (Data.Maybe.Maybe (Data.Text.Text)),
        listenAddr :: (Data.Maybe.Maybe (Data.Text.Text)),
        remoteAddrs :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmJoinRequestBody where
    toJSON SwarmJoinRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AdvertiseAddr" Data.Aeson..= advertiseAddr | Just advertiseAddr <- [advertiseAddr] ]
        ++ [ "DataPathAddr" Data.Aeson..= dataPathAddr | Just dataPathAddr <- [dataPathAddr] ]
        ++ [ "JoinToken" Data.Aeson..= joinToken | Just joinToken <- [joinToken] ]
        ++ [ "ListenAddr" Data.Aeson..= listenAddr | Just listenAddr <- [listenAddr] ]
        ++ [ "RemoteAddrs" Data.Aeson..= remoteAddrs | Just remoteAddrs <- [remoteAddrs] ])

    toEncoding SwarmJoinRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AdvertiseAddr" . Data.Aeson.toEncoding) advertiseAddr <>
          maybe mempty (Data.Aeson.Encoding.pair "DataPathAddr" . Data.Aeson.toEncoding) dataPathAddr <>
          maybe mempty (Data.Aeson.Encoding.pair "JoinToken" . Data.Aeson.toEncoding) joinToken <>
          maybe mempty (Data.Aeson.Encoding.pair "ListenAddr" . Data.Aeson.toEncoding) listenAddr <>
          maybe mempty (Data.Aeson.Encoding.pair "RemoteAddrs" . Data.Aeson.toEncoding) remoteAddrs
        )

instance Data.Aeson.FromJSON SwarmJoinRequestBody where
    parseJSON = Data.Aeson.withObject "SwarmJoinRequestBody" $ \o ->
        SwarmJoinRequestBody
            <$> o Data.Aeson..:? "AdvertiseAddr"
            <*> o Data.Aeson..:? "DataPathAddr"
            <*> o Data.Aeson..:? "JoinToken"
            <*> o Data.Aeson..:? "ListenAddr"
            <*> o Data.Aeson..:? "RemoteAddrs"

data SwarmJoinResponse
    = SwarmJoinResponse200
    | SwarmJoinResponse400 ErrorResponse
    | SwarmJoinResponse500 ErrorResponse
    | SwarmJoinResponse503 ErrorResponse
    deriving (Show)

instance ToResponse SwarmJoinResponse where
    toResponse (SwarmJoinResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (SwarmJoinResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmJoinResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmJoinResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" SwarmJoinResponse Network.HTTP.Types.Status where
    getField (SwarmJoinResponse200 {}) = Network.HTTP.Types.status200
    getField (SwarmJoinResponse400 {}) = Network.HTTP.Types.status400
    getField (SwarmJoinResponse500 {}) = Network.HTTP.Types.status500
    getField (SwarmJoinResponse503 {}) = Network.HTTP.Types.status503