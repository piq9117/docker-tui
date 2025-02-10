{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.VolumeUpdate where

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

import OpenAPI.Docker.Schemas.ClusterVolumeSpec
import OpenAPI.Docker.Schemas.ErrorResponse

import OpenAPI.Docker.Response

newtype VolumeUpdateRequestBody = VolumeUpdateRequestBody
    {
        spec :: (Data.Maybe.Maybe (ClusterVolumeSpec))
    }
    deriving (Show)

instance Data.Aeson.ToJSON VolumeUpdateRequestBody where
    toJSON VolumeUpdateRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ])

    toEncoding VolumeUpdateRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec
        )

instance Data.Aeson.FromJSON VolumeUpdateRequestBody where
    parseJSON = Data.Aeson.withObject "VolumeUpdateRequestBody" $ \o ->
        VolumeUpdateRequestBody
            <$> o Data.Aeson..:? "Spec"

data VolumeUpdateResponse
    = VolumeUpdateResponse200
    | VolumeUpdateResponse400 ErrorResponse
    | VolumeUpdateResponse404 ErrorResponse
    | VolumeUpdateResponse500 ErrorResponse
    | VolumeUpdateResponse503 ErrorResponse
    deriving (Show)

instance ToResponse VolumeUpdateResponse where
    toResponse (VolumeUpdateResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (VolumeUpdateResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (VolumeUpdateResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (VolumeUpdateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (VolumeUpdateResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" VolumeUpdateResponse Network.HTTP.Types.Status where
    getField (VolumeUpdateResponse200 {}) = Network.HTTP.Types.status200
    getField (VolumeUpdateResponse400 {}) = Network.HTTP.Types.status400
    getField (VolumeUpdateResponse404 {}) = Network.HTTP.Types.status404
    getField (VolumeUpdateResponse500 {}) = Network.HTTP.Types.status500
    getField (VolumeUpdateResponse503 {}) = Network.HTTP.Types.status503