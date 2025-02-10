{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ExecStart where

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

data ExecStartRequestBody = ExecStartRequestBody
    {
        consoleSize :: (Data.Maybe.Maybe ([ GHC.Int.Int ])),
        detach :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        tty :: (Data.Maybe.Maybe (GHC.Types.Bool))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ExecStartRequestBody where
    toJSON ExecStartRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ConsoleSize" Data.Aeson..= consoleSize | Just consoleSize <- [consoleSize] ]
        ++ [ "Detach" Data.Aeson..= detach | Just detach <- [detach] ]
        ++ [ "Tty" Data.Aeson..= tty | Just tty <- [tty] ])

    toEncoding ExecStartRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ConsoleSize" . Data.Aeson.toEncoding) consoleSize <>
          maybe mempty (Data.Aeson.Encoding.pair "Detach" . Data.Aeson.toEncoding) detach <>
          maybe mempty (Data.Aeson.Encoding.pair "Tty" . Data.Aeson.toEncoding) tty
        )

instance Data.Aeson.FromJSON ExecStartRequestBody where
    parseJSON = Data.Aeson.withObject "ExecStartRequestBody" $ \o ->
        ExecStartRequestBody
            <$> o Data.Aeson..:? "ConsoleSize"
            <*> o Data.Aeson..:? "Detach"
            <*> o Data.Aeson..:? "Tty"

data ExecStartResponse
    = ExecStartResponse200
    | ExecStartResponse404 Network.Wai.StreamingBody
    | ExecStartResponse409 Network.Wai.StreamingBody

instance ToResponse ExecStartResponse where
    toResponse (ExecStartResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (ExecStartResponse404 x) =
        Network.Wai.responseStream Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x
    toResponse (ExecStartResponse409 x) =
        Network.Wai.responseStream Network.HTTP.Types.status409 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.multiplexed-stream")]) x

instance GHC.Records.HasField "status" ExecStartResponse Network.HTTP.Types.Status where
    getField (ExecStartResponse200 {}) = Network.HTTP.Types.status200
    getField (ExecStartResponse404 {}) = Network.HTTP.Types.status404
    getField (ExecStartResponse409 {}) = Network.HTTP.Types.status409

instance Show ExecStartResponse where
    show _ = "ExecStartResponse {}"