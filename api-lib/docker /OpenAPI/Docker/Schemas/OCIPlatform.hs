{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.OCIPlatform where

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





data OCIPlatform = OCIPlatform
    {
        architecture :: (Data.Maybe.Maybe (Data.Text.Text)),
        os :: (Data.Maybe.Maybe (Data.Text.Text)),
        os.features :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        os.version :: (Data.Maybe.Maybe (Data.Text.Text)),
        variant :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON OCIPlatform where
    toJSON OCIPlatform {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "architecture" Data.Aeson..= architecture | Just architecture <- [architecture] ]
        ++ [ "os" Data.Aeson..= os | Just os <- [os] ]
        ++ [ "os.features" Data.Aeson..= os.features | Just os.features <- [os.features] ]
        ++ [ "os.version" Data.Aeson..= os.version | Just os.version <- [os.version] ]
        ++ [ "variant" Data.Aeson..= variant | Just variant <- [variant] ])

    toEncoding OCIPlatform {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "architecture" . Data.Aeson.toEncoding) architecture <>
          maybe mempty (Data.Aeson.Encoding.pair "os" . Data.Aeson.toEncoding) os <>
          maybe mempty (Data.Aeson.Encoding.pair "os.features" . Data.Aeson.toEncoding) os.features <>
          maybe mempty (Data.Aeson.Encoding.pair "os.version" . Data.Aeson.toEncoding) os.version <>
          maybe mempty (Data.Aeson.Encoding.pair "variant" . Data.Aeson.toEncoding) variant
        )

instance Data.Aeson.FromJSON OCIPlatform where
    parseJSON = Data.Aeson.withObject "OCIPlatform" $ \o ->
        OCIPlatform
            <$> o Data.Aeson..:? "architecture"
            <*> o Data.Aeson..:? "os"
            <*> o Data.Aeson..:? "os.features"
            <*> o Data.Aeson..:? "os.version"
            <*> o Data.Aeson..:? "variant"