{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SystemAuth where

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

import OpenAPI.Docker.Schemas.AuthConfig
import OpenAPI.Docker.Schemas.ErrorResponse

import OpenAPI.Docker.Response

data SystemAuthResponseBody200 = SystemAuthResponseBody200
    {
        identityToken :: (Data.Maybe.Maybe (Data.Text.Text)),
        status :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemAuthResponseBody200 where
    toJSON SystemAuthResponseBody200 {..} = Data.Aeson.object
        ([ "Status" Data.Aeson..= status
        ]
        ++ [ "IdentityToken" Data.Aeson..= identityToken | Just identityToken <- [identityToken] ])

    toEncoding SystemAuthResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "IdentityToken" . Data.Aeson.toEncoding) identityToken <>
          Data.Aeson.Encoding.pair "Status" (Data.Aeson.toEncoding status)
        )

instance Data.Aeson.FromJSON SystemAuthResponseBody200 where
    parseJSON = Data.Aeson.withObject "SystemAuthResponseBody200" $ \o ->
        SystemAuthResponseBody200
            <$> o Data.Aeson..:? "IdentityToken"
            <*> o Data.Aeson..: "Status"

data SystemAuthResponse
    = SystemAuthResponse200 SystemAuthResponseBody200
    | SystemAuthResponse204
    | SystemAuthResponse401 ErrorResponse
    | SystemAuthResponse500 ErrorResponse
    deriving (Show)

instance ToResponse SystemAuthResponse where
    toResponse (SystemAuthResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SystemAuthResponse204) =
        Network.Wai.responseBuilder Network.HTTP.Types.status204 ([]) mempty
    toResponse (SystemAuthResponse401 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status401 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SystemAuthResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" SystemAuthResponse Network.HTTP.Types.Status where
    getField (SystemAuthResponse200 {}) = Network.HTTP.Types.status200
    getField (SystemAuthResponse204 {}) = Network.HTTP.Types.status204
    getField (SystemAuthResponse401 {}) = Network.HTTP.Types.status401
    getField (SystemAuthResponse500 {}) = Network.HTTP.Types.status500