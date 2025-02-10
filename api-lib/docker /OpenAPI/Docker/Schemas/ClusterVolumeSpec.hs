{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ClusterVolumeSpec where

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



import OpenAPI.Docker.Schemas.Topology

data ClusterVolumeSpecAccessMode = ClusterVolumeSpecAccessMode
    {
        accessibilityRequirements :: (Data.Maybe.Maybe (ClusterVolumeSpecAccessModeAccessibilityRequirements)),
        availability :: (Data.Maybe.Maybe (ClusterVolumeSpecAccessModeAvailability)),
        capacityRange :: (Data.Maybe.Maybe (ClusterVolumeSpecAccessModeCapacityRange)),
        mountVolume :: (Data.Maybe.Maybe (ClusterVolumeSpecAccessModeMountVolume)),
        scope :: (Data.Maybe.Maybe (ClusterVolumeSpecAccessModeScope)),
        secrets :: (Data.Maybe.Maybe ([ ClusterVolumeSpecAccessModeSecrets ])),
        sharing :: (Data.Maybe.Maybe (ClusterVolumeSpecAccessModeSharing))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumeSpecAccessMode where
    toJSON ClusterVolumeSpecAccessMode {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AccessibilityRequirements" Data.Aeson..= accessibilityRequirements | Just accessibilityRequirements <- [accessibilityRequirements] ]
        ++ [ "Availability" Data.Aeson..= availability | Just availability <- [availability] ]
        ++ [ "CapacityRange" Data.Aeson..= capacityRange | Just capacityRange <- [capacityRange] ]
        ++ [ "MountVolume" Data.Aeson..= mountVolume | Just mountVolume <- [mountVolume] ]
        ++ [ "Scope" Data.Aeson..= scope | Just scope <- [scope] ]
        ++ [ "Secrets" Data.Aeson..= secrets | Just secrets <- [secrets] ]
        ++ [ "Sharing" Data.Aeson..= sharing | Just sharing <- [sharing] ])

    toEncoding ClusterVolumeSpecAccessMode {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AccessibilityRequirements" . Data.Aeson.toEncoding) accessibilityRequirements <>
          maybe mempty (Data.Aeson.Encoding.pair "Availability" . Data.Aeson.toEncoding) availability <>
          maybe mempty (Data.Aeson.Encoding.pair "CapacityRange" . Data.Aeson.toEncoding) capacityRange <>
          maybe mempty (Data.Aeson.Encoding.pair "MountVolume" . Data.Aeson.toEncoding) mountVolume <>
          maybe mempty (Data.Aeson.Encoding.pair "Scope" . Data.Aeson.toEncoding) scope <>
          maybe mempty (Data.Aeson.Encoding.pair "Secrets" . Data.Aeson.toEncoding) secrets <>
          maybe mempty (Data.Aeson.Encoding.pair "Sharing" . Data.Aeson.toEncoding) sharing
        )

instance Data.Aeson.FromJSON ClusterVolumeSpecAccessMode where
    parseJSON = Data.Aeson.withObject "ClusterVolumeSpecAccessMode" $ \o ->
        ClusterVolumeSpecAccessMode
            <$> o Data.Aeson..:? "AccessibilityRequirements"
            <*> o Data.Aeson..:? "Availability"
            <*> o Data.Aeson..:? "CapacityRange"
            <*> o Data.Aeson..:? "MountVolume"
            <*> o Data.Aeson..:? "Scope"
            <*> o Data.Aeson..:? "Secrets"
            <*> o Data.Aeson..:? "Sharing"

data ClusterVolumeSpecAccessModeAccessibilityRequirements = ClusterVolumeSpecAccessModeAccessibilityRequirements
    {
        preferred :: (Data.Maybe.Maybe ([ Topology ])),
        requisite :: (Data.Maybe.Maybe ([ Topology ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumeSpecAccessModeAccessibilityRequirements where
    toJSON ClusterVolumeSpecAccessModeAccessibilityRequirements {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Preferred" Data.Aeson..= preferred | Just preferred <- [preferred] ]
        ++ [ "Requisite" Data.Aeson..= requisite | Just requisite <- [requisite] ])

    toEncoding ClusterVolumeSpecAccessModeAccessibilityRequirements {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Preferred" . Data.Aeson.toEncoding) preferred <>
          maybe mempty (Data.Aeson.Encoding.pair "Requisite" . Data.Aeson.toEncoding) requisite
        )

instance Data.Aeson.FromJSON ClusterVolumeSpecAccessModeAccessibilityRequirements where
    parseJSON = Data.Aeson.withObject "ClusterVolumeSpecAccessModeAccessibilityRequirements" $ \o ->
        ClusterVolumeSpecAccessModeAccessibilityRequirements
            <$> o Data.Aeson..:? "Preferred"
            <*> o Data.Aeson..:? "Requisite"

data ClusterVolumeSpecAccessModeAvailability
    = ClusterVolumeSpecAccessModeAvailabilityActive
    | ClusterVolumeSpecAccessModeAvailabilityPause
    | ClusterVolumeSpecAccessModeAvailabilityDrain
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ClusterVolumeSpecAccessModeAvailability where
    toJSON x = case x of
        ClusterVolumeSpecAccessModeAvailabilityActive -> "active"
        ClusterVolumeSpecAccessModeAvailabilityPause -> "pause"
        ClusterVolumeSpecAccessModeAvailabilityDrain -> "drain"

    toEncoding x = case x of
        ClusterVolumeSpecAccessModeAvailabilityActive -> Data.Aeson.Encoding.text "active"
        ClusterVolumeSpecAccessModeAvailabilityPause -> Data.Aeson.Encoding.text "pause"
        ClusterVolumeSpecAccessModeAvailabilityDrain -> Data.Aeson.Encoding.text "drain"

instance Data.Aeson.FromJSON ClusterVolumeSpecAccessModeAvailability where
    parseJSON = Data.Aeson.withText "ClusterVolumeSpecAccessModeAvailability" $ \s ->
        case s of
            "active" -> pure ClusterVolumeSpecAccessModeAvailabilityActive
            "pause" -> pure ClusterVolumeSpecAccessModeAvailabilityPause
            "drain" -> pure ClusterVolumeSpecAccessModeAvailabilityDrain
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ClusterVolumeSpecAccessModeAvailability where
    toQueryParam x = case x of
        ClusterVolumeSpecAccessModeAvailabilityActive -> "active"
        ClusterVolumeSpecAccessModeAvailabilityPause -> "pause"
        ClusterVolumeSpecAccessModeAvailabilityDrain -> "drain"

instance Web.HttpApiData.FromHttpApiData ClusterVolumeSpecAccessModeAvailability where
    parseUrlPiece x =
        case x of
            "active" -> pure ClusterVolumeSpecAccessModeAvailabilityActive
            "pause" -> pure ClusterVolumeSpecAccessModeAvailabilityPause
            "drain" -> pure ClusterVolumeSpecAccessModeAvailabilityDrain
            _ -> Left "invalid enum value"

data ClusterVolumeSpecAccessModeCapacityRange = ClusterVolumeSpecAccessModeCapacityRange
    {
        limitBytes :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        requiredBytes :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumeSpecAccessModeCapacityRange where
    toJSON ClusterVolumeSpecAccessModeCapacityRange {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "LimitBytes" Data.Aeson..= limitBytes | Just limitBytes <- [limitBytes] ]
        ++ [ "RequiredBytes" Data.Aeson..= requiredBytes | Just requiredBytes <- [requiredBytes] ])

    toEncoding ClusterVolumeSpecAccessModeCapacityRange {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "LimitBytes" . Data.Aeson.toEncoding) limitBytes <>
          maybe mempty (Data.Aeson.Encoding.pair "RequiredBytes" . Data.Aeson.toEncoding) requiredBytes
        )

instance Data.Aeson.FromJSON ClusterVolumeSpecAccessModeCapacityRange where
    parseJSON = Data.Aeson.withObject "ClusterVolumeSpecAccessModeCapacityRange" $ \o ->
        ClusterVolumeSpecAccessModeCapacityRange
            <$> o Data.Aeson..:? "LimitBytes"
            <*> o Data.Aeson..:? "RequiredBytes"

data ClusterVolumeSpecAccessModeMountVolume = ClusterVolumeSpecAccessModeMountVolume
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumeSpecAccessModeMountVolume where
    toJSON ClusterVolumeSpecAccessModeMountVolume {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding ClusterVolumeSpecAccessModeMountVolume {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON ClusterVolumeSpecAccessModeMountVolume where
    parseJSON = Data.Aeson.withObject "ClusterVolumeSpecAccessModeMountVolume" $ \o ->
        ClusterVolumeSpecAccessModeMountVolume
            

data ClusterVolumeSpecAccessModeScope
    = ClusterVolumeSpecAccessModeScopeSingle
    | ClusterVolumeSpecAccessModeScopeMulti
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ClusterVolumeSpecAccessModeScope where
    toJSON x = case x of
        ClusterVolumeSpecAccessModeScopeSingle -> "single"
        ClusterVolumeSpecAccessModeScopeMulti -> "multi"

    toEncoding x = case x of
        ClusterVolumeSpecAccessModeScopeSingle -> Data.Aeson.Encoding.text "single"
        ClusterVolumeSpecAccessModeScopeMulti -> Data.Aeson.Encoding.text "multi"

instance Data.Aeson.FromJSON ClusterVolumeSpecAccessModeScope where
    parseJSON = Data.Aeson.withText "ClusterVolumeSpecAccessModeScope" $ \s ->
        case s of
            "single" -> pure ClusterVolumeSpecAccessModeScopeSingle
            "multi" -> pure ClusterVolumeSpecAccessModeScopeMulti
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ClusterVolumeSpecAccessModeScope where
    toQueryParam x = case x of
        ClusterVolumeSpecAccessModeScopeSingle -> "single"
        ClusterVolumeSpecAccessModeScopeMulti -> "multi"

instance Web.HttpApiData.FromHttpApiData ClusterVolumeSpecAccessModeScope where
    parseUrlPiece x =
        case x of
            "single" -> pure ClusterVolumeSpecAccessModeScopeSingle
            "multi" -> pure ClusterVolumeSpecAccessModeScopeMulti
            _ -> Left "invalid enum value"

data ClusterVolumeSpecAccessModeSecrets = ClusterVolumeSpecAccessModeSecrets
    {
        key :: (Data.Maybe.Maybe (Data.Text.Text)),
        secret :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumeSpecAccessModeSecrets where
    toJSON ClusterVolumeSpecAccessModeSecrets {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Key" Data.Aeson..= key | Just key <- [key] ]
        ++ [ "Secret" Data.Aeson..= secret | Just secret <- [secret] ])

    toEncoding ClusterVolumeSpecAccessModeSecrets {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Key" . Data.Aeson.toEncoding) key <>
          maybe mempty (Data.Aeson.Encoding.pair "Secret" . Data.Aeson.toEncoding) secret
        )

instance Data.Aeson.FromJSON ClusterVolumeSpecAccessModeSecrets where
    parseJSON = Data.Aeson.withObject "ClusterVolumeSpecAccessModeSecrets" $ \o ->
        ClusterVolumeSpecAccessModeSecrets
            <$> o Data.Aeson..:? "Key"
            <*> o Data.Aeson..:? "Secret"

data ClusterVolumeSpecAccessModeSharing
    = ClusterVolumeSpecAccessModeSharingNone
    | ClusterVolumeSpecAccessModeSharingReadonly
    | ClusterVolumeSpecAccessModeSharingOnewriter
    | ClusterVolumeSpecAccessModeSharingAll
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ClusterVolumeSpecAccessModeSharing where
    toJSON x = case x of
        ClusterVolumeSpecAccessModeSharingNone -> "none"
        ClusterVolumeSpecAccessModeSharingReadonly -> "readonly"
        ClusterVolumeSpecAccessModeSharingOnewriter -> "onewriter"
        ClusterVolumeSpecAccessModeSharingAll -> "all"

    toEncoding x = case x of
        ClusterVolumeSpecAccessModeSharingNone -> Data.Aeson.Encoding.text "none"
        ClusterVolumeSpecAccessModeSharingReadonly -> Data.Aeson.Encoding.text "readonly"
        ClusterVolumeSpecAccessModeSharingOnewriter -> Data.Aeson.Encoding.text "onewriter"
        ClusterVolumeSpecAccessModeSharingAll -> Data.Aeson.Encoding.text "all"

instance Data.Aeson.FromJSON ClusterVolumeSpecAccessModeSharing where
    parseJSON = Data.Aeson.withText "ClusterVolumeSpecAccessModeSharing" $ \s ->
        case s of
            "none" -> pure ClusterVolumeSpecAccessModeSharingNone
            "readonly" -> pure ClusterVolumeSpecAccessModeSharingReadonly
            "onewriter" -> pure ClusterVolumeSpecAccessModeSharingOnewriter
            "all" -> pure ClusterVolumeSpecAccessModeSharingAll
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ClusterVolumeSpecAccessModeSharing where
    toQueryParam x = case x of
        ClusterVolumeSpecAccessModeSharingNone -> "none"
        ClusterVolumeSpecAccessModeSharingReadonly -> "readonly"
        ClusterVolumeSpecAccessModeSharingOnewriter -> "onewriter"
        ClusterVolumeSpecAccessModeSharingAll -> "all"

instance Web.HttpApiData.FromHttpApiData ClusterVolumeSpecAccessModeSharing where
    parseUrlPiece x =
        case x of
            "none" -> pure ClusterVolumeSpecAccessModeSharingNone
            "readonly" -> pure ClusterVolumeSpecAccessModeSharingReadonly
            "onewriter" -> pure ClusterVolumeSpecAccessModeSharingOnewriter
            "all" -> pure ClusterVolumeSpecAccessModeSharingAll
            _ -> Left "invalid enum value"

data ClusterVolumeSpec = ClusterVolumeSpec
    {
        accessMode :: (Data.Maybe.Maybe (ClusterVolumeSpecAccessMode)),
        group :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterVolumeSpec where
    toJSON ClusterVolumeSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AccessMode" Data.Aeson..= accessMode | Just accessMode <- [accessMode] ]
        ++ [ "Group" Data.Aeson..= group | Just group <- [group] ])

    toEncoding ClusterVolumeSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AccessMode" . Data.Aeson.toEncoding) accessMode <>
          maybe mempty (Data.Aeson.Encoding.pair "Group" . Data.Aeson.toEncoding) group
        )

instance Data.Aeson.FromJSON ClusterVolumeSpec where
    parseJSON = Data.Aeson.withObject "ClusterVolumeSpec" $ \o ->
        ClusterVolumeSpec
            <$> o Data.Aeson..:? "AccessMode"
            <*> o Data.Aeson..:? "Group"