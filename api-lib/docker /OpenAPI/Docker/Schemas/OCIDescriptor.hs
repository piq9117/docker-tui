{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.OCIDescriptor where

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





data OCIDescriptor = OCIDescriptor
    {
        digest :: (Data.Maybe.Maybe (Data.Text.Text)),
        mediaType :: (Data.Maybe.Maybe (Data.Text.Text)),
        size :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON OCIDescriptor where
    toJSON OCIDescriptor {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "digest" Data.Aeson..= digest | Just digest <- [digest] ]
        ++ [ "mediaType" Data.Aeson..= mediaType | Just mediaType <- [mediaType] ]
        ++ [ "size" Data.Aeson..= size | Just size <- [size] ])

    toEncoding OCIDescriptor {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "digest" . Data.Aeson.toEncoding) digest <>
          maybe mempty (Data.Aeson.Encoding.pair "mediaType" . Data.Aeson.toEncoding) mediaType <>
          maybe mempty (Data.Aeson.Encoding.pair "size" . Data.Aeson.toEncoding) size
        )

instance Data.Aeson.FromJSON OCIDescriptor where
    parseJSON = Data.Aeson.withObject "OCIDescriptor" $ \o ->
        OCIDescriptor
            <$> o Data.Aeson..:? "digest"
            <*> o Data.Aeson..:? "mediaType"
            <*> o Data.Aeson..:? "size"