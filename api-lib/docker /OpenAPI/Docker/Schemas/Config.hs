{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Config where

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



import OpenAPI.Docker.Schemas.ConfigSpec
import OpenAPI.Docker.Schemas.ObjectVersion

data Config = Config
    {
        createdAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        spec :: (Data.Maybe.Maybe (ConfigSpec)),
        updatedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        version :: (Data.Maybe.Maybe (ObjectVersion))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Config where
    toJSON Config {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CreatedAt" Data.Aeson..= createdAt | Just createdAt <- [createdAt] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ]
        ++ [ "UpdatedAt" Data.Aeson..= updatedAt | Just updatedAt <- [updatedAt] ]
        ++ [ "Version" Data.Aeson..= version | Just version <- [version] ])

    toEncoding Config {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CreatedAt" . Data.Aeson.toEncoding) createdAt <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdatedAt" . Data.Aeson.toEncoding) updatedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Version" . Data.Aeson.toEncoding) version
        )

instance Data.Aeson.FromJSON Config where
    parseJSON = Data.Aeson.withObject "Config" $ \o ->
        Config
            <$> o Data.Aeson..:? "CreatedAt"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "Spec"
            <*> o Data.Aeson..:? "UpdatedAt"
            <*> o Data.Aeson..:? "Version"