{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.GenericResources where

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





data GenericResourcesElem = GenericResourcesElem
    {
        discreteResourceSpec :: (Data.Maybe.Maybe (GenericResourcesElemDiscreteResourceSpec)),
        namedResourceSpec :: (Data.Maybe.Maybe (GenericResourcesElemNamedResourceSpec))
    }
    deriving (Show)

instance Data.Aeson.ToJSON GenericResourcesElem where
    toJSON GenericResourcesElem {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "DiscreteResourceSpec" Data.Aeson..= discreteResourceSpec | Just discreteResourceSpec <- [discreteResourceSpec] ]
        ++ [ "NamedResourceSpec" Data.Aeson..= namedResourceSpec | Just namedResourceSpec <- [namedResourceSpec] ])

    toEncoding GenericResourcesElem {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "DiscreteResourceSpec" . Data.Aeson.toEncoding) discreteResourceSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "NamedResourceSpec" . Data.Aeson.toEncoding) namedResourceSpec
        )

instance Data.Aeson.FromJSON GenericResourcesElem where
    parseJSON = Data.Aeson.withObject "GenericResourcesElem" $ \o ->
        GenericResourcesElem
            <$> o Data.Aeson..:? "DiscreteResourceSpec"
            <*> o Data.Aeson..:? "NamedResourceSpec"

data GenericResourcesElemDiscreteResourceSpec = GenericResourcesElemDiscreteResourceSpec
    {
        kind :: (Data.Maybe.Maybe (Data.Text.Text)),
        value :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON GenericResourcesElemDiscreteResourceSpec where
    toJSON GenericResourcesElemDiscreteResourceSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Kind" Data.Aeson..= kind | Just kind <- [kind] ]
        ++ [ "Value" Data.Aeson..= value | Just value <- [value] ])

    toEncoding GenericResourcesElemDiscreteResourceSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Kind" . Data.Aeson.toEncoding) kind <>
          maybe mempty (Data.Aeson.Encoding.pair "Value" . Data.Aeson.toEncoding) value
        )

instance Data.Aeson.FromJSON GenericResourcesElemDiscreteResourceSpec where
    parseJSON = Data.Aeson.withObject "GenericResourcesElemDiscreteResourceSpec" $ \o ->
        GenericResourcesElemDiscreteResourceSpec
            <$> o Data.Aeson..:? "Kind"
            <*> o Data.Aeson..:? "Value"

data GenericResourcesElemNamedResourceSpec = GenericResourcesElemNamedResourceSpec
    {
        kind :: (Data.Maybe.Maybe (Data.Text.Text)),
        value :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON GenericResourcesElemNamedResourceSpec where
    toJSON GenericResourcesElemNamedResourceSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Kind" Data.Aeson..= kind | Just kind <- [kind] ]
        ++ [ "Value" Data.Aeson..= value | Just value <- [value] ])

    toEncoding GenericResourcesElemNamedResourceSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Kind" . Data.Aeson.toEncoding) kind <>
          maybe mempty (Data.Aeson.Encoding.pair "Value" . Data.Aeson.toEncoding) value
        )

instance Data.Aeson.FromJSON GenericResourcesElemNamedResourceSpec where
    parseJSON = Data.Aeson.withObject "GenericResourcesElemNamedResourceSpec" $ \o ->
        GenericResourcesElemNamedResourceSpec
            <$> o Data.Aeson..:? "Kind"
            <*> o Data.Aeson..:? "Value"

type GenericResources = [ GenericResourcesElem ]