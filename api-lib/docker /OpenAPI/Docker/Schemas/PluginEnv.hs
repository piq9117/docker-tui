{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.PluginEnv where

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





data PluginEnv = PluginEnv
    {
        description :: Data.Text.Text,
        name :: Data.Text.Text,
        settable :: [ Data.Text.Text ],
        value :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginEnv where
    toJSON PluginEnv {..} = Data.Aeson.object
        ([ "Description" Data.Aeson..= description,
           "Name" Data.Aeson..= name,
           "Settable" Data.Aeson..= settable,
           "Value" Data.Aeson..= value
        ]
        )

    toEncoding PluginEnv {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Description" (Data.Aeson.toEncoding description) <>
          Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name) <>
          Data.Aeson.Encoding.pair "Settable" (Data.Aeson.toEncoding settable) <>
          Data.Aeson.Encoding.pair "Value" (Data.Aeson.toEncoding value)
        )

instance Data.Aeson.FromJSON PluginEnv where
    parseJSON = Data.Aeson.withObject "PluginEnv" $ \o ->
        PluginEnv
            <$> o Data.Aeson..: "Description"
            <*> o Data.Aeson..: "Name"
            <*> o Data.Aeson..: "Settable"
            <*> o Data.Aeson..: "Value"