{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.NetworkCreateResponse where

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





data NetworkCreateResponse = NetworkCreateResponse
    {
        id :: Data.Text.Text,
        warning :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON NetworkCreateResponse where
    toJSON NetworkCreateResponse {..} = Data.Aeson.object
        ([ "Id" Data.Aeson..= id,
           "Warning" Data.Aeson..= warning
        ]
        )

    toEncoding NetworkCreateResponse {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Id" (Data.Aeson.toEncoding id) <>
          Data.Aeson.Encoding.pair "Warning" (Data.Aeson.toEncoding warning)
        )

instance Data.Aeson.FromJSON NetworkCreateResponse where
    parseJSON = Data.Aeson.withObject "NetworkCreateResponse" $ \o ->
        NetworkCreateResponse
            <$> o Data.Aeson..: "Id"
            <*> o Data.Aeson..: "Warning"