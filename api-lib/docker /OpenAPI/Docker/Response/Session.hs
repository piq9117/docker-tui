{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.Session where

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

data SessionResponse
    = SessionResponse101
    | SessionResponse400 Network.Wai.StreamingBody
    | SessionResponse500 Network.Wai.StreamingBody

instance ToResponse SessionResponse where
    toResponse (SessionResponse101) =
        Network.Wai.responseBuilder Network.HTTP.Types.status101 ([]) mempty
    toResponse (SessionResponse400 x) =
        Network.Wai.responseStream Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.raw-stream")]) x
    toResponse (SessionResponse500 x) =
        Network.Wai.responseStream Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/vnd.docker.raw-stream")]) x

instance GHC.Records.HasField "status" SessionResponse Network.HTTP.Types.Status where
    getField (SessionResponse101 {}) = Network.HTTP.Types.status101
    getField (SessionResponse400 {}) = Network.HTTP.Types.status400
    getField (SessionResponse500 {}) = Network.HTTP.Types.status500

instance Show SessionResponse where
    show _ = "SessionResponse {}"