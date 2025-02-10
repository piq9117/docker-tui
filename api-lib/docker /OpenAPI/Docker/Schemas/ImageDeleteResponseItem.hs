{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ImageDeleteResponseItem where

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





data ImageDeleteResponseItem = ImageDeleteResponseItem
    {
        deleted :: (Data.Maybe.Maybe (Data.Text.Text)),
        untagged :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageDeleteResponseItem where
    toJSON ImageDeleteResponseItem {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Deleted" Data.Aeson..= deleted | Just deleted <- [deleted] ]
        ++ [ "Untagged" Data.Aeson..= untagged | Just untagged <- [untagged] ])

    toEncoding ImageDeleteResponseItem {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Deleted" . Data.Aeson.toEncoding) deleted <>
          maybe mempty (Data.Aeson.Encoding.pair "Untagged" . Data.Aeson.toEncoding) untagged
        )

instance Data.Aeson.FromJSON ImageDeleteResponseItem where
    parseJSON = Data.Aeson.withObject "ImageDeleteResponseItem" $ \o ->
        ImageDeleteResponseItem
            <$> o Data.Aeson..:? "Deleted"
            <*> o Data.Aeson..:? "Untagged"