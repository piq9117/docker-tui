{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.TaskSpec where

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



import OpenAPI.Docker.Schemas.HealthConfig
import OpenAPI.Docker.Schemas.Limit
import OpenAPI.Docker.Schemas.Mount
import OpenAPI.Docker.Schemas.NetworkAttachmentConfig
import OpenAPI.Docker.Schemas.Platform
import OpenAPI.Docker.Schemas.PluginPrivilege
import OpenAPI.Docker.Schemas.ResourceObject

data TaskSpecContainerSpec = TaskSpecContainerSpec
    {
        args :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        capabilityAdd :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        capabilityDrop :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        command :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        configs :: (Data.Maybe.Maybe ([ TaskSpecContainerSpecConfigs ])),
        dNSConfig :: (Data.Maybe.Maybe (TaskSpecContainerSpecDNSConfig)),
        dir :: (Data.Maybe.Maybe (Data.Text.Text)),
        env :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        groups :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        healthCheck :: (Data.Maybe.Maybe (HealthConfig)),
        hostname :: (Data.Maybe.Maybe (Data.Text.Text)),
        hosts :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        image :: (Data.Maybe.Maybe (Data.Text.Text)),
        init :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        isolation :: (Data.Maybe.Maybe (TaskSpecContainerSpecIsolation)),
        labels :: (Data.Maybe.Maybe (TaskSpecContainerSpecLabels)),
        mounts :: (Data.Maybe.Maybe ([ Mount ])),
        oomScoreAdj :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        openStdin :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        privileges :: (Data.Maybe.Maybe (TaskSpecContainerSpecPrivileges)),
        readOnly :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        secrets :: (Data.Maybe.Maybe ([ TaskSpecContainerSpecSecrets ])),
        stopGracePeriod :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        stopSignal :: (Data.Maybe.Maybe (Data.Text.Text)),
        sysctls :: (Data.Maybe.Maybe (TaskSpecContainerSpecSysctls)),
        tTY :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        ulimits :: (Data.Maybe.Maybe ([ TaskSpecContainerSpecUlimits ])),
        user :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpec where
    toJSON TaskSpecContainerSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Args" Data.Aeson..= args | Just args <- [args] ]
        ++ [ "CapabilityAdd" Data.Aeson..= capabilityAdd | Just capabilityAdd <- [capabilityAdd] ]
        ++ [ "CapabilityDrop" Data.Aeson..= capabilityDrop | Just capabilityDrop <- [capabilityDrop] ]
        ++ [ "Command" Data.Aeson..= command | Just command <- [command] ]
        ++ [ "Configs" Data.Aeson..= configs | Just configs <- [configs] ]
        ++ [ "DNSConfig" Data.Aeson..= dNSConfig | Just dNSConfig <- [dNSConfig] ]
        ++ [ "Dir" Data.Aeson..= dir | Just dir <- [dir] ]
        ++ [ "Env" Data.Aeson..= env | Just env <- [env] ]
        ++ [ "Groups" Data.Aeson..= groups | Just groups <- [groups] ]
        ++ [ "HealthCheck" Data.Aeson..= healthCheck | Just healthCheck <- [healthCheck] ]
        ++ [ "Hostname" Data.Aeson..= hostname | Just hostname <- [hostname] ]
        ++ [ "Hosts" Data.Aeson..= hosts | Just hosts <- [hosts] ]
        ++ [ "Image" Data.Aeson..= image | Just image <- [image] ]
        ++ [ "Init" Data.Aeson..= init | Just init <- [init] ]
        ++ [ "Isolation" Data.Aeson..= isolation | Just isolation <- [isolation] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Mounts" Data.Aeson..= mounts | Just mounts <- [mounts] ]
        ++ [ "OomScoreAdj" Data.Aeson..= oomScoreAdj | Just oomScoreAdj <- [oomScoreAdj] ]
        ++ [ "OpenStdin" Data.Aeson..= openStdin | Just openStdin <- [openStdin] ]
        ++ [ "Privileges" Data.Aeson..= privileges | Just privileges <- [privileges] ]
        ++ [ "ReadOnly" Data.Aeson..= readOnly | Just readOnly <- [readOnly] ]
        ++ [ "Secrets" Data.Aeson..= secrets | Just secrets <- [secrets] ]
        ++ [ "StopGracePeriod" Data.Aeson..= stopGracePeriod | Just stopGracePeriod <- [stopGracePeriod] ]
        ++ [ "StopSignal" Data.Aeson..= stopSignal | Just stopSignal <- [stopSignal] ]
        ++ [ "Sysctls" Data.Aeson..= sysctls | Just sysctls <- [sysctls] ]
        ++ [ "TTY" Data.Aeson..= tTY | Just tTY <- [tTY] ]
        ++ [ "Ulimits" Data.Aeson..= ulimits | Just ulimits <- [ulimits] ]
        ++ [ "User" Data.Aeson..= user | Just user <- [user] ])

    toEncoding TaskSpecContainerSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Args" . Data.Aeson.toEncoding) args <>
          maybe mempty (Data.Aeson.Encoding.pair "CapabilityAdd" . Data.Aeson.toEncoding) capabilityAdd <>
          maybe mempty (Data.Aeson.Encoding.pair "CapabilityDrop" . Data.Aeson.toEncoding) capabilityDrop <>
          maybe mempty (Data.Aeson.Encoding.pair "Command" . Data.Aeson.toEncoding) command <>
          maybe mempty (Data.Aeson.Encoding.pair "Configs" . Data.Aeson.toEncoding) configs <>
          maybe mempty (Data.Aeson.Encoding.pair "DNSConfig" . Data.Aeson.toEncoding) dNSConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "Dir" . Data.Aeson.toEncoding) dir <>
          maybe mempty (Data.Aeson.Encoding.pair "Env" . Data.Aeson.toEncoding) env <>
          maybe mempty (Data.Aeson.Encoding.pair "Groups" . Data.Aeson.toEncoding) groups <>
          maybe mempty (Data.Aeson.Encoding.pair "HealthCheck" . Data.Aeson.toEncoding) healthCheck <>
          maybe mempty (Data.Aeson.Encoding.pair "Hostname" . Data.Aeson.toEncoding) hostname <>
          maybe mempty (Data.Aeson.Encoding.pair "Hosts" . Data.Aeson.toEncoding) hosts <>
          maybe mempty (Data.Aeson.Encoding.pair "Image" . Data.Aeson.toEncoding) image <>
          maybe mempty (Data.Aeson.Encoding.pair "Init" . Data.Aeson.toEncoding) init <>
          maybe mempty (Data.Aeson.Encoding.pair "Isolation" . Data.Aeson.toEncoding) isolation <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Mounts" . Data.Aeson.toEncoding) mounts <>
          maybe mempty (Data.Aeson.Encoding.pair "OomScoreAdj" . Data.Aeson.toEncoding) oomScoreAdj <>
          maybe mempty (Data.Aeson.Encoding.pair "OpenStdin" . Data.Aeson.toEncoding) openStdin <>
          maybe mempty (Data.Aeson.Encoding.pair "Privileges" . Data.Aeson.toEncoding) privileges <>
          maybe mempty (Data.Aeson.Encoding.pair "ReadOnly" . Data.Aeson.toEncoding) readOnly <>
          maybe mempty (Data.Aeson.Encoding.pair "Secrets" . Data.Aeson.toEncoding) secrets <>
          maybe mempty (Data.Aeson.Encoding.pair "StopGracePeriod" . Data.Aeson.toEncoding) stopGracePeriod <>
          maybe mempty (Data.Aeson.Encoding.pair "StopSignal" . Data.Aeson.toEncoding) stopSignal <>
          maybe mempty (Data.Aeson.Encoding.pair "Sysctls" . Data.Aeson.toEncoding) sysctls <>
          maybe mempty (Data.Aeson.Encoding.pair "TTY" . Data.Aeson.toEncoding) tTY <>
          maybe mempty (Data.Aeson.Encoding.pair "Ulimits" . Data.Aeson.toEncoding) ulimits <>
          maybe mempty (Data.Aeson.Encoding.pair "User" . Data.Aeson.toEncoding) user
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpec where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpec" $ \o ->
        TaskSpecContainerSpec
            <$> o Data.Aeson..:? "Args"
            <*> o Data.Aeson..:? "CapabilityAdd"
            <*> o Data.Aeson..:? "CapabilityDrop"
            <*> o Data.Aeson..:? "Command"
            <*> o Data.Aeson..:? "Configs"
            <*> o Data.Aeson..:? "DNSConfig"
            <*> o Data.Aeson..:? "Dir"
            <*> o Data.Aeson..:? "Env"
            <*> o Data.Aeson..:? "Groups"
            <*> o Data.Aeson..:? "HealthCheck"
            <*> o Data.Aeson..:? "Hostname"
            <*> o Data.Aeson..:? "Hosts"
            <*> o Data.Aeson..:? "Image"
            <*> o Data.Aeson..:? "Init"
            <*> o Data.Aeson..:? "Isolation"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Mounts"
            <*> o Data.Aeson..:? "OomScoreAdj"
            <*> o Data.Aeson..:? "OpenStdin"
            <*> o Data.Aeson..:? "Privileges"
            <*> o Data.Aeson..:? "ReadOnly"
            <*> o Data.Aeson..:? "Secrets"
            <*> o Data.Aeson..:? "StopGracePeriod"
            <*> o Data.Aeson..:? "StopSignal"
            <*> o Data.Aeson..:? "Sysctls"
            <*> o Data.Aeson..:? "TTY"
            <*> o Data.Aeson..:? "Ulimits"
            <*> o Data.Aeson..:? "User"

data TaskSpecContainerSpecConfigs = TaskSpecContainerSpecConfigs
    {
        configID :: (Data.Maybe.Maybe (Data.Text.Text)),
        configName :: (Data.Maybe.Maybe (Data.Text.Text)),
        file :: (Data.Maybe.Maybe (TaskSpecContainerSpecConfigsFile)),
        runtime :: (Data.Maybe.Maybe (TaskSpecContainerSpecConfigsRuntime))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecConfigs where
    toJSON TaskSpecContainerSpecConfigs {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ConfigID" Data.Aeson..= configID | Just configID <- [configID] ]
        ++ [ "ConfigName" Data.Aeson..= configName | Just configName <- [configName] ]
        ++ [ "File" Data.Aeson..= file | Just file <- [file] ]
        ++ [ "Runtime" Data.Aeson..= runtime | Just runtime <- [runtime] ])

    toEncoding TaskSpecContainerSpecConfigs {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ConfigID" . Data.Aeson.toEncoding) configID <>
          maybe mempty (Data.Aeson.Encoding.pair "ConfigName" . Data.Aeson.toEncoding) configName <>
          maybe mempty (Data.Aeson.Encoding.pair "File" . Data.Aeson.toEncoding) file <>
          maybe mempty (Data.Aeson.Encoding.pair "Runtime" . Data.Aeson.toEncoding) runtime
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecConfigs where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecConfigs" $ \o ->
        TaskSpecContainerSpecConfigs
            <$> o Data.Aeson..:? "ConfigID"
            <*> o Data.Aeson..:? "ConfigName"
            <*> o Data.Aeson..:? "File"
            <*> o Data.Aeson..:? "Runtime"

data TaskSpecContainerSpecConfigsFile = TaskSpecContainerSpecConfigsFile
    {
        gID :: (Data.Maybe.Maybe (Data.Text.Text)),
        mode :: (Data.Maybe.Maybe (GHC.Int.Int)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        uID :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecConfigsFile where
    toJSON TaskSpecContainerSpecConfigsFile {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "GID" Data.Aeson..= gID | Just gID <- [gID] ]
        ++ [ "Mode" Data.Aeson..= mode | Just mode <- [mode] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "UID" Data.Aeson..= uID | Just uID <- [uID] ])

    toEncoding TaskSpecContainerSpecConfigsFile {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "GID" . Data.Aeson.toEncoding) gID <>
          maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "UID" . Data.Aeson.toEncoding) uID
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecConfigsFile where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecConfigsFile" $ \o ->
        TaskSpecContainerSpecConfigsFile
            <$> o Data.Aeson..:? "GID"
            <*> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "UID"

data TaskSpecContainerSpecConfigsRuntime = TaskSpecContainerSpecConfigsRuntime
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecConfigsRuntime where
    toJSON TaskSpecContainerSpecConfigsRuntime {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding TaskSpecContainerSpecConfigsRuntime {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecConfigsRuntime where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecConfigsRuntime" $ \o ->
        TaskSpecContainerSpecConfigsRuntime
            

data TaskSpecContainerSpecDNSConfig = TaskSpecContainerSpecDNSConfig
    {
        nameservers :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        options :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        search :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecDNSConfig where
    toJSON TaskSpecContainerSpecDNSConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Nameservers" Data.Aeson..= nameservers | Just nameservers <- [nameservers] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ]
        ++ [ "Search" Data.Aeson..= search | Just search <- [search] ])

    toEncoding TaskSpecContainerSpecDNSConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Nameservers" . Data.Aeson.toEncoding) nameservers <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options <>
          maybe mempty (Data.Aeson.Encoding.pair "Search" . Data.Aeson.toEncoding) search
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecDNSConfig where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecDNSConfig" $ \o ->
        TaskSpecContainerSpecDNSConfig
            <$> o Data.Aeson..:? "Nameservers"
            <*> o Data.Aeson..:? "Options"
            <*> o Data.Aeson..:? "Search"

data TaskSpecContainerSpecIsolation
    = TaskSpecContainerSpecIsolationDefault
    | TaskSpecContainerSpecIsolationProcess
    | TaskSpecContainerSpecIsolationHyperv
    | TaskSpecContainerSpecIsolation
    deriving (Eq, Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecIsolation where
    toJSON x = case x of
        TaskSpecContainerSpecIsolationDefault -> "default"
        TaskSpecContainerSpecIsolationProcess -> "process"
        TaskSpecContainerSpecIsolationHyperv -> "hyperv"
        TaskSpecContainerSpecIsolation -> ""

    toEncoding x = case x of
        TaskSpecContainerSpecIsolationDefault -> Data.Aeson.Encoding.text "default"
        TaskSpecContainerSpecIsolationProcess -> Data.Aeson.Encoding.text "process"
        TaskSpecContainerSpecIsolationHyperv -> Data.Aeson.Encoding.text "hyperv"
        TaskSpecContainerSpecIsolation -> Data.Aeson.Encoding.text ""

instance Data.Aeson.FromJSON TaskSpecContainerSpecIsolation where
    parseJSON = Data.Aeson.withText "TaskSpecContainerSpecIsolation" $ \s ->
        case s of
            "default" -> pure TaskSpecContainerSpecIsolationDefault
            "process" -> pure TaskSpecContainerSpecIsolationProcess
            "hyperv" -> pure TaskSpecContainerSpecIsolationHyperv
            "" -> pure TaskSpecContainerSpecIsolation
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData TaskSpecContainerSpecIsolation where
    toQueryParam x = case x of
        TaskSpecContainerSpecIsolationDefault -> "default"
        TaskSpecContainerSpecIsolationProcess -> "process"
        TaskSpecContainerSpecIsolationHyperv -> "hyperv"
        TaskSpecContainerSpecIsolation -> ""

instance Web.HttpApiData.FromHttpApiData TaskSpecContainerSpecIsolation where
    parseUrlPiece x =
        case x of
            "default" -> pure TaskSpecContainerSpecIsolationDefault
            "process" -> pure TaskSpecContainerSpecIsolationProcess
            "hyperv" -> pure TaskSpecContainerSpecIsolationHyperv
            "" -> pure TaskSpecContainerSpecIsolation
            _ -> Left "invalid enum value"

newtype TaskSpecContainerSpecLabels = TaskSpecContainerSpecLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecLabels where
    toJSON (TaskSpecContainerSpecLabels x) =
        Data.Aeson.toJSON x

    toEncoding (TaskSpecContainerSpecLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON TaskSpecContainerSpecLabels where
    parseJSON x =
        TaskSpecContainerSpecLabels <$> Data.Aeson.parseJSON x

data TaskSpecContainerSpecPrivileges = TaskSpecContainerSpecPrivileges
    {
        appArmor :: (Data.Maybe.Maybe (TaskSpecContainerSpecPrivilegesAppArmor)),
        credentialSpec :: (Data.Maybe.Maybe (TaskSpecContainerSpecPrivilegesCredentialSpec)),
        noNewPrivileges :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        sELinuxContext :: (Data.Maybe.Maybe (TaskSpecContainerSpecPrivilegesSELinuxContext)),
        seccomp :: (Data.Maybe.Maybe (TaskSpecContainerSpecPrivilegesSeccomp))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecPrivileges where
    toJSON TaskSpecContainerSpecPrivileges {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AppArmor" Data.Aeson..= appArmor | Just appArmor <- [appArmor] ]
        ++ [ "CredentialSpec" Data.Aeson..= credentialSpec | Just credentialSpec <- [credentialSpec] ]
        ++ [ "NoNewPrivileges" Data.Aeson..= noNewPrivileges | Just noNewPrivileges <- [noNewPrivileges] ]
        ++ [ "SELinuxContext" Data.Aeson..= sELinuxContext | Just sELinuxContext <- [sELinuxContext] ]
        ++ [ "Seccomp" Data.Aeson..= seccomp | Just seccomp <- [seccomp] ])

    toEncoding TaskSpecContainerSpecPrivileges {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AppArmor" . Data.Aeson.toEncoding) appArmor <>
          maybe mempty (Data.Aeson.Encoding.pair "CredentialSpec" . Data.Aeson.toEncoding) credentialSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "NoNewPrivileges" . Data.Aeson.toEncoding) noNewPrivileges <>
          maybe mempty (Data.Aeson.Encoding.pair "SELinuxContext" . Data.Aeson.toEncoding) sELinuxContext <>
          maybe mempty (Data.Aeson.Encoding.pair "Seccomp" . Data.Aeson.toEncoding) seccomp
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecPrivileges where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecPrivileges" $ \o ->
        TaskSpecContainerSpecPrivileges
            <$> o Data.Aeson..:? "AppArmor"
            <*> o Data.Aeson..:? "CredentialSpec"
            <*> o Data.Aeson..:? "NoNewPrivileges"
            <*> o Data.Aeson..:? "SELinuxContext"
            <*> o Data.Aeson..:? "Seccomp"

newtype TaskSpecContainerSpecPrivilegesAppArmor = TaskSpecContainerSpecPrivilegesAppArmor
    {
        mode :: (Data.Maybe.Maybe (TaskSpecContainerSpecPrivilegesAppArmorMode))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecPrivilegesAppArmor where
    toJSON TaskSpecContainerSpecPrivilegesAppArmor {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Mode" Data.Aeson..= mode | Just mode <- [mode] ])

    toEncoding TaskSpecContainerSpecPrivilegesAppArmor {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecPrivilegesAppArmor where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecPrivilegesAppArmor" $ \o ->
        TaskSpecContainerSpecPrivilegesAppArmor
            <$> o Data.Aeson..:? "Mode"

data TaskSpecContainerSpecPrivilegesAppArmorMode
    = TaskSpecContainerSpecPrivilegesAppArmorModeDefault
    | TaskSpecContainerSpecPrivilegesAppArmorModeDisabled
    deriving (Eq, Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecPrivilegesAppArmorMode where
    toJSON x = case x of
        TaskSpecContainerSpecPrivilegesAppArmorModeDefault -> "default"
        TaskSpecContainerSpecPrivilegesAppArmorModeDisabled -> "disabled"

    toEncoding x = case x of
        TaskSpecContainerSpecPrivilegesAppArmorModeDefault -> Data.Aeson.Encoding.text "default"
        TaskSpecContainerSpecPrivilegesAppArmorModeDisabled -> Data.Aeson.Encoding.text "disabled"

instance Data.Aeson.FromJSON TaskSpecContainerSpecPrivilegesAppArmorMode where
    parseJSON = Data.Aeson.withText "TaskSpecContainerSpecPrivilegesAppArmorMode" $ \s ->
        case s of
            "default" -> pure TaskSpecContainerSpecPrivilegesAppArmorModeDefault
            "disabled" -> pure TaskSpecContainerSpecPrivilegesAppArmorModeDisabled
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData TaskSpecContainerSpecPrivilegesAppArmorMode where
    toQueryParam x = case x of
        TaskSpecContainerSpecPrivilegesAppArmorModeDefault -> "default"
        TaskSpecContainerSpecPrivilegesAppArmorModeDisabled -> "disabled"

instance Web.HttpApiData.FromHttpApiData TaskSpecContainerSpecPrivilegesAppArmorMode where
    parseUrlPiece x =
        case x of
            "default" -> pure TaskSpecContainerSpecPrivilegesAppArmorModeDefault
            "disabled" -> pure TaskSpecContainerSpecPrivilegesAppArmorModeDisabled
            _ -> Left "invalid enum value"

data TaskSpecContainerSpecPrivilegesCredentialSpec = TaskSpecContainerSpecPrivilegesCredentialSpec
    {
        config :: (Data.Maybe.Maybe (Data.Text.Text)),
        file :: (Data.Maybe.Maybe (Data.Text.Text)),
        registry :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecPrivilegesCredentialSpec where
    toJSON TaskSpecContainerSpecPrivilegesCredentialSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Config" Data.Aeson..= config | Just config <- [config] ]
        ++ [ "File" Data.Aeson..= file | Just file <- [file] ]
        ++ [ "Registry" Data.Aeson..= registry | Just registry <- [registry] ])

    toEncoding TaskSpecContainerSpecPrivilegesCredentialSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Config" . Data.Aeson.toEncoding) config <>
          maybe mempty (Data.Aeson.Encoding.pair "File" . Data.Aeson.toEncoding) file <>
          maybe mempty (Data.Aeson.Encoding.pair "Registry" . Data.Aeson.toEncoding) registry
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecPrivilegesCredentialSpec where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecPrivilegesCredentialSpec" $ \o ->
        TaskSpecContainerSpecPrivilegesCredentialSpec
            <$> o Data.Aeson..:? "Config"
            <*> o Data.Aeson..:? "File"
            <*> o Data.Aeson..:? "Registry"

data TaskSpecContainerSpecPrivilegesSELinuxContext = TaskSpecContainerSpecPrivilegesSELinuxContext
    {
        disable :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        level :: (Data.Maybe.Maybe (Data.Text.Text)),
        role :: (Data.Maybe.Maybe (Data.Text.Text)),
        type' :: (Data.Maybe.Maybe (Data.Text.Text)),
        user :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecPrivilegesSELinuxContext where
    toJSON TaskSpecContainerSpecPrivilegesSELinuxContext {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Disable" Data.Aeson..= disable | Just disable <- [disable] ]
        ++ [ "Level" Data.Aeson..= level | Just level <- [level] ]
        ++ [ "Role" Data.Aeson..= role | Just role <- [role] ]
        ++ [ "Type" Data.Aeson..= type' | Just type' <- [type'] ]
        ++ [ "User" Data.Aeson..= user | Just user <- [user] ])

    toEncoding TaskSpecContainerSpecPrivilegesSELinuxContext {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Disable" . Data.Aeson.toEncoding) disable <>
          maybe mempty (Data.Aeson.Encoding.pair "Level" . Data.Aeson.toEncoding) level <>
          maybe mempty (Data.Aeson.Encoding.pair "Role" . Data.Aeson.toEncoding) role <>
          maybe mempty (Data.Aeson.Encoding.pair "Type" . Data.Aeson.toEncoding) type' <>
          maybe mempty (Data.Aeson.Encoding.pair "User" . Data.Aeson.toEncoding) user
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecPrivilegesSELinuxContext where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecPrivilegesSELinuxContext" $ \o ->
        TaskSpecContainerSpecPrivilegesSELinuxContext
            <$> o Data.Aeson..:? "Disable"
            <*> o Data.Aeson..:? "Level"
            <*> o Data.Aeson..:? "Role"
            <*> o Data.Aeson..:? "Type"
            <*> o Data.Aeson..:? "User"

data TaskSpecContainerSpecPrivilegesSeccomp = TaskSpecContainerSpecPrivilegesSeccomp
    {
        mode :: (Data.Maybe.Maybe (TaskSpecContainerSpecPrivilegesSeccompMode)),
        profile :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecPrivilegesSeccomp where
    toJSON TaskSpecContainerSpecPrivilegesSeccomp {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Mode" Data.Aeson..= mode | Just mode <- [mode] ]
        ++ [ "Profile" Data.Aeson..= profile | Just profile <- [profile] ])

    toEncoding TaskSpecContainerSpecPrivilegesSeccomp {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Profile" . Data.Aeson.toEncoding) profile
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecPrivilegesSeccomp where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecPrivilegesSeccomp" $ \o ->
        TaskSpecContainerSpecPrivilegesSeccomp
            <$> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Profile"

data TaskSpecContainerSpecPrivilegesSeccompMode
    = TaskSpecContainerSpecPrivilegesSeccompModeDefault
    | TaskSpecContainerSpecPrivilegesSeccompModeUnconfined
    | TaskSpecContainerSpecPrivilegesSeccompModeCustom
    deriving (Eq, Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecPrivilegesSeccompMode where
    toJSON x = case x of
        TaskSpecContainerSpecPrivilegesSeccompModeDefault -> "default"
        TaskSpecContainerSpecPrivilegesSeccompModeUnconfined -> "unconfined"
        TaskSpecContainerSpecPrivilegesSeccompModeCustom -> "custom"

    toEncoding x = case x of
        TaskSpecContainerSpecPrivilegesSeccompModeDefault -> Data.Aeson.Encoding.text "default"
        TaskSpecContainerSpecPrivilegesSeccompModeUnconfined -> Data.Aeson.Encoding.text "unconfined"
        TaskSpecContainerSpecPrivilegesSeccompModeCustom -> Data.Aeson.Encoding.text "custom"

instance Data.Aeson.FromJSON TaskSpecContainerSpecPrivilegesSeccompMode where
    parseJSON = Data.Aeson.withText "TaskSpecContainerSpecPrivilegesSeccompMode" $ \s ->
        case s of
            "default" -> pure TaskSpecContainerSpecPrivilegesSeccompModeDefault
            "unconfined" -> pure TaskSpecContainerSpecPrivilegesSeccompModeUnconfined
            "custom" -> pure TaskSpecContainerSpecPrivilegesSeccompModeCustom
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData TaskSpecContainerSpecPrivilegesSeccompMode where
    toQueryParam x = case x of
        TaskSpecContainerSpecPrivilegesSeccompModeDefault -> "default"
        TaskSpecContainerSpecPrivilegesSeccompModeUnconfined -> "unconfined"
        TaskSpecContainerSpecPrivilegesSeccompModeCustom -> "custom"

instance Web.HttpApiData.FromHttpApiData TaskSpecContainerSpecPrivilegesSeccompMode where
    parseUrlPiece x =
        case x of
            "default" -> pure TaskSpecContainerSpecPrivilegesSeccompModeDefault
            "unconfined" -> pure TaskSpecContainerSpecPrivilegesSeccompModeUnconfined
            "custom" -> pure TaskSpecContainerSpecPrivilegesSeccompModeCustom
            _ -> Left "invalid enum value"

data TaskSpecContainerSpecSecrets = TaskSpecContainerSpecSecrets
    {
        file :: (Data.Maybe.Maybe (TaskSpecContainerSpecSecretsFile)),
        secretID :: (Data.Maybe.Maybe (Data.Text.Text)),
        secretName :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecSecrets where
    toJSON TaskSpecContainerSpecSecrets {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "File" Data.Aeson..= file | Just file <- [file] ]
        ++ [ "SecretID" Data.Aeson..= secretID | Just secretID <- [secretID] ]
        ++ [ "SecretName" Data.Aeson..= secretName | Just secretName <- [secretName] ])

    toEncoding TaskSpecContainerSpecSecrets {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "File" . Data.Aeson.toEncoding) file <>
          maybe mempty (Data.Aeson.Encoding.pair "SecretID" . Data.Aeson.toEncoding) secretID <>
          maybe mempty (Data.Aeson.Encoding.pair "SecretName" . Data.Aeson.toEncoding) secretName
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecSecrets where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecSecrets" $ \o ->
        TaskSpecContainerSpecSecrets
            <$> o Data.Aeson..:? "File"
            <*> o Data.Aeson..:? "SecretID"
            <*> o Data.Aeson..:? "SecretName"

data TaskSpecContainerSpecSecretsFile = TaskSpecContainerSpecSecretsFile
    {
        gID :: (Data.Maybe.Maybe (Data.Text.Text)),
        mode :: (Data.Maybe.Maybe (GHC.Int.Int)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        uID :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecSecretsFile where
    toJSON TaskSpecContainerSpecSecretsFile {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "GID" Data.Aeson..= gID | Just gID <- [gID] ]
        ++ [ "Mode" Data.Aeson..= mode | Just mode <- [mode] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "UID" Data.Aeson..= uID | Just uID <- [uID] ])

    toEncoding TaskSpecContainerSpecSecretsFile {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "GID" . Data.Aeson.toEncoding) gID <>
          maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "UID" . Data.Aeson.toEncoding) uID
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecSecretsFile where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecSecretsFile" $ \o ->
        TaskSpecContainerSpecSecretsFile
            <$> o Data.Aeson..:? "GID"
            <*> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "UID"

newtype TaskSpecContainerSpecSysctls = TaskSpecContainerSpecSysctls
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecSysctls where
    toJSON (TaskSpecContainerSpecSysctls x) =
        Data.Aeson.toJSON x

    toEncoding (TaskSpecContainerSpecSysctls x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON TaskSpecContainerSpecSysctls where
    parseJSON x =
        TaskSpecContainerSpecSysctls <$> Data.Aeson.parseJSON x

data TaskSpecContainerSpecUlimits = TaskSpecContainerSpecUlimits
    {
        hard :: (Data.Maybe.Maybe (GHC.Int.Int)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        soft :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecContainerSpecUlimits where
    toJSON TaskSpecContainerSpecUlimits {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Hard" Data.Aeson..= hard | Just hard <- [hard] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Soft" Data.Aeson..= soft | Just soft <- [soft] ])

    toEncoding TaskSpecContainerSpecUlimits {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Hard" . Data.Aeson.toEncoding) hard <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Soft" . Data.Aeson.toEncoding) soft
        )

instance Data.Aeson.FromJSON TaskSpecContainerSpecUlimits where
    parseJSON = Data.Aeson.withObject "TaskSpecContainerSpecUlimits" $ \o ->
        TaskSpecContainerSpecUlimits
            <$> o Data.Aeson..:? "Hard"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Soft"

data TaskSpecLogDriver = TaskSpecLogDriver
    {
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        options :: (Data.Maybe.Maybe (TaskSpecLogDriverOptions))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecLogDriver where
    toJSON TaskSpecLogDriver {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ])

    toEncoding TaskSpecLogDriver {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options
        )

instance Data.Aeson.FromJSON TaskSpecLogDriver where
    parseJSON = Data.Aeson.withObject "TaskSpecLogDriver" $ \o ->
        TaskSpecLogDriver
            <$> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Options"

newtype TaskSpecLogDriverOptions = TaskSpecLogDriverOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecLogDriverOptions where
    toJSON (TaskSpecLogDriverOptions x) =
        Data.Aeson.toJSON x

    toEncoding (TaskSpecLogDriverOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON TaskSpecLogDriverOptions where
    parseJSON x =
        TaskSpecLogDriverOptions <$> Data.Aeson.parseJSON x

newtype TaskSpecNetworkAttachmentSpec = TaskSpecNetworkAttachmentSpec
    {
        containerID :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecNetworkAttachmentSpec where
    toJSON TaskSpecNetworkAttachmentSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ContainerID" Data.Aeson..= containerID | Just containerID <- [containerID] ])

    toEncoding TaskSpecNetworkAttachmentSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ContainerID" . Data.Aeson.toEncoding) containerID
        )

instance Data.Aeson.FromJSON TaskSpecNetworkAttachmentSpec where
    parseJSON = Data.Aeson.withObject "TaskSpecNetworkAttachmentSpec" $ \o ->
        TaskSpecNetworkAttachmentSpec
            <$> o Data.Aeson..:? "ContainerID"

data TaskSpecPlacement = TaskSpecPlacement
    {
        constraints :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        maxReplicas :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        platforms :: (Data.Maybe.Maybe ([ Platform ])),
        preferences :: (Data.Maybe.Maybe ([ TaskSpecPlacementPreferences ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecPlacement where
    toJSON TaskSpecPlacement {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Constraints" Data.Aeson..= constraints | Just constraints <- [constraints] ]
        ++ [ "MaxReplicas" Data.Aeson..= maxReplicas | Just maxReplicas <- [maxReplicas] ]
        ++ [ "Platforms" Data.Aeson..= platforms | Just platforms <- [platforms] ]
        ++ [ "Preferences" Data.Aeson..= preferences | Just preferences <- [preferences] ])

    toEncoding TaskSpecPlacement {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Constraints" . Data.Aeson.toEncoding) constraints <>
          maybe mempty (Data.Aeson.Encoding.pair "MaxReplicas" . Data.Aeson.toEncoding) maxReplicas <>
          maybe mempty (Data.Aeson.Encoding.pair "Platforms" . Data.Aeson.toEncoding) platforms <>
          maybe mempty (Data.Aeson.Encoding.pair "Preferences" . Data.Aeson.toEncoding) preferences
        )

instance Data.Aeson.FromJSON TaskSpecPlacement where
    parseJSON = Data.Aeson.withObject "TaskSpecPlacement" $ \o ->
        TaskSpecPlacement
            <$> o Data.Aeson..:? "Constraints"
            <*> o Data.Aeson..:? "MaxReplicas"
            <*> o Data.Aeson..:? "Platforms"
            <*> o Data.Aeson..:? "Preferences"

newtype TaskSpecPlacementPreferences = TaskSpecPlacementPreferences
    {
        spread :: (Data.Maybe.Maybe (TaskSpecPlacementPreferencesSpread))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecPlacementPreferences where
    toJSON TaskSpecPlacementPreferences {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Spread" Data.Aeson..= spread | Just spread <- [spread] ])

    toEncoding TaskSpecPlacementPreferences {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Spread" . Data.Aeson.toEncoding) spread
        )

instance Data.Aeson.FromJSON TaskSpecPlacementPreferences where
    parseJSON = Data.Aeson.withObject "TaskSpecPlacementPreferences" $ \o ->
        TaskSpecPlacementPreferences
            <$> o Data.Aeson..:? "Spread"

newtype TaskSpecPlacementPreferencesSpread = TaskSpecPlacementPreferencesSpread
    {
        spreadDescriptor :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecPlacementPreferencesSpread where
    toJSON TaskSpecPlacementPreferencesSpread {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "SpreadDescriptor" Data.Aeson..= spreadDescriptor | Just spreadDescriptor <- [spreadDescriptor] ])

    toEncoding TaskSpecPlacementPreferencesSpread {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "SpreadDescriptor" . Data.Aeson.toEncoding) spreadDescriptor
        )

instance Data.Aeson.FromJSON TaskSpecPlacementPreferencesSpread where
    parseJSON = Data.Aeson.withObject "TaskSpecPlacementPreferencesSpread" $ \o ->
        TaskSpecPlacementPreferencesSpread
            <$> o Data.Aeson..:? "SpreadDescriptor"

data TaskSpecPluginSpec = TaskSpecPluginSpec
    {
        disabled :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        pluginPrivilege :: (Data.Maybe.Maybe ([ PluginPrivilege ])),
        remote :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecPluginSpec where
    toJSON TaskSpecPluginSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Disabled" Data.Aeson..= disabled | Just disabled <- [disabled] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "PluginPrivilege" Data.Aeson..= pluginPrivilege | Just pluginPrivilege <- [pluginPrivilege] ]
        ++ [ "Remote" Data.Aeson..= remote | Just remote <- [remote] ])

    toEncoding TaskSpecPluginSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Disabled" . Data.Aeson.toEncoding) disabled <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "PluginPrivilege" . Data.Aeson.toEncoding) pluginPrivilege <>
          maybe mempty (Data.Aeson.Encoding.pair "Remote" . Data.Aeson.toEncoding) remote
        )

instance Data.Aeson.FromJSON TaskSpecPluginSpec where
    parseJSON = Data.Aeson.withObject "TaskSpecPluginSpec" $ \o ->
        TaskSpecPluginSpec
            <$> o Data.Aeson..:? "Disabled"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "PluginPrivilege"
            <*> o Data.Aeson..:? "Remote"

data TaskSpecResources = TaskSpecResources
    {
        limits :: (Data.Maybe.Maybe (Limit)),
        reservations :: (Data.Maybe.Maybe (ResourceObject))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecResources where
    toJSON TaskSpecResources {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Limits" Data.Aeson..= limits | Just limits <- [limits] ]
        ++ [ "Reservations" Data.Aeson..= reservations | Just reservations <- [reservations] ])

    toEncoding TaskSpecResources {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Limits" . Data.Aeson.toEncoding) limits <>
          maybe mempty (Data.Aeson.Encoding.pair "Reservations" . Data.Aeson.toEncoding) reservations
        )

instance Data.Aeson.FromJSON TaskSpecResources where
    parseJSON = Data.Aeson.withObject "TaskSpecResources" $ \o ->
        TaskSpecResources
            <$> o Data.Aeson..:? "Limits"
            <*> o Data.Aeson..:? "Reservations"

data TaskSpecRestartPolicy = TaskSpecRestartPolicy
    {
        condition :: (Data.Maybe.Maybe (TaskSpecRestartPolicyCondition)),
        delay :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        maxAttempts :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        window :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpecRestartPolicy where
    toJSON TaskSpecRestartPolicy {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Condition" Data.Aeson..= condition | Just condition <- [condition] ]
        ++ [ "Delay" Data.Aeson..= delay | Just delay <- [delay] ]
        ++ [ "MaxAttempts" Data.Aeson..= maxAttempts | Just maxAttempts <- [maxAttempts] ]
        ++ [ "Window" Data.Aeson..= window | Just window <- [window] ])

    toEncoding TaskSpecRestartPolicy {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Condition" . Data.Aeson.toEncoding) condition <>
          maybe mempty (Data.Aeson.Encoding.pair "Delay" . Data.Aeson.toEncoding) delay <>
          maybe mempty (Data.Aeson.Encoding.pair "MaxAttempts" . Data.Aeson.toEncoding) maxAttempts <>
          maybe mempty (Data.Aeson.Encoding.pair "Window" . Data.Aeson.toEncoding) window
        )

instance Data.Aeson.FromJSON TaskSpecRestartPolicy where
    parseJSON = Data.Aeson.withObject "TaskSpecRestartPolicy" $ \o ->
        TaskSpecRestartPolicy
            <$> o Data.Aeson..:? "Condition"
            <*> o Data.Aeson..:? "Delay"
            <*> o Data.Aeson..:? "MaxAttempts"
            <*> o Data.Aeson..:? "Window"

data TaskSpecRestartPolicyCondition
    = TaskSpecRestartPolicyConditionNone
    | TaskSpecRestartPolicyConditionOnFailure
    | TaskSpecRestartPolicyConditionAny
    deriving (Eq, Show)

instance Data.Aeson.ToJSON TaskSpecRestartPolicyCondition where
    toJSON x = case x of
        TaskSpecRestartPolicyConditionNone -> "none"
        TaskSpecRestartPolicyConditionOnFailure -> "on-failure"
        TaskSpecRestartPolicyConditionAny -> "any"

    toEncoding x = case x of
        TaskSpecRestartPolicyConditionNone -> Data.Aeson.Encoding.text "none"
        TaskSpecRestartPolicyConditionOnFailure -> Data.Aeson.Encoding.text "on-failure"
        TaskSpecRestartPolicyConditionAny -> Data.Aeson.Encoding.text "any"

instance Data.Aeson.FromJSON TaskSpecRestartPolicyCondition where
    parseJSON = Data.Aeson.withText "TaskSpecRestartPolicyCondition" $ \s ->
        case s of
            "none" -> pure TaskSpecRestartPolicyConditionNone
            "on-failure" -> pure TaskSpecRestartPolicyConditionOnFailure
            "any" -> pure TaskSpecRestartPolicyConditionAny
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData TaskSpecRestartPolicyCondition where
    toQueryParam x = case x of
        TaskSpecRestartPolicyConditionNone -> "none"
        TaskSpecRestartPolicyConditionOnFailure -> "on-failure"
        TaskSpecRestartPolicyConditionAny -> "any"

instance Web.HttpApiData.FromHttpApiData TaskSpecRestartPolicyCondition where
    parseUrlPiece x =
        case x of
            "none" -> pure TaskSpecRestartPolicyConditionNone
            "on-failure" -> pure TaskSpecRestartPolicyConditionOnFailure
            "any" -> pure TaskSpecRestartPolicyConditionAny
            _ -> Left "invalid enum value"

data TaskSpec = TaskSpec
    {
        containerSpec :: (Data.Maybe.Maybe (TaskSpecContainerSpec)),
        forceUpdate :: (Data.Maybe.Maybe (GHC.Int.Int)),
        logDriver :: (Data.Maybe.Maybe (TaskSpecLogDriver)),
        networkAttachmentSpec :: (Data.Maybe.Maybe (TaskSpecNetworkAttachmentSpec)),
        networks :: (Data.Maybe.Maybe ([ NetworkAttachmentConfig ])),
        placement :: (Data.Maybe.Maybe (TaskSpecPlacement)),
        pluginSpec :: (Data.Maybe.Maybe (TaskSpecPluginSpec)),
        resources :: (Data.Maybe.Maybe (TaskSpecResources)),
        restartPolicy :: (Data.Maybe.Maybe (TaskSpecRestartPolicy)),
        runtime :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskSpec where
    toJSON TaskSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ContainerSpec" Data.Aeson..= containerSpec | Just containerSpec <- [containerSpec] ]
        ++ [ "ForceUpdate" Data.Aeson..= forceUpdate | Just forceUpdate <- [forceUpdate] ]
        ++ [ "LogDriver" Data.Aeson..= logDriver | Just logDriver <- [logDriver] ]
        ++ [ "NetworkAttachmentSpec" Data.Aeson..= networkAttachmentSpec | Just networkAttachmentSpec <- [networkAttachmentSpec] ]
        ++ [ "Networks" Data.Aeson..= networks | Just networks <- [networks] ]
        ++ [ "Placement" Data.Aeson..= placement | Just placement <- [placement] ]
        ++ [ "PluginSpec" Data.Aeson..= pluginSpec | Just pluginSpec <- [pluginSpec] ]
        ++ [ "Resources" Data.Aeson..= resources | Just resources <- [resources] ]
        ++ [ "RestartPolicy" Data.Aeson..= restartPolicy | Just restartPolicy <- [restartPolicy] ]
        ++ [ "Runtime" Data.Aeson..= runtime | Just runtime <- [runtime] ])

    toEncoding TaskSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ContainerSpec" . Data.Aeson.toEncoding) containerSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "ForceUpdate" . Data.Aeson.toEncoding) forceUpdate <>
          maybe mempty (Data.Aeson.Encoding.pair "LogDriver" . Data.Aeson.toEncoding) logDriver <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkAttachmentSpec" . Data.Aeson.toEncoding) networkAttachmentSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "Networks" . Data.Aeson.toEncoding) networks <>
          maybe mempty (Data.Aeson.Encoding.pair "Placement" . Data.Aeson.toEncoding) placement <>
          maybe mempty (Data.Aeson.Encoding.pair "PluginSpec" . Data.Aeson.toEncoding) pluginSpec <>
          maybe mempty (Data.Aeson.Encoding.pair "Resources" . Data.Aeson.toEncoding) resources <>
          maybe mempty (Data.Aeson.Encoding.pair "RestartPolicy" . Data.Aeson.toEncoding) restartPolicy <>
          maybe mempty (Data.Aeson.Encoding.pair "Runtime" . Data.Aeson.toEncoding) runtime
        )

instance Data.Aeson.FromJSON TaskSpec where
    parseJSON = Data.Aeson.withObject "TaskSpec" $ \o ->
        TaskSpec
            <$> o Data.Aeson..:? "ContainerSpec"
            <*> o Data.Aeson..:? "ForceUpdate"
            <*> o Data.Aeson..:? "LogDriver"
            <*> o Data.Aeson..:? "NetworkAttachmentSpec"
            <*> o Data.Aeson..:? "Networks"
            <*> o Data.Aeson..:? "Placement"
            <*> o Data.Aeson..:? "PluginSpec"
            <*> o Data.Aeson..:? "Resources"
            <*> o Data.Aeson..:? "RestartPolicy"
            <*> o Data.Aeson..:? "Runtime"