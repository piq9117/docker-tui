{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.PluginMount where

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





data PluginMount = PluginMount
    {
        description :: Data.Text.Text,
        destination :: Data.Text.Text,
        name :: Data.Text.Text,
        options :: [ Data.Text.Text ],
        settable :: [ Data.Text.Text ],
        source :: Data.Text.Text,
        type' :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginMount where
    toJSON PluginMount {..} = Data.Aeson.object
        ([ "Description" Data.Aeson..= description,
           "Destination" Data.Aeson..= destination,
           "Name" Data.Aeson..= name,
           "Options" Data.Aeson..= options,
           "Settable" Data.Aeson..= settable,
           "Source" Data.Aeson..= source,
           "Type" Data.Aeson..= type'
        ]
        )

    toEncoding PluginMount {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Description" (Data.Aeson.toEncoding description) <>
          Data.Aeson.Encoding.pair "Destination" (Data.Aeson.toEncoding destination) <>
          Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name) <>
          Data.Aeson.Encoding.pair "Options" (Data.Aeson.toEncoding options) <>
          Data.Aeson.Encoding.pair "Settable" (Data.Aeson.toEncoding settable) <>
          Data.Aeson.Encoding.pair "Source" (Data.Aeson.toEncoding source) <>
          Data.Aeson.Encoding.pair "Type" (Data.Aeson.toEncoding type')
        )

instance Data.Aeson.FromJSON PluginMount where
    parseJSON = Data.Aeson.withObject "PluginMount" $ \o ->
        PluginMount
            <$> o Data.Aeson..: "Description"
            <*> o Data.Aeson..: "Destination"
            <*> o Data.Aeson..: "Name"
            <*> o Data.Aeson..: "Options"
            <*> o Data.Aeson..: "Settable"
            <*> o Data.Aeson..: "Source"
            <*> o Data.Aeson..: "Type"