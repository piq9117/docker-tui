{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ErrorResponse where

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





newtype ErrorResponse = ErrorResponse
    {
        message :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON ErrorResponse where
    toJSON ErrorResponse {..} = Data.Aeson.object
        ([ "message" Data.Aeson..= message
        ]
        )

    toEncoding ErrorResponse {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "message" (Data.Aeson.toEncoding message)
        )

instance Data.Aeson.FromJSON ErrorResponse where
    parseJSON = Data.Aeson.withObject "ErrorResponse" $ \o ->
        ErrorResponse
            <$> o Data.Aeson..: "message"