{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ImageBuild where

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

data ImageBuildContentTypeParam
    = ImageBuildContentTypeParamApplication/xTar
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ImageBuildContentTypeParam where
    toJSON x = case x of
        ImageBuildContentTypeParamApplication/xTar -> "application/x-tar"

    toEncoding x = case x of
        ImageBuildContentTypeParamApplication/xTar -> Data.Aeson.Encoding.text "application/x-tar"

instance Data.Aeson.FromJSON ImageBuildContentTypeParam where
    parseJSON = Data.Aeson.withText "ImageBuildContentTypeParam" $ \s ->
        case s of
            "application/x-tar" -> pure ImageBuildContentTypeParamApplication/xTar
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ImageBuildContentTypeParam where
    toQueryParam x = case x of
        ImageBuildContentTypeParamApplication/xTar -> "application/x-tar"

instance Web.HttpApiData.FromHttpApiData ImageBuildContentTypeParam where
    parseUrlPiece x =
        case x of
            "application/x-tar" -> pure ImageBuildContentTypeParamApplication/xTar
            _ -> Left "invalid enum value"

data ImageBuildVersionParam
    = ImageBuildVersionParam1
    | ImageBuildVersionParam2
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ImageBuildVersionParam where
    toJSON x = case x of
        ImageBuildVersionParam1 -> "1"
        ImageBuildVersionParam2 -> "2"

    toEncoding x = case x of
        ImageBuildVersionParam1 -> Data.Aeson.Encoding.text "1"
        ImageBuildVersionParam2 -> Data.Aeson.Encoding.text "2"

instance Data.Aeson.FromJSON ImageBuildVersionParam where
    parseJSON = Data.Aeson.withText "ImageBuildVersionParam" $ \s ->
        case s of
            "1" -> pure ImageBuildVersionParam1
            "2" -> pure ImageBuildVersionParam2
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ImageBuildVersionParam where
    toQueryParam x = case x of
        ImageBuildVersionParam1 -> "1"
        ImageBuildVersionParam2 -> "2"

instance Web.HttpApiData.FromHttpApiData ImageBuildVersionParam where
    parseUrlPiece x =
        case x of
            "1" -> pure ImageBuildVersionParam1
            "2" -> pure ImageBuildVersionParam2
            _ -> Left "invalid enum value"

data ImageBuildResponse
    = ImageBuildResponse200
    | ImageBuildResponse400 ErrorResponse
    | ImageBuildResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ImageBuildResponse where
    toResponse (ImageBuildResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (ImageBuildResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ImageBuildResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ImageBuildResponse Network.HTTP.Types.Status where
    getField (ImageBuildResponse200 {}) = Network.HTTP.Types.status200
    getField (ImageBuildResponse400 {}) = Network.HTTP.Types.status400
    getField (ImageBuildResponse500 {}) = Network.HTTP.Types.status500