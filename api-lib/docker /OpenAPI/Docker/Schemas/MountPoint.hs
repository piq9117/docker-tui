{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.MountPoint where

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





data MountPointType
    = MountPointTypeBind
    | MountPointTypeVolume
    | MountPointTypeTmpfs
    | MountPointTypeNpipe
    | MountPointTypeCluster
    deriving (Eq, Show)

instance Data.Aeson.ToJSON MountPointType where
    toJSON x = case x of
        MountPointTypeBind -> "bind"
        MountPointTypeVolume -> "volume"
        MountPointTypeTmpfs -> "tmpfs"
        MountPointTypeNpipe -> "npipe"
        MountPointTypeCluster -> "cluster"

    toEncoding x = case x of
        MountPointTypeBind -> Data.Aeson.Encoding.text "bind"
        MountPointTypeVolume -> Data.Aeson.Encoding.text "volume"
        MountPointTypeTmpfs -> Data.Aeson.Encoding.text "tmpfs"
        MountPointTypeNpipe -> Data.Aeson.Encoding.text "npipe"
        MountPointTypeCluster -> Data.Aeson.Encoding.text "cluster"

instance Data.Aeson.FromJSON MountPointType where
    parseJSON = Data.Aeson.withText "MountPointType" $ \s ->
        case s of
            "bind" -> pure MountPointTypeBind
            "volume" -> pure MountPointTypeVolume
            "tmpfs" -> pure MountPointTypeTmpfs
            "npipe" -> pure MountPointTypeNpipe
            "cluster" -> pure MountPointTypeCluster
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData MountPointType where
    toQueryParam x = case x of
        MountPointTypeBind -> "bind"
        MountPointTypeVolume -> "volume"
        MountPointTypeTmpfs -> "tmpfs"
        MountPointTypeNpipe -> "npipe"
        MountPointTypeCluster -> "cluster"

instance Web.HttpApiData.FromHttpApiData MountPointType where
    parseUrlPiece x =
        case x of
            "bind" -> pure MountPointTypeBind
            "volume" -> pure MountPointTypeVolume
            "tmpfs" -> pure MountPointTypeTmpfs
            "npipe" -> pure MountPointTypeNpipe
            "cluster" -> pure MountPointTypeCluster
            _ -> Left "invalid enum value"

data MountPoint = MountPoint
    {
        destination :: (Data.Maybe.Maybe (Data.Text.Text)),
        driver :: (Data.Maybe.Maybe (Data.Text.Text)),
        mode :: (Data.Maybe.Maybe (Data.Text.Text)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        propagation :: (Data.Maybe.Maybe (Data.Text.Text)),
        rW :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        source :: (Data.Maybe.Maybe (Data.Text.Text)),
        type' :: (Data.Maybe.Maybe (MountPointType))
    }
    deriving (Show)

instance Data.Aeson.ToJSON MountPoint where
    toJSON MountPoint {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Destination" Data.Aeson..= destination | Just destination <- [destination] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "Mode" Data.Aeson..= mode | Just mode <- [mode] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Propagation" Data.Aeson..= propagation | Just propagation <- [propagation] ]
        ++ [ "RW" Data.Aeson..= rW | Just rW <- [rW] ]
        ++ [ "Source" Data.Aeson..= source | Just source <- [source] ]
        ++ [ "Type" Data.Aeson..= type' | Just type' <- [type'] ])

    toEncoding MountPoint {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Destination" . Data.Aeson.toEncoding) destination <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Propagation" . Data.Aeson.toEncoding) propagation <>
          maybe mempty (Data.Aeson.Encoding.pair "RW" . Data.Aeson.toEncoding) rW <>
          maybe mempty (Data.Aeson.Encoding.pair "Source" . Data.Aeson.toEncoding) source <>
          maybe mempty (Data.Aeson.Encoding.pair "Type" . Data.Aeson.toEncoding) type'
        )

instance Data.Aeson.FromJSON MountPoint where
    parseJSON = Data.Aeson.withObject "MountPoint" $ \o ->
        MountPoint
            <$> o Data.Aeson..:? "Destination"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Propagation"
            <*> o Data.Aeson..:? "RW"
            <*> o Data.Aeson..:? "Source"
            <*> o Data.Aeson..:? "Type"