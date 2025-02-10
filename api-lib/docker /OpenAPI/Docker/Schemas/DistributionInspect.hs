{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.DistributionInspect where

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



import OpenAPI.Docker.Schemas.OCIDescriptor
import OpenAPI.Docker.Schemas.OCIPlatform

data DistributionInspect = DistributionInspect
    {
        descriptor :: OCIDescriptor,
        platforms :: [ OCIPlatform ]
    }
    deriving (Show)

instance Data.Aeson.ToJSON DistributionInspect where
    toJSON DistributionInspect {..} = Data.Aeson.object
        ([ "Descriptor" Data.Aeson..= descriptor,
           "Platforms" Data.Aeson..= platforms
        ]
        )

    toEncoding DistributionInspect {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Descriptor" (Data.Aeson.toEncoding descriptor) <>
          Data.Aeson.Encoding.pair "Platforms" (Data.Aeson.toEncoding platforms)
        )

instance Data.Aeson.FromJSON DistributionInspect where
    parseJSON = Data.Aeson.withObject "DistributionInspect" $ \o ->
        DistributionInspect
            <$> o Data.Aeson..: "Descriptor"
            <*> o Data.Aeson..: "Platforms"