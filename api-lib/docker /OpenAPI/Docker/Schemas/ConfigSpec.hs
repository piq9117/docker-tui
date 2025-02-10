{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ConfigSpec where

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



import OpenAPI.Docker.Schemas.Driver

newtype ConfigSpecLabels = ConfigSpecLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ConfigSpecLabels where
    toJSON (ConfigSpecLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ConfigSpecLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ConfigSpecLabels where
    parseJSON x =
        ConfigSpecLabels <$> Data.Aeson.parseJSON x

data ConfigSpec = ConfigSpec
    {
        data' :: (Data.Maybe.Maybe (Data.Text.Text)),
        labels :: (Data.Maybe.Maybe (ConfigSpecLabels)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        templating :: (Data.Maybe.Maybe (Driver))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ConfigSpec where
    toJSON ConfigSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Data" Data.Aeson..= data' | Just data' <- [data'] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Templating" Data.Aeson..= templating | Just templating <- [templating] ])

    toEncoding ConfigSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Data" . Data.Aeson.toEncoding) data' <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Templating" . Data.Aeson.toEncoding) templating
        )

instance Data.Aeson.FromJSON ConfigSpec where
    parseJSON = Data.Aeson.withObject "ConfigSpec" $ \o ->
        ConfigSpec
            <$> o Data.Aeson..:? "Data"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Templating"