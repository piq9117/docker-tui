{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.SwarmUpdate where

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

data SwarmUpdateResponse
    = SwarmUpdateResponse200
    | SwarmUpdateResponse400 ErrorResponse
    | SwarmUpdateResponse500 ErrorResponse
    | SwarmUpdateResponse503 ErrorResponse
    deriving (Show)

instance ToResponse SwarmUpdateResponse where
    toResponse (SwarmUpdateResponse200) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([]) mempty
    toResponse (SwarmUpdateResponse400 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status400 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmUpdateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (SwarmUpdateResponse503 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status503 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" SwarmUpdateResponse Network.HTTP.Types.Status where
    getField (SwarmUpdateResponse200 {}) = Network.HTTP.Types.status200
    getField (SwarmUpdateResponse400 {}) = Network.HTTP.Types.status400
    getField (SwarmUpdateResponse500 {}) = Network.HTTP.Types.status500
    getField (SwarmUpdateResponse503 {}) = Network.HTTP.Types.status503