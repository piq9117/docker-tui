{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ContainerCreateResponse where

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





data ContainerCreateResponse = ContainerCreateResponse
    {
        id :: Data.Text.Text,
        warnings :: [ Data.Text.Text ]
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerCreateResponse where
    toJSON ContainerCreateResponse {..} = Data.Aeson.object
        ([ "Id" Data.Aeson..= id,
           "Warnings" Data.Aeson..= warnings
        ]
        )

    toEncoding ContainerCreateResponse {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Id" (Data.Aeson.toEncoding id) <>
          Data.Aeson.Encoding.pair "Warnings" (Data.Aeson.toEncoding warnings)
        )

instance Data.Aeson.FromJSON ContainerCreateResponse where
    parseJSON = Data.Aeson.withObject "ContainerCreateResponse" $ \o ->
        ContainerCreateResponse
            <$> o Data.Aeson..: "Id"
            <*> o Data.Aeson..: "Warnings"