{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.SwarmSpec where

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





data SwarmSpecCAConfig = SwarmSpecCAConfig
    {
        externalCAs :: (Data.Maybe.Maybe ([ SwarmSpecCAConfigExternalCAs ])),
        forceRotate :: (Data.Maybe.Maybe (GHC.Int.Int)),
        nodeCertExpiry :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        signingCACert :: (Data.Maybe.Maybe (Data.Text.Text)),
        signingCAKey :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecCAConfig where
    toJSON SwarmSpecCAConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ExternalCAs" Data.Aeson..= externalCAs | Just externalCAs <- [externalCAs] ]
        ++ [ "ForceRotate" Data.Aeson..= forceRotate | Just forceRotate <- [forceRotate] ]
        ++ [ "NodeCertExpiry" Data.Aeson..= nodeCertExpiry | Just nodeCertExpiry <- [nodeCertExpiry] ]
        ++ [ "SigningCACert" Data.Aeson..= signingCACert | Just signingCACert <- [signingCACert] ]
        ++ [ "SigningCAKey" Data.Aeson..= signingCAKey | Just signingCAKey <- [signingCAKey] ])

    toEncoding SwarmSpecCAConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ExternalCAs" . Data.Aeson.toEncoding) externalCAs <>
          maybe mempty (Data.Aeson.Encoding.pair "ForceRotate" . Data.Aeson.toEncoding) forceRotate <>
          maybe mempty (Data.Aeson.Encoding.pair "NodeCertExpiry" . Data.Aeson.toEncoding) nodeCertExpiry <>
          maybe mempty (Data.Aeson.Encoding.pair "SigningCACert" . Data.Aeson.toEncoding) signingCACert <>
          maybe mempty (Data.Aeson.Encoding.pair "SigningCAKey" . Data.Aeson.toEncoding) signingCAKey
        )

instance Data.Aeson.FromJSON SwarmSpecCAConfig where
    parseJSON = Data.Aeson.withObject "SwarmSpecCAConfig" $ \o ->
        SwarmSpecCAConfig
            <$> o Data.Aeson..:? "ExternalCAs"
            <*> o Data.Aeson..:? "ForceRotate"
            <*> o Data.Aeson..:? "NodeCertExpiry"
            <*> o Data.Aeson..:? "SigningCACert"
            <*> o Data.Aeson..:? "SigningCAKey"

data SwarmSpecCAConfigExternalCAs = SwarmSpecCAConfigExternalCAs
    {
        cACert :: (Data.Maybe.Maybe (Data.Text.Text)),
        options :: (Data.Maybe.Maybe (SwarmSpecCAConfigExternalCAsOptions)),
        protocol :: (Data.Maybe.Maybe (SwarmSpecCAConfigExternalCAsProtocol)),
        uRL :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecCAConfigExternalCAs where
    toJSON SwarmSpecCAConfigExternalCAs {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CACert" Data.Aeson..= cACert | Just cACert <- [cACert] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ]
        ++ [ "Protocol" Data.Aeson..= protocol | Just protocol <- [protocol] ]
        ++ [ "URL" Data.Aeson..= uRL | Just uRL <- [uRL] ])

    toEncoding SwarmSpecCAConfigExternalCAs {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CACert" . Data.Aeson.toEncoding) cACert <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options <>
          maybe mempty (Data.Aeson.Encoding.pair "Protocol" . Data.Aeson.toEncoding) protocol <>
          maybe mempty (Data.Aeson.Encoding.pair "URL" . Data.Aeson.toEncoding) uRL
        )

instance Data.Aeson.FromJSON SwarmSpecCAConfigExternalCAs where
    parseJSON = Data.Aeson.withObject "SwarmSpecCAConfigExternalCAs" $ \o ->
        SwarmSpecCAConfigExternalCAs
            <$> o Data.Aeson..:? "CACert"
            <*> o Data.Aeson..:? "Options"
            <*> o Data.Aeson..:? "Protocol"
            <*> o Data.Aeson..:? "URL"

newtype SwarmSpecCAConfigExternalCAsOptions = SwarmSpecCAConfigExternalCAsOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecCAConfigExternalCAsOptions where
    toJSON (SwarmSpecCAConfigExternalCAsOptions x) =
        Data.Aeson.toJSON x

    toEncoding (SwarmSpecCAConfigExternalCAsOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON SwarmSpecCAConfigExternalCAsOptions where
    parseJSON x =
        SwarmSpecCAConfigExternalCAsOptions <$> Data.Aeson.parseJSON x

data SwarmSpecCAConfigExternalCAsProtocol
    = SwarmSpecCAConfigExternalCAsProtocolCfssl
    deriving (Eq, Show)

instance Data.Aeson.ToJSON SwarmSpecCAConfigExternalCAsProtocol where
    toJSON x = case x of
        SwarmSpecCAConfigExternalCAsProtocolCfssl -> "cfssl"

    toEncoding x = case x of
        SwarmSpecCAConfigExternalCAsProtocolCfssl -> Data.Aeson.Encoding.text "cfssl"

instance Data.Aeson.FromJSON SwarmSpecCAConfigExternalCAsProtocol where
    parseJSON = Data.Aeson.withText "SwarmSpecCAConfigExternalCAsProtocol" $ \s ->
        case s of
            "cfssl" -> pure SwarmSpecCAConfigExternalCAsProtocolCfssl
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData SwarmSpecCAConfigExternalCAsProtocol where
    toQueryParam x = case x of
        SwarmSpecCAConfigExternalCAsProtocolCfssl -> "cfssl"

instance Web.HttpApiData.FromHttpApiData SwarmSpecCAConfigExternalCAsProtocol where
    parseUrlPiece x =
        case x of
            "cfssl" -> pure SwarmSpecCAConfigExternalCAsProtocolCfssl
            _ -> Left "invalid enum value"

newtype SwarmSpecDispatcher = SwarmSpecDispatcher
    {
        heartbeatPeriod :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecDispatcher where
    toJSON SwarmSpecDispatcher {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "HeartbeatPeriod" Data.Aeson..= heartbeatPeriod | Just heartbeatPeriod <- [heartbeatPeriod] ])

    toEncoding SwarmSpecDispatcher {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "HeartbeatPeriod" . Data.Aeson.toEncoding) heartbeatPeriod
        )

instance Data.Aeson.FromJSON SwarmSpecDispatcher where
    parseJSON = Data.Aeson.withObject "SwarmSpecDispatcher" $ \o ->
        SwarmSpecDispatcher
            <$> o Data.Aeson..:? "HeartbeatPeriod"

newtype SwarmSpecEncryptionConfig = SwarmSpecEncryptionConfig
    {
        autoLockManagers :: (Data.Maybe.Maybe (GHC.Types.Bool))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecEncryptionConfig where
    toJSON SwarmSpecEncryptionConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AutoLockManagers" Data.Aeson..= autoLockManagers | Just autoLockManagers <- [autoLockManagers] ])

    toEncoding SwarmSpecEncryptionConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AutoLockManagers" . Data.Aeson.toEncoding) autoLockManagers
        )

instance Data.Aeson.FromJSON SwarmSpecEncryptionConfig where
    parseJSON = Data.Aeson.withObject "SwarmSpecEncryptionConfig" $ \o ->
        SwarmSpecEncryptionConfig
            <$> o Data.Aeson..:? "AutoLockManagers"

newtype SwarmSpecLabels = SwarmSpecLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecLabels where
    toJSON (SwarmSpecLabels x) =
        Data.Aeson.toJSON x

    toEncoding (SwarmSpecLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON SwarmSpecLabels where
    parseJSON x =
        SwarmSpecLabels <$> Data.Aeson.parseJSON x

newtype SwarmSpecOrchestration = SwarmSpecOrchestration
    {
        taskHistoryRetentionLimit :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecOrchestration where
    toJSON SwarmSpecOrchestration {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "TaskHistoryRetentionLimit" Data.Aeson..= taskHistoryRetentionLimit | Just taskHistoryRetentionLimit <- [taskHistoryRetentionLimit] ])

    toEncoding SwarmSpecOrchestration {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "TaskHistoryRetentionLimit" . Data.Aeson.toEncoding) taskHistoryRetentionLimit
        )

instance Data.Aeson.FromJSON SwarmSpecOrchestration where
    parseJSON = Data.Aeson.withObject "SwarmSpecOrchestration" $ \o ->
        SwarmSpecOrchestration
            <$> o Data.Aeson..:? "TaskHistoryRetentionLimit"

data SwarmSpecRaft = SwarmSpecRaft
    {
        electionTick :: (Data.Maybe.Maybe (GHC.Int.Int)),
        heartbeatTick :: (Data.Maybe.Maybe (GHC.Int.Int)),
        keepOldSnapshots :: (Data.Maybe.Maybe (GHC.Int.Int)),
        logEntriesForSlowFollowers :: (Data.Maybe.Maybe (GHC.Int.Int)),
        snapshotInterval :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecRaft where
    toJSON SwarmSpecRaft {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ElectionTick" Data.Aeson..= electionTick | Just electionTick <- [electionTick] ]
        ++ [ "HeartbeatTick" Data.Aeson..= heartbeatTick | Just heartbeatTick <- [heartbeatTick] ]
        ++ [ "KeepOldSnapshots" Data.Aeson..= keepOldSnapshots | Just keepOldSnapshots <- [keepOldSnapshots] ]
        ++ [ "LogEntriesForSlowFollowers" Data.Aeson..= logEntriesForSlowFollowers | Just logEntriesForSlowFollowers <- [logEntriesForSlowFollowers] ]
        ++ [ "SnapshotInterval" Data.Aeson..= snapshotInterval | Just snapshotInterval <- [snapshotInterval] ])

    toEncoding SwarmSpecRaft {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ElectionTick" . Data.Aeson.toEncoding) electionTick <>
          maybe mempty (Data.Aeson.Encoding.pair "HeartbeatTick" . Data.Aeson.toEncoding) heartbeatTick <>
          maybe mempty (Data.Aeson.Encoding.pair "KeepOldSnapshots" . Data.Aeson.toEncoding) keepOldSnapshots <>
          maybe mempty (Data.Aeson.Encoding.pair "LogEntriesForSlowFollowers" . Data.Aeson.toEncoding) logEntriesForSlowFollowers <>
          maybe mempty (Data.Aeson.Encoding.pair "SnapshotInterval" . Data.Aeson.toEncoding) snapshotInterval
        )

instance Data.Aeson.FromJSON SwarmSpecRaft where
    parseJSON = Data.Aeson.withObject "SwarmSpecRaft" $ \o ->
        SwarmSpecRaft
            <$> o Data.Aeson..:? "ElectionTick"
            <*> o Data.Aeson..:? "HeartbeatTick"
            <*> o Data.Aeson..:? "KeepOldSnapshots"
            <*> o Data.Aeson..:? "LogEntriesForSlowFollowers"
            <*> o Data.Aeson..:? "SnapshotInterval"

newtype SwarmSpecTaskDefaults = SwarmSpecTaskDefaults
    {
        logDriver :: (Data.Maybe.Maybe (SwarmSpecTaskDefaultsLogDriver))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecTaskDefaults where
    toJSON SwarmSpecTaskDefaults {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "LogDriver" Data.Aeson..= logDriver | Just logDriver <- [logDriver] ])

    toEncoding SwarmSpecTaskDefaults {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "LogDriver" . Data.Aeson.toEncoding) logDriver
        )

instance Data.Aeson.FromJSON SwarmSpecTaskDefaults where
    parseJSON = Data.Aeson.withObject "SwarmSpecTaskDefaults" $ \o ->
        SwarmSpecTaskDefaults
            <$> o Data.Aeson..:? "LogDriver"

data SwarmSpecTaskDefaultsLogDriver = SwarmSpecTaskDefaultsLogDriver
    {
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        options :: (Data.Maybe.Maybe (SwarmSpecTaskDefaultsLogDriverOptions))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecTaskDefaultsLogDriver where
    toJSON SwarmSpecTaskDefaultsLogDriver {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ])

    toEncoding SwarmSpecTaskDefaultsLogDriver {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options
        )

instance Data.Aeson.FromJSON SwarmSpecTaskDefaultsLogDriver where
    parseJSON = Data.Aeson.withObject "SwarmSpecTaskDefaultsLogDriver" $ \o ->
        SwarmSpecTaskDefaultsLogDriver
            <$> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Options"

newtype SwarmSpecTaskDefaultsLogDriverOptions = SwarmSpecTaskDefaultsLogDriverOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpecTaskDefaultsLogDriverOptions where
    toJSON (SwarmSpecTaskDefaultsLogDriverOptions x) =
        Data.Aeson.toJSON x

    toEncoding (SwarmSpecTaskDefaultsLogDriverOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON SwarmSpecTaskDefaultsLogDriverOptions where
    parseJSON x =
        SwarmSpecTaskDefaultsLogDriverOptions <$> Data.Aeson.parseJSON x

data SwarmSpec = SwarmSpec
    {
        cAConfig :: (Data.Maybe.Maybe (SwarmSpecCAConfig)),
        dispatcher :: (Data.Maybe.Maybe (SwarmSpecDispatcher)),
        encryptionConfig :: (Data.Maybe.Maybe (SwarmSpecEncryptionConfig)),
        labels :: (Data.Maybe.Maybe (SwarmSpecLabels)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        orchestration :: (Data.Maybe.Maybe (SwarmSpecOrchestration)),
        raft :: (Data.Maybe.Maybe (SwarmSpecRaft)),
        taskDefaults :: (Data.Maybe.Maybe (SwarmSpecTaskDefaults))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SwarmSpec where
    toJSON SwarmSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CAConfig" Data.Aeson..= cAConfig | Just cAConfig <- [cAConfig] ]
        ++ [ "Dispatcher" Data.Aeson..= dispatcher | Just dispatcher <- [dispatcher] ]
        ++ [ "EncryptionConfig" Data.Aeson..= encryptionConfig | Just encryptionConfig <- [encryptionConfig] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Orchestration" Data.Aeson..= orchestration | Just orchestration <- [orchestration] ]
        ++ [ "Raft" Data.Aeson..= raft | Just raft <- [raft] ]
        ++ [ "TaskDefaults" Data.Aeson..= taskDefaults | Just taskDefaults <- [taskDefaults] ])

    toEncoding SwarmSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CAConfig" . Data.Aeson.toEncoding) cAConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "Dispatcher" . Data.Aeson.toEncoding) dispatcher <>
          maybe mempty (Data.Aeson.Encoding.pair "EncryptionConfig" . Data.Aeson.toEncoding) encryptionConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Orchestration" . Data.Aeson.toEncoding) orchestration <>
          maybe mempty (Data.Aeson.Encoding.pair "Raft" . Data.Aeson.toEncoding) raft <>
          maybe mempty (Data.Aeson.Encoding.pair "TaskDefaults" . Data.Aeson.toEncoding) taskDefaults
        )

instance Data.Aeson.FromJSON SwarmSpec where
    parseJSON = Data.Aeson.withObject "SwarmSpec" $ \o ->
        SwarmSpec
            <$> o Data.Aeson..:? "CAConfig"
            <*> o Data.Aeson..:? "Dispatcher"
            <*> o Data.Aeson..:? "EncryptionConfig"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Orchestration"
            <*> o Data.Aeson..:? "Raft"
            <*> o Data.Aeson..:? "TaskDefaults"