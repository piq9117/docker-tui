{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SwarmInit where

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
import OpenAPI.Docker.Schemas.SwarmSpec

import OpenAPI.Docker.Response

data SwarmInitRequestBody = SwarmInitRequestBody
    {
        advertiseAddr :: (Data.Maybe.Maybe (Data.Text.Text)),
        dataPathAddr :: (Data.Maybe.Maybe (Data.Text.Text)),
        dataPathPort :: (Data.Maybe.Maybe (GHC.Int.Int)),
        defaultAddrPool :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        forceNewCluster :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        listenAddr :: (Data.Maybe.Maybe (Data.Text.Text)),
        spec :: (Data.Maybe.Maybe (SwarmSpec)),
        subnetSize :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmInitRequestBody where
    toJSON SwarmInitRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AdvertiseAddr" Data.Aeson..= advertiseAddr | Just advertiseAddr <- [advertiseAddr] ]
        ++ [ "DataPathAddr" Data.Aeson..= dataPathAddr | Just dataPathAddr <- [dataPathAddr] ]
        ++ [ "DataPathPort" Data.Aeson..= dataPathPort | Just dataPathPort <- [dataPathPort] ]
        ++ [ "DefaultAddrPool" Data.Aeson..= defaultAddrPool | Just defaultAddrPool <- [defaultAddrPool] ]
        ++ [ "ForceNewCluster" Data.Aeson..= forceNewCluster | Just forceNewCluster <- [forceNewCluster] ]
        ++ [ "ListenAddr" Data.Aeson..= listenAddr | Just listenAddr <- [listenAddr] ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ]
        ++ [ "SubnetSize" Data.Aeson..= subnetSize | Just subnetSize <- [subnetSize] ])

    toEncoding SwarmInitRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AdvertiseAddr" . Data.Aeson.toEncoding) advertiseAddr <>
          maybe mempty (Data.Aeson.Encoding.pair "DataPathAddr" . Data.Aeson.toEncoding) dataPathAddr <>
          maybe mempty (Data.Aeson.Encoding.pair "DataPathPort" . Data.Aeson.toEncoding) dataPathPort <>
          maybe mempty (Data.Aeson.Encoding.pair "DefaultAddrPool" . Data.Aeson.toEncoding) defaultAddrPool <>
          maybe mempty (Data.Aeson.Encoding.pair "ForceNewCluster" . Data.Aeson.toEncoding) forceNewCluster <>
          maybe mempty (Data.Aeson.Encoding.pair "ListenAddr" . Data.Aeson.toEncoding) listenAddr <>
          maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec <>
          maybe mempty (Data.Aeson.Encoding.pair "SubnetSize" . Data.Aeson.toEncoding) subnetSize
        )

instance Data.Aeson.FromJSON SwarmInitRequestBody where
    parseJSON = Data.Aeson.withObject "SwarmInitRequestBody" $ \o ->
        SwarmInitRequestBody
            <$> o Data.Aeson..:? "AdvertiseAddr"
            <*> o Data.Aeson..:? "DataPathAddr"
            <*> o Data.Aeson..:? "DataPathPort"
            <*> o Data.Aeson..:? "DefaultAddrPool"
            <*> o Data.Aeson..:? "ForceNewCluster"
            <*> o Data.Aeson..:? "ListenAddr"
            <*> o Data.Aeson..:? "Spec"
            <*> o Data.Aeson..:? "SubnetSize"

data SwarmInitResponse
    = SwarmInitResponse200 Data.Text.Text
    | SwarmInitResponse400 ErrorResponse
    | SwarmInitResponse500 ErrorResponse
    | SwarmInitResponse503 ErrorResponse
    deriving (Show)

instance ToResponse SwarmInitResponse where
    toResponse (SwarmInitResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmInitResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmInitResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmInitResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" SwarmInitResponse Network.HTTP.Types.Status where
    getField (SwarmInitResponse200 {}) = Network.HTTP.Types.status200
    getField (SwarmInitResponse400 {}) = Network.HTTP.Types.status400
    getField (SwarmInitResponse500 {}) = Network.HTTP.Types.status500
    getField (SwarmInitResponse503 {}) = Network.HTTP.Types.status503