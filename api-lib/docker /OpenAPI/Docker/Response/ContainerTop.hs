{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerTop where

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

data ContainerTopResponseBody200 = ContainerTopResponseBody200
    {
        processes :: (Data.Maybe.Maybe ([ [ Data.Text.Text ] ])),
        titles :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerTopResponseBody200 where
    toJSON ContainerTopResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Processes" Data.Aeson..= processes | Just processes <- [processes] ]
        ++ [ "Titles" Data.Aeson..= titles | Just titles <- [titles] ])

    toEncoding ContainerTopResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Processes" . Data.Aeson.toEncoding) processes <>
          maybe mempty (Data.Aeson.Encoding.pair "Titles" . Data.Aeson.toEncoding) titles
        )

instance Data.Aeson.FromJSON ContainerTopResponseBody200 where
    parseJSON = Data.Aeson.withObject "ContainerTopResponseBody200" $ \o ->
        ContainerTopResponseBody200
            <$> o Data.Aeson..:? "Processes"
            <*> o Data.Aeson..:? "Titles"

data ContainerTopResponseBody200 = ContainerTopResponseBody200
    {
        processes :: (Data.Maybe.Maybe ([ [ Data.Text.Text ] ])),
        titles :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerTopResponseBody200 where
    toJSON ContainerTopResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Processes" Data.Aeson..= processes | Just processes <- [processes] ]
        ++ [ "Titles" Data.Aeson..= titles | Just titles <- [titles] ])

    toEncoding ContainerTopResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Processes" . Data.Aeson.toEncoding) processes <>
          maybe mempty (Data.Aeson.Encoding.pair "Titles" . Data.Aeson.toEncoding) titles
        )

instance Data.Aeson.FromJSON ContainerTopResponseBody200 where
    parseJSON = Data.Aeson.withObject "ContainerTopResponseBody200" $ \o ->
        ContainerTopResponseBody200
            <$> o Data.Aeson..:? "Processes"
            <*> o Data.Aeson..:? "Titles"

data ContainerTopResponse
    = ContainerTopResponse200 ContainerTopResponseBody200
    | ContainerTopResponse404 ErrorResponse
    | ContainerTopResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerTopResponse where
    toResponse (ContainerTopResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerTopResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerTopResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerTopResponse Network.HTTP.Types.Status where
    getField (ContainerTopResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerTopResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerTopResponse500 {}) = Network.HTTP.Types.status500