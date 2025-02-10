{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Mount where

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





data MountBindOptions = MountBindOptions
    {
        createMountpoint :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        nonRecursive :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        propagation :: (Data.Maybe.Maybe (MountBindOptionsPropagation)),
        readOnlyForceRecursive :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        readOnlyNonRecursive :: (Data.Maybe.Maybe (GHC.Types.Bool))
    }
    deriving (Show)

instance Data.Aeson.ToJSON MountBindOptions where
    toJSON MountBindOptions {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CreateMountpoint" Data.Aeson..= createMountpoint | Just createMountpoint <- [createMountpoint] ]
        ++ [ "NonRecursive" Data.Aeson..= nonRecursive | Just nonRecursive <- [nonRecursive] ]
        ++ [ "Propagation" Data.Aeson..= propagation | Just propagation <- [propagation] ]
        ++ [ "ReadOnlyForceRecursive" Data.Aeson..= readOnlyForceRecursive | Just readOnlyForceRecursive <- [readOnlyForceRecursive] ]
        ++ [ "ReadOnlyNonRecursive" Data.Aeson..= readOnlyNonRecursive | Just readOnlyNonRecursive <- [readOnlyNonRecursive] ])

    toEncoding MountBindOptions {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CreateMountpoint" . Data.Aeson.toEncoding) createMountpoint <>
          maybe mempty (Data.Aeson.Encoding.pair "NonRecursive" . Data.Aeson.toEncoding) nonRecursive <>
          maybe mempty (Data.Aeson.Encoding.pair "Propagation" . Data.Aeson.toEncoding) propagation <>
          maybe mempty (Data.Aeson.Encoding.pair "ReadOnlyForceRecursive" . Data.Aeson.toEncoding) readOnlyForceRecursive <>
          maybe mempty (Data.Aeson.Encoding.pair "ReadOnlyNonRecursive" . Data.Aeson.toEncoding) readOnlyNonRecursive
        )

instance Data.Aeson.FromJSON MountBindOptions where
    parseJSON = Data.Aeson.withObject "MountBindOptions" $ \o ->
        MountBindOptions
            <$> o Data.Aeson..:? "CreateMountpoint"
            <*> o Data.Aeson..:? "NonRecursive"
            <*> o Data.Aeson..:? "Propagation"
            <*> o Data.Aeson..:? "ReadOnlyForceRecursive"
            <*> o Data.Aeson..:? "ReadOnlyNonRecursive"

data MountBindOptionsPropagation
    = MountBindOptionsPropagationPrivate
    | MountBindOptionsPropagationRprivate
    | MountBindOptionsPropagationShared
    | MountBindOptionsPropagationRshared
    | MountBindOptionsPropagationSlave
    | MountBindOptionsPropagationRslave
    deriving (Eq, Show)

instance Data.Aeson.ToJSON MountBindOptionsPropagation where
    toJSON x = case x of
        MountBindOptionsPropagationPrivate -> "private"
        MountBindOptionsPropagationRprivate -> "rprivate"
        MountBindOptionsPropagationShared -> "shared"
        MountBindOptionsPropagationRshared -> "rshared"
        MountBindOptionsPropagationSlave -> "slave"
        MountBindOptionsPropagationRslave -> "rslave"

    toEncoding x = case x of
        MountBindOptionsPropagationPrivate -> Data.Aeson.Encoding.text "private"
        MountBindOptionsPropagationRprivate -> Data.Aeson.Encoding.text "rprivate"
        MountBindOptionsPropagationShared -> Data.Aeson.Encoding.text "shared"
        MountBindOptionsPropagationRshared -> Data.Aeson.Encoding.text "rshared"
        MountBindOptionsPropagationSlave -> Data.Aeson.Encoding.text "slave"
        MountBindOptionsPropagationRslave -> Data.Aeson.Encoding.text "rslave"

instance Data.Aeson.FromJSON MountBindOptionsPropagation where
    parseJSON = Data.Aeson.withText "MountBindOptionsPropagation" $ \s ->
        case s of
            "private" -> pure MountBindOptionsPropagationPrivate
            "rprivate" -> pure MountBindOptionsPropagationRprivate
            "shared" -> pure MountBindOptionsPropagationShared
            "rshared" -> pure MountBindOptionsPropagationRshared
            "slave" -> pure MountBindOptionsPropagationSlave
            "rslave" -> pure MountBindOptionsPropagationRslave
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData MountBindOptionsPropagation where
    toQueryParam x = case x of
        MountBindOptionsPropagationPrivate -> "private"
        MountBindOptionsPropagationRprivate -> "rprivate"
        MountBindOptionsPropagationShared -> "shared"
        MountBindOptionsPropagationRshared -> "rshared"
        MountBindOptionsPropagationSlave -> "slave"
        MountBindOptionsPropagationRslave -> "rslave"

instance Web.HttpApiData.FromHttpApiData MountBindOptionsPropagation where
    parseUrlPiece x =
        case x of
            "private" -> pure MountBindOptionsPropagationPrivate
            "rprivate" -> pure MountBindOptionsPropagationRprivate
            "shared" -> pure MountBindOptionsPropagationShared
            "rshared" -> pure MountBindOptionsPropagationRshared
            "slave" -> pure MountBindOptionsPropagationSlave
            "rslave" -> pure MountBindOptionsPropagationRslave
            _ -> Left "invalid enum value"

data MountTmpfsOptions = MountTmpfsOptions
    {
        mode :: (Data.Maybe.Maybe (GHC.Int.Int)),
        options :: (Data.Maybe.Maybe ([ [ Data.Text.Text ] ])),
        sizeBytes :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON MountTmpfsOptions where
    toJSON MountTmpfsOptions {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Mode" Data.Aeson..= mode | Just mode <- [mode] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ]
        ++ [ "SizeBytes" Data.Aeson..= sizeBytes | Just sizeBytes <- [sizeBytes] ])

    toEncoding MountTmpfsOptions {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options <>
          maybe mempty (Data.Aeson.Encoding.pair "SizeBytes" . Data.Aeson.toEncoding) sizeBytes
        )

instance Data.Aeson.FromJSON MountTmpfsOptions where
    parseJSON = Data.Aeson.withObject "MountTmpfsOptions" $ \o ->
        MountTmpfsOptions
            <$> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Options"
            <*> o Data.Aeson..:? "SizeBytes"

data MountType
    = MountTypeBind
    | MountTypeVolume
    | MountTypeTmpfs
    | MountTypeNpipe
    | MountTypeCluster
    deriving (Eq, Show)

instance Data.Aeson.ToJSON MountType where
    toJSON x = case x of
        MountTypeBind -> "bind"
        MountTypeVolume -> "volume"
        MountTypeTmpfs -> "tmpfs"
        MountTypeNpipe -> "npipe"
        MountTypeCluster -> "cluster"

    toEncoding x = case x of
        MountTypeBind -> Data.Aeson.Encoding.text "bind"
        MountTypeVolume -> Data.Aeson.Encoding.text "volume"
        MountTypeTmpfs -> Data.Aeson.Encoding.text "tmpfs"
        MountTypeNpipe -> Data.Aeson.Encoding.text "npipe"
        MountTypeCluster -> Data.Aeson.Encoding.text "cluster"

instance Data.Aeson.FromJSON MountType where
    parseJSON = Data.Aeson.withText "MountType" $ \s ->
        case s of
            "bind" -> pure MountTypeBind
            "volume" -> pure MountTypeVolume
            "tmpfs" -> pure MountTypeTmpfs
            "npipe" -> pure MountTypeNpipe
            "cluster" -> pure MountTypeCluster
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData MountType where
    toQueryParam x = case x of
        MountTypeBind -> "bind"
        MountTypeVolume -> "volume"
        MountTypeTmpfs -> "tmpfs"
        MountTypeNpipe -> "npipe"
        MountTypeCluster -> "cluster"

instance Web.HttpApiData.FromHttpApiData MountType where
    parseUrlPiece x =
        case x of
            "bind" -> pure MountTypeBind
            "volume" -> pure MountTypeVolume
            "tmpfs" -> pure MountTypeTmpfs
            "npipe" -> pure MountTypeNpipe
            "cluster" -> pure MountTypeCluster
            _ -> Left "invalid enum value"

data MountVolumeOptions = MountVolumeOptions
    {
        driverConfig :: (Data.Maybe.Maybe (MountVolumeOptionsDriverConfig)),
        labels :: (Data.Maybe.Maybe (MountVolumeOptionsLabels)),
        noCopy :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        subpath :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON MountVolumeOptions where
    toJSON MountVolumeOptions {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "DriverConfig" Data.Aeson..= driverConfig | Just driverConfig <- [driverConfig] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "NoCopy" Data.Aeson..= noCopy | Just noCopy <- [noCopy] ]
        ++ [ "Subpath" Data.Aeson..= subpath | Just subpath <- [subpath] ])

    toEncoding MountVolumeOptions {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "DriverConfig" . Data.Aeson.toEncoding) driverConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "NoCopy" . Data.Aeson.toEncoding) noCopy <>
          maybe mempty (Data.Aeson.Encoding.pair "Subpath" . Data.Aeson.toEncoding) subpath
        )

instance Data.Aeson.FromJSON MountVolumeOptions where
    parseJSON = Data.Aeson.withObject "MountVolumeOptions" $ \o ->
        MountVolumeOptions
            <$> o Data.Aeson..:? "DriverConfig"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "NoCopy"
            <*> o Data.Aeson..:? "Subpath"

data MountVolumeOptionsDriverConfig = MountVolumeOptionsDriverConfig
    {
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        options :: (Data.Maybe.Maybe (MountVolumeOptionsDriverConfigOptions))
    }
    deriving (Show)

instance Data.Aeson.ToJSON MountVolumeOptionsDriverConfig where
    toJSON MountVolumeOptionsDriverConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ])

    toEncoding MountVolumeOptionsDriverConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options
        )

instance Data.Aeson.FromJSON MountVolumeOptionsDriverConfig where
    parseJSON = Data.Aeson.withObject "MountVolumeOptionsDriverConfig" $ \o ->
        MountVolumeOptionsDriverConfig
            <$> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Options"

newtype MountVolumeOptionsDriverConfigOptions = MountVolumeOptionsDriverConfigOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON MountVolumeOptionsDriverConfigOptions where
    toJSON (MountVolumeOptionsDriverConfigOptions x) =
        Data.Aeson.toJSON x

    toEncoding (MountVolumeOptionsDriverConfigOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON MountVolumeOptionsDriverConfigOptions where
    parseJSON x =
        MountVolumeOptionsDriverConfigOptions <$> Data.Aeson.parseJSON x

newtype MountVolumeOptionsLabels = MountVolumeOptionsLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON MountVolumeOptionsLabels where
    toJSON (MountVolumeOptionsLabels x) =
        Data.Aeson.toJSON x

    toEncoding (MountVolumeOptionsLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON MountVolumeOptionsLabels where
    parseJSON x =
        MountVolumeOptionsLabels <$> Data.Aeson.parseJSON x

data Mount = Mount
    {
        bindOptions :: (Data.Maybe.Maybe (MountBindOptions)),
        consistency :: (Data.Maybe.Maybe (Data.Text.Text)),
        readOnly :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        source :: (Data.Maybe.Maybe (Data.Text.Text)),
        target :: (Data.Maybe.Maybe (Data.Text.Text)),
        tmpfsOptions :: (Data.Maybe.Maybe (MountTmpfsOptions)),
        type' :: (Data.Maybe.Maybe (MountType)),
        volumeOptions :: (Data.Maybe.Maybe (MountVolumeOptions))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Mount where
    toJSON Mount {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "BindOptions" Data.Aeson..= bindOptions | Just bindOptions <- [bindOptions] ]
        ++ [ "Consistency" Data.Aeson..= consistency | Just consistency <- [consistency] ]
        ++ [ "ReadOnly" Data.Aeson..= readOnly | Just readOnly <- [readOnly] ]
        ++ [ "Source" Data.Aeson..= source | Just source <- [source] ]
        ++ [ "Target" Data.Aeson..= target | Just target <- [target] ]
        ++ [ "TmpfsOptions" Data.Aeson..= tmpfsOptions | Just tmpfsOptions <- [tmpfsOptions] ]
        ++ [ "Type" Data.Aeson..= type' | Just type' <- [type'] ]
        ++ [ "VolumeOptions" Data.Aeson..= volumeOptions | Just volumeOptions <- [volumeOptions] ])

    toEncoding Mount {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "BindOptions" . Data.Aeson.toEncoding) bindOptions <>
          maybe mempty (Data.Aeson.Encoding.pair "Consistency" . Data.Aeson.toEncoding) consistency <>
          maybe mempty (Data.Aeson.Encoding.pair "ReadOnly" . Data.Aeson.toEncoding) readOnly <>
          maybe mempty (Data.Aeson.Encoding.pair "Source" . Data.Aeson.toEncoding) source <>
          maybe mempty (Data.Aeson.Encoding.pair "Target" . Data.Aeson.toEncoding) target <>
          maybe mempty (Data.Aeson.Encoding.pair "TmpfsOptions" . Data.Aeson.toEncoding) tmpfsOptions <>
          maybe mempty (Data.Aeson.Encoding.pair "Type" . Data.Aeson.toEncoding) type' <>
          maybe mempty (Data.Aeson.Encoding.pair "VolumeOptions" . Data.Aeson.toEncoding) volumeOptions
        )

instance Data.Aeson.FromJSON Mount where
    parseJSON = Data.Aeson.withObject "Mount" $ \o ->
        Mount
            <$> o Data.Aeson..:? "BindOptions"
            <*> o Data.Aeson..:? "Consistency"
            <*> o Data.Aeson..:? "ReadOnly"
            <*> o Data.Aeson..:? "Source"
            <*> o Data.Aeson..:? "Target"
            <*> o Data.Aeson..:? "TmpfsOptions"
            <*> o Data.Aeson..:? "Type"
            <*> o Data.Aeson..:? "VolumeOptions"