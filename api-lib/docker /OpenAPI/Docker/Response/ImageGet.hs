{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ImageGet where

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

data ImageGetResponse
    = ImageGetResponse200 Network.Wai.StreamingBody
    | ImageGetResponse500 Network.Wai.StreamingBody

instance ToResponse ImageGetResponse where
    toResponse (ImageGetResponse200 x) =
        Network.Wai.responseStream Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/x-tar")]) x
    toResponse (ImageGetResponse500 x) =
        Network.Wai.responseStream Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/x-tar")]) x

instance GHC.Records.HasField "status" ImageGetResponse Network.HTTP.Types.Status where
    getField (ImageGetResponse200 {}) = Network.HTTP.Types.status200
    getField (ImageGetResponse500 {}) = Network.HTTP.Types.status500

instance Show ImageGetResponse where
    show _ = "ImageGetResponse {}"