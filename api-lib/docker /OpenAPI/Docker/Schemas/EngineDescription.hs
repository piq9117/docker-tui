{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.EngineDescription where

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





newtype EngineDescriptionLabels = EngineDescriptionLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON EngineDescriptionLabels where
    toJSON (EngineDescriptionLabels x) =
        Data.Aeson.toJSON x

    toEncoding (EngineDescriptionLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON EngineDescriptionLabels where
    parseJSON x =
        EngineDescriptionLabels <$> Data.Aeson.parseJSON x

data EngineDescriptionPlugins = EngineDescriptionPlugins
    {
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        type' :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON EngineDescriptionPlugins where
    toJSON EngineDescriptionPlugins {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Type" Data.Aeson..= type' | Just type' <- [type'] ])

    toEncoding EngineDescriptionPlugins {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Type" . Data.Aeson.toEncoding) type'
        )

instance Data.Aeson.FromJSON EngineDescriptionPlugins where
    parseJSON = Data.Aeson.withObject "EngineDescriptionPlugins" $ \o ->
        EngineDescriptionPlugins
            <$> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Type"

data EngineDescription = EngineDescription
    {
        engineVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        labels :: (Data.Maybe.Maybe (EngineDescriptionLabels)),
        plugins :: (Data.Maybe.Maybe ([ EngineDescriptionPlugins ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON EngineDescription where
    toJSON EngineDescription {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "EngineVersion" Data.Aeson..= engineVersion | Just engineVersion <- [engineVersion] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Plugins" Data.Aeson..= plugins | Just plugins <- [plugins] ])

    toEncoding EngineDescription {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "EngineVersion" . Data.Aeson.toEncoding) engineVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Plugins" . Data.Aeson.toEncoding) plugins
        )

instance Data.Aeson.FromJSON EngineDescription where
    parseJSON = Data.Aeson.withObject "EngineDescription" $ \o ->
        EngineDescription
            <$> o Data.Aeson..:? "EngineVersion"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Plugins"