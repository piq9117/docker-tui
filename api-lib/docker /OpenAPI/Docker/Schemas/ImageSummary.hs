{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ImageSummary where

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



import OpenAPI.Docker.Schemas.ImageManifestSummary

newtype ImageSummaryLabels = ImageSummaryLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON ImageSummaryLabels where
    toJSON (ImageSummaryLabels x) =
        Data.Aeson.toJSON x

    toEncoding (ImageSummaryLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON ImageSummaryLabels where
    parseJSON x =
        ImageSummaryLabels <$> Data.Aeson.parseJSON x

data ImageSummary = ImageSummary
    {
        containers :: GHC.Int.Int,
        created :: GHC.Int.Int,
        id :: Data.Text.Text,
        labels :: ImageSummaryLabels,
        manifests :: (Data.Maybe.Maybe ([ ImageManifestSummary ])),
        parentId :: Data.Text.Text,
        repoDigests :: [ Data.Text.Text ],
        repoTags :: [ Data.Text.Text ],
        sharedSize :: GHC.Int.Int64,
        size :: GHC.Int.Int64,
        virtualSize :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageSummary where
    toJSON ImageSummary {..} = Data.Aeson.object
        ([ "Containers" Data.Aeson..= containers,
           "Created" Data.Aeson..= created,
           "Id" Data.Aeson..= id,
           "Labels" Data.Aeson..= labels,
           "ParentId" Data.Aeson..= parentId,
           "RepoDigests" Data.Aeson..= repoDigests,
           "RepoTags" Data.Aeson..= repoTags,
           "SharedSize" Data.Aeson..= sharedSize,
           "Size" Data.Aeson..= size
        ]
        ++ [ "Manifests" Data.Aeson..= manifests | Just manifests <- [manifests] ]
        ++ [ "VirtualSize" Data.Aeson..= virtualSize | Just virtualSize <- [virtualSize] ])

    toEncoding ImageSummary {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Containers" (Data.Aeson.toEncoding containers) <>
          Data.Aeson.Encoding.pair "Created" (Data.Aeson.toEncoding created) <>
          Data.Aeson.Encoding.pair "Id" (Data.Aeson.toEncoding id) <>
          Data.Aeson.Encoding.pair "Labels" (Data.Aeson.toEncoding labels) <>
          maybe mempty (Data.Aeson.Encoding.pair "Manifests" . Data.Aeson.toEncoding) manifests <>
          Data.Aeson.Encoding.pair "ParentId" (Data.Aeson.toEncoding parentId) <>
          Data.Aeson.Encoding.pair "RepoDigests" (Data.Aeson.toEncoding repoDigests) <>
          Data.Aeson.Encoding.pair "RepoTags" (Data.Aeson.toEncoding repoTags) <>
          Data.Aeson.Encoding.pair "SharedSize" (Data.Aeson.toEncoding sharedSize) <>
          Data.Aeson.Encoding.pair "Size" (Data.Aeson.toEncoding size) <>
          maybe mempty (Data.Aeson.Encoding.pair "VirtualSize" . Data.Aeson.toEncoding) virtualSize
        )

instance Data.Aeson.FromJSON ImageSummary where
    parseJSON = Data.Aeson.withObject "ImageSummary" $ \o ->
        ImageSummary
            <$> o Data.Aeson..: "Containers"
            <*> o Data.Aeson..: "Created"
            <*> o Data.Aeson..: "Id"
            <*> o Data.Aeson..: "Labels"
            <*> o Data.Aeson..:? "Manifests"
            <*> o Data.Aeson..: "ParentId"
            <*> o Data.Aeson..: "RepoDigests"
            <*> o Data.Aeson..: "RepoTags"
            <*> o Data.Aeson..: "SharedSize"
            <*> o Data.Aeson..: "Size"
            <*> o Data.Aeson..:? "VirtualSize"