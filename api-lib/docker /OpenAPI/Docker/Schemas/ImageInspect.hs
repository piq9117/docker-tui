{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ImageInspect where

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



import OpenAPI.Docker.Schemas.DriverData
import OpenAPI.Docker.Schemas.ImageConfig

newtype ImageInspectMetadata = ImageInspectMetadata
    {
        lastTagTime :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageInspectMetadata where
    toJSON ImageInspectMetadata {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "LastTagTime" Data.Aeson..= lastTagTime | Just lastTagTime <- [lastTagTime] ])

    toEncoding ImageInspectMetadata {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "LastTagTime" . Data.Aeson.toEncoding) lastTagTime
        )

instance Data.Aeson.FromJSON ImageInspectMetadata where
    parseJSON = Data.Aeson.withObject "ImageInspectMetadata" $ \o ->
        ImageInspectMetadata
            <$> o Data.Aeson..:? "LastTagTime"

data ImageInspectRootFS = ImageInspectRootFS
    {
        layers :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        type' :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageInspectRootFS where
    toJSON ImageInspectRootFS {..} = Data.Aeson.object
        ([ "Type" Data.Aeson..= type'
        ]
        ++ [ "Layers" Data.Aeson..= layers | Just layers <- [layers] ])

    toEncoding ImageInspectRootFS {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Layers" . Data.Aeson.toEncoding) layers <>
          Data.Aeson.Encoding.pair "Type" (Data.Aeson.toEncoding type')
        )

instance Data.Aeson.FromJSON ImageInspectRootFS where
    parseJSON = Data.Aeson.withObject "ImageInspectRootFS" $ \o ->
        ImageInspectRootFS
            <$> o Data.Aeson..:? "Layers"
            <*> o Data.Aeson..: "Type"

data ImageInspect = ImageInspect
    {
        architecture :: (Data.Maybe.Maybe (Data.Text.Text)),
        author :: (Data.Maybe.Maybe (Data.Text.Text)),
        comment :: (Data.Maybe.Maybe (Data.Text.Text)),
        config :: (Data.Maybe.Maybe (ImageConfig)),
        created :: (Data.Maybe.Maybe (Data.Text.Text)),
        dockerVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        graphDriver :: (Data.Maybe.Maybe (DriverData)),
        id :: (Data.Maybe.Maybe (Data.Text.Text)),
        metadata :: (Data.Maybe.Maybe (ImageInspectMetadata)),
        os :: (Data.Maybe.Maybe (Data.Text.Text)),
        osVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        parent :: (Data.Maybe.Maybe (Data.Text.Text)),
        repoDigests :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        repoTags :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        rootFS :: (Data.Maybe.Maybe (ImageInspectRootFS)),
        size :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        variant :: (Data.Maybe.Maybe (Data.Text.Text)),
        virtualSize :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageInspect where
    toJSON ImageInspect {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Architecture" Data.Aeson..= architecture | Just architecture <- [architecture] ]
        ++ [ "Author" Data.Aeson..= author | Just author <- [author] ]
        ++ [ "Comment" Data.Aeson..= comment | Just comment <- [comment] ]
        ++ [ "Config" Data.Aeson..= config | Just config <- [config] ]
        ++ [ "Created" Data.Aeson..= created | Just created <- [created] ]
        ++ [ "DockerVersion" Data.Aeson..= dockerVersion | Just dockerVersion <- [dockerVersion] ]
        ++ [ "GraphDriver" Data.Aeson..= graphDriver | Just graphDriver <- [graphDriver] ]
        ++ [ "Id" Data.Aeson..= id | Just id <- [id] ]
        ++ [ "Metadata" Data.Aeson..= metadata | Just metadata <- [metadata] ]
        ++ [ "Os" Data.Aeson..= os | Just os <- [os] ]
        ++ [ "OsVersion" Data.Aeson..= osVersion | Just osVersion <- [osVersion] ]
        ++ [ "Parent" Data.Aeson..= parent | Just parent <- [parent] ]
        ++ [ "RepoDigests" Data.Aeson..= repoDigests | Just repoDigests <- [repoDigests] ]
        ++ [ "RepoTags" Data.Aeson..= repoTags | Just repoTags <- [repoTags] ]
        ++ [ "RootFS" Data.Aeson..= rootFS | Just rootFS <- [rootFS] ]
        ++ [ "Size" Data.Aeson..= size | Just size <- [size] ]
        ++ [ "Variant" Data.Aeson..= variant | Just variant <- [variant] ]
        ++ [ "VirtualSize" Data.Aeson..= virtualSize | Just virtualSize <- [virtualSize] ])

    toEncoding ImageInspect {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Architecture" . Data.Aeson.toEncoding) architecture <>
          maybe mempty (Data.Aeson.Encoding.pair "Author" . Data.Aeson.toEncoding) author <>
          maybe mempty (Data.Aeson.Encoding.pair "Comment" . Data.Aeson.toEncoding) comment <>
          maybe mempty (Data.Aeson.Encoding.pair "Config" . Data.Aeson.toEncoding) config <>
          maybe mempty (Data.Aeson.Encoding.pair "Created" . Data.Aeson.toEncoding) created <>
          maybe mempty (Data.Aeson.Encoding.pair "DockerVersion" . Data.Aeson.toEncoding) dockerVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "GraphDriver" . Data.Aeson.toEncoding) graphDriver <>
          maybe mempty (Data.Aeson.Encoding.pair "Id" . Data.Aeson.toEncoding) id <>
          maybe mempty (Data.Aeson.Encoding.pair "Metadata" . Data.Aeson.toEncoding) metadata <>
          maybe mempty (Data.Aeson.Encoding.pair "Os" . Data.Aeson.toEncoding) os <>
          maybe mempty (Data.Aeson.Encoding.pair "OsVersion" . Data.Aeson.toEncoding) osVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "Parent" . Data.Aeson.toEncoding) parent <>
          maybe mempty (Data.Aeson.Encoding.pair "RepoDigests" . Data.Aeson.toEncoding) repoDigests <>
          maybe mempty (Data.Aeson.Encoding.pair "RepoTags" . Data.Aeson.toEncoding) repoTags <>
          maybe mempty (Data.Aeson.Encoding.pair "RootFS" . Data.Aeson.toEncoding) rootFS <>
          maybe mempty (Data.Aeson.Encoding.pair "Size" . Data.Aeson.toEncoding) size <>
          maybe mempty (Data.Aeson.Encoding.pair "Variant" . Data.Aeson.toEncoding) variant <>
          maybe mempty (Data.Aeson.Encoding.pair "VirtualSize" . Data.Aeson.toEncoding) virtualSize
        )

instance Data.Aeson.FromJSON ImageInspect where
    parseJSON = Data.Aeson.withObject "ImageInspect" $ \o ->
        ImageInspect
            <$> o Data.Aeson..:? "Architecture"
            <*> o Data.Aeson..:? "Author"
            <*> o Data.Aeson..:? "Comment"
            <*> o Data.Aeson..:? "Config"
            <*> o Data.Aeson..:? "Created"
            <*> o Data.Aeson..:? "DockerVersion"
            <*> o Data.Aeson..:? "GraphDriver"
            <*> o Data.Aeson..:? "Id"
            <*> o Data.Aeson..:? "Metadata"
            <*> o Data.Aeson..:? "Os"
            <*> o Data.Aeson..:? "OsVersion"
            <*> o Data.Aeson..:? "Parent"
            <*> o Data.Aeson..:? "RepoDigests"
            <*> o Data.Aeson..:? "RepoTags"
            <*> o Data.Aeson..:? "RootFS"
            <*> o Data.Aeson..:? "Size"
            <*> o Data.Aeson..:? "Variant"
            <*> o Data.Aeson..:? "VirtualSize"