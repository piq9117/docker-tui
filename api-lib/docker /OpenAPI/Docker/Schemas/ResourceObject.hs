{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ResourceObject where

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



import OpenAPI.Docker.Schemas.GenericResources

data ResourceObject = ResourceObject
    {
        genericResources :: (Data.Maybe.Maybe (GenericResources)),
        memoryBytes :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        nanoCPUs :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ResourceObject where
    toJSON ResourceObject {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "GenericResources" Data.Aeson..= genericResources | Just genericResources <- [genericResources] ]
        ++ [ "MemoryBytes" Data.Aeson..= memoryBytes | Just memoryBytes <- [memoryBytes] ]
        ++ [ "NanoCPUs" Data.Aeson..= nanoCPUs | Just nanoCPUs <- [nanoCPUs] ])

    toEncoding ResourceObject {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "GenericResources" . Data.Aeson.toEncoding) genericResources <>
          maybe mempty (Data.Aeson.Encoding.pair "MemoryBytes" . Data.Aeson.toEncoding) memoryBytes <>
          maybe mempty (Data.Aeson.Encoding.pair "NanoCPUs" . Data.Aeson.toEncoding) nanoCPUs
        )

instance Data.Aeson.FromJSON ResourceObject where
    parseJSON = Data.Aeson.withObject "ResourceObject" $ \o ->
        ResourceObject
            <$> o Data.Aeson..:? "GenericResources"
            <*> o Data.Aeson..:? "MemoryBytes"
            <*> o Data.Aeson..:? "NanoCPUs"