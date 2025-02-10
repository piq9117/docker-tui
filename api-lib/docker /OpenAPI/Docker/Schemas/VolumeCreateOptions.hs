{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.VolumeCreateOptions where

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



import OpenAPI.Docker.Schemas.ClusterVolumeSpec

newtype VolumeCreateOptionsDriverOpts = VolumeCreateOptionsDriverOpts
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON VolumeCreateOptionsDriverOpts where
    toJSON (VolumeCreateOptionsDriverOpts x) =
        Data.Aeson.toJSON x

    toEncoding (VolumeCreateOptionsDriverOpts x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON VolumeCreateOptionsDriverOpts where
    parseJSON x =
        VolumeCreateOptionsDriverOpts <$> Data.Aeson.parseJSON x

newtype VolumeCreateOptionsLabels = VolumeCreateOptionsLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON VolumeCreateOptionsLabels where
    toJSON (VolumeCreateOptionsLabels x) =
        Data.Aeson.toJSON x

    toEncoding (VolumeCreateOptionsLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON VolumeCreateOptionsLabels where
    parseJSON x =
        VolumeCreateOptionsLabels <$> Data.Aeson.parseJSON x

data VolumeCreateOptions = VolumeCreateOptions
    {
        clusterVolumeSpec :: (Data.Maybe.Maybe (ClusterVolumeSpec)),
        driver :: (Data.Maybe.Maybe (Data.Text.Text)),
        driverOpts :: (Data.Maybe.Maybe (VolumeCreateOptionsDriverOpts)),
        labels :: (Data.Maybe.Maybe (VolumeCreateOptionsLabels)),
        name :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON VolumeCreateOptions where
    toJSON VolumeCreateOptions {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ClusterVolumeSpec" Data.Aeson..= clusterVolumeSpec | Just clusterVolumeSpec <- [clusterVolumeSpec] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "DriverOpts" Data.Aeson..= driverOpts | Just driverOpts <- [driverOpts] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ])

    toEncoding VolumeCreateOptions {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ClusterVolumeSpec" . Data.Aeson.toEncoding) clusterVolumeSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "DriverOpts" . Data.Aeson.toEncoding) driverOpts <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name
        )

instance Data.Aeson.FromJSON VolumeCreateOptions where
    parseJSON = Data.Aeson.withObject "VolumeCreateOptions" $ \o ->
        VolumeCreateOptions
            <$> o Data.Aeson..:? "ClusterVolumeSpec"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "DriverOpts"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Name"