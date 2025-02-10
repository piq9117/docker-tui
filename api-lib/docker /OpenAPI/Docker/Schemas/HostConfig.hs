{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.HostConfig where

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



import OpenAPI.Docker.Schemas.DeviceMapping
import OpenAPI.Docker.Schemas.DeviceRequest
import OpenAPI.Docker.Schemas.Mount
import OpenAPI.Docker.Schemas.PortMap
import OpenAPI.Docker.Schemas.Resources
import OpenAPI.Docker.Schemas.RestartPolicy
import OpenAPI.Docker.Schemas.ThrottleDevice

newtype HostConfigAnnotations = HostConfigAnnotations
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON HostConfigAnnotations where
    toJSON (HostConfigAnnotations x) =
        Data.Aeson.toJSON x

    toEncoding (HostConfigAnnotations x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON HostConfigAnnotations where
    parseJSON x =
        HostConfigAnnotations <$> Data.Aeson.parseJSON x

data HostConfigBlkioWeightDevice = HostConfigBlkioWeightDevice
    {
        path :: (Data.Maybe.Maybe (Data.Text.Text)),
        weight :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON HostConfigBlkioWeightDevice where
    toJSON HostConfigBlkioWeightDevice {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Path" Data.Aeson..= path | Just path <- [path] ]
        ++ [ "Weight" Data.Aeson..= weight | Just weight <- [weight] ])

    toEncoding HostConfigBlkioWeightDevice {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Path" . Data.Aeson.toEncoding) path <>
          maybe mempty (Data.Aeson.Encoding.pair "Weight" . Data.Aeson.toEncoding) weight
        )

instance Data.Aeson.FromJSON HostConfigBlkioWeightDevice where
    parseJSON = Data.Aeson.withObject "HostConfigBlkioWeightDevice" $ \o ->
        HostConfigBlkioWeightDevice
            <$> o Data.Aeson..:? "Path"
            <*> o Data.Aeson..:? "Weight"

data HostConfigCgroupnsMode
    = HostConfigCgroupnsModePrivate
    | HostConfigCgroupnsModeHost
    deriving (Eq, Show)

instance Data.Aeson.ToJSON HostConfigCgroupnsMode where
    toJSON x = case x of
        HostConfigCgroupnsModePrivate -> "private"
        HostConfigCgroupnsModeHost -> "host"

    toEncoding x = case x of
        HostConfigCgroupnsModePrivate -> Data.Aeson.Encoding.text "private"
        HostConfigCgroupnsModeHost -> Data.Aeson.Encoding.text "host"

instance Data.Aeson.FromJSON HostConfigCgroupnsMode where
    parseJSON = Data.Aeson.withText "HostConfigCgroupnsMode" $ \s ->
        case s of
            "private" -> pure HostConfigCgroupnsModePrivate
            "host" -> pure HostConfigCgroupnsModeHost
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData HostConfigCgroupnsMode where
    toQueryParam x = case x of
        HostConfigCgroupnsModePrivate -> "private"
        HostConfigCgroupnsModeHost -> "host"

instance Web.HttpApiData.FromHttpApiData HostConfigCgroupnsMode where
    parseUrlPiece x =
        case x of
            "private" -> pure HostConfigCgroupnsModePrivate
            "host" -> pure HostConfigCgroupnsModeHost
            _ -> Left "invalid enum value"

data HostConfigIsolation
    = HostConfigIsolationDefault
    | HostConfigIsolationProcess
    | HostConfigIsolationHyperv
    | HostConfigIsolation
    deriving (Eq, Show)

instance Data.Aeson.ToJSON HostConfigIsolation where
    toJSON x = case x of
        HostConfigIsolationDefault -> "default"
        HostConfigIsolationProcess -> "process"
        HostConfigIsolationHyperv -> "hyperv"
        HostConfigIsolation -> ""

    toEncoding x = case x of
        HostConfigIsolationDefault -> Data.Aeson.Encoding.text "default"
        HostConfigIsolationProcess -> Data.Aeson.Encoding.text "process"
        HostConfigIsolationHyperv -> Data.Aeson.Encoding.text "hyperv"
        HostConfigIsolation -> Data.Aeson.Encoding.text ""

instance Data.Aeson.FromJSON HostConfigIsolation where
    parseJSON = Data.Aeson.withText "HostConfigIsolation" $ \s ->
        case s of
            "default" -> pure HostConfigIsolationDefault
            "process" -> pure HostConfigIsolationProcess
            "hyperv" -> pure HostConfigIsolationHyperv
            "" -> pure HostConfigIsolation
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData HostConfigIsolation where
    toQueryParam x = case x of
        HostConfigIsolationDefault -> "default"
        HostConfigIsolationProcess -> "process"
        HostConfigIsolationHyperv -> "hyperv"
        HostConfigIsolation -> ""

instance Web.HttpApiData.FromHttpApiData HostConfigIsolation where
    parseUrlPiece x =
        case x of
            "default" -> pure HostConfigIsolationDefault
            "process" -> pure HostConfigIsolationProcess
            "hyperv" -> pure HostConfigIsolationHyperv
            "" -> pure HostConfigIsolation
            _ -> Left "invalid enum value"

data HostConfigLogConfig = HostConfigLogConfig
    {
        config :: (Data.Maybe.Maybe (HostConfigLogConfigConfig)),
        type' :: (Data.Maybe.Maybe (HostConfigLogConfigType))
    }
    deriving (Show)

instance Data.Aeson.ToJSON HostConfigLogConfig where
    toJSON HostConfigLogConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Config" Data.Aeson..= config | Just config <- [config] ]
        ++ [ "Type" Data.Aeson..= type' | Just type' <- [type'] ])

    toEncoding HostConfigLogConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Config" . Data.Aeson.toEncoding) config <>
          maybe mempty (Data.Aeson.Encoding.pair "Type" . Data.Aeson.toEncoding) type'
        )

instance Data.Aeson.FromJSON HostConfigLogConfig where
    parseJSON = Data.Aeson.withObject "HostConfigLogConfig" $ \o ->
        HostConfigLogConfig
            <$> o Data.Aeson..:? "Config"
            <*> o Data.Aeson..:? "Type"

newtype HostConfigLogConfigConfig = HostConfigLogConfigConfig
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON HostConfigLogConfigConfig where
    toJSON (HostConfigLogConfigConfig x) =
        Data.Aeson.toJSON x

    toEncoding (HostConfigLogConfigConfig x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON HostConfigLogConfigConfig where
    parseJSON x =
        HostConfigLogConfigConfig <$> Data.Aeson.parseJSON x

data HostConfigLogConfigType
    = HostConfigLogConfigTypeJsonFile
    | HostConfigLogConfigTypeSyslog
    | HostConfigLogConfigTypeJournald
    | HostConfigLogConfigTypeGelf
    | HostConfigLogConfigTypeFluentd
    | HostConfigLogConfigTypeAwslogs
    | HostConfigLogConfigTypeSplunk
    | HostConfigLogConfigTypeEtwlogs
    | HostConfigLogConfigTypeNone
    deriving (Eq, Show)

instance Data.Aeson.ToJSON HostConfigLogConfigType where
    toJSON x = case x of
        HostConfigLogConfigTypeJsonFile -> "json-file"
        HostConfigLogConfigTypeSyslog -> "syslog"
        HostConfigLogConfigTypeJournald -> "journald"
        HostConfigLogConfigTypeGelf -> "gelf"
        HostConfigLogConfigTypeFluentd -> "fluentd"
        HostConfigLogConfigTypeAwslogs -> "awslogs"
        HostConfigLogConfigTypeSplunk -> "splunk"
        HostConfigLogConfigTypeEtwlogs -> "etwlogs"
        HostConfigLogConfigTypeNone -> "none"

    toEncoding x = case x of
        HostConfigLogConfigTypeJsonFile -> Data.Aeson.Encoding.text "json-file"
        HostConfigLogConfigTypeSyslog -> Data.Aeson.Encoding.text "syslog"
        HostConfigLogConfigTypeJournald -> Data.Aeson.Encoding.text "journald"
        HostConfigLogConfigTypeGelf -> Data.Aeson.Encoding.text "gelf"
        HostConfigLogConfigTypeFluentd -> Data.Aeson.Encoding.text "fluentd"
        HostConfigLogConfigTypeAwslogs -> Data.Aeson.Encoding.text "awslogs"
        HostConfigLogConfigTypeSplunk -> Data.Aeson.Encoding.text "splunk"
        HostConfigLogConfigTypeEtwlogs -> Data.Aeson.Encoding.text "etwlogs"
        HostConfigLogConfigTypeNone -> Data.Aeson.Encoding.text "none"

instance Data.Aeson.FromJSON HostConfigLogConfigType where
    parseJSON = Data.Aeson.withText "HostConfigLogConfigType" $ \s ->
        case s of
            "json-file" -> pure HostConfigLogConfigTypeJsonFile
            "syslog" -> pure HostConfigLogConfigTypeSyslog
            "journald" -> pure HostConfigLogConfigTypeJournald
            "gelf" -> pure HostConfigLogConfigTypeGelf
            "fluentd" -> pure HostConfigLogConfigTypeFluentd
            "awslogs" -> pure HostConfigLogConfigTypeAwslogs
            "splunk" -> pure HostConfigLogConfigTypeSplunk
            "etwlogs" -> pure HostConfigLogConfigTypeEtwlogs
            "none" -> pure HostConfigLogConfigTypeNone
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData HostConfigLogConfigType where
    toQueryParam x = case x of
        HostConfigLogConfigTypeJsonFile -> "json-file"
        HostConfigLogConfigTypeSyslog -> "syslog"
        HostConfigLogConfigTypeJournald -> "journald"
        HostConfigLogConfigTypeGelf -> "gelf"
        HostConfigLogConfigTypeFluentd -> "fluentd"
        HostConfigLogConfigTypeAwslogs -> "awslogs"
        HostConfigLogConfigTypeSplunk -> "splunk"
        HostConfigLogConfigTypeEtwlogs -> "etwlogs"
        HostConfigLogConfigTypeNone -> "none"

instance Web.HttpApiData.FromHttpApiData HostConfigLogConfigType where
    parseUrlPiece x =
        case x of
            "json-file" -> pure HostConfigLogConfigTypeJsonFile
            "syslog" -> pure HostConfigLogConfigTypeSyslog
            "journald" -> pure HostConfigLogConfigTypeJournald
            "gelf" -> pure HostConfigLogConfigTypeGelf
            "fluentd" -> pure HostConfigLogConfigTypeFluentd
            "awslogs" -> pure HostConfigLogConfigTypeAwslogs
            "splunk" -> pure HostConfigLogConfigTypeSplunk
            "etwlogs" -> pure HostConfigLogConfigTypeEtwlogs
            "none" -> pure HostConfigLogConfigTypeNone
            _ -> Left "invalid enum value"

newtype HostConfigStorageOpt = HostConfigStorageOpt
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON HostConfigStorageOpt where
    toJSON (HostConfigStorageOpt x) =
        Data.Aeson.toJSON x

    toEncoding (HostConfigStorageOpt x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON HostConfigStorageOpt where
    parseJSON x =
        HostConfigStorageOpt <$> Data.Aeson.parseJSON x

newtype HostConfigSysctls = HostConfigSysctls
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON HostConfigSysctls where
    toJSON (HostConfigSysctls x) =
        Data.Aeson.toJSON x

    toEncoding (HostConfigSysctls x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON HostConfigSysctls where
    parseJSON x =
        HostConfigSysctls <$> Data.Aeson.parseJSON x

newtype HostConfigTmpfs = HostConfigTmpfs
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON HostConfigTmpfs where
    toJSON (HostConfigTmpfs x) =
        Data.Aeson.toJSON x

    toEncoding (HostConfigTmpfs x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON HostConfigTmpfs where
    parseJSON x =
        HostConfigTmpfs <$> Data.Aeson.parseJSON x

data HostConfigUlimits = HostConfigUlimits
    {
        hard :: (Data.Maybe.Maybe (GHC.Int.Int)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        soft :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON HostConfigUlimits where
    toJSON HostConfigUlimits {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Hard" Data.Aeson..= hard | Just hard <- [hard] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Soft" Data.Aeson..= soft | Just soft <- [soft] ])

    toEncoding HostConfigUlimits {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Hard" . Data.Aeson.toEncoding) hard <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Soft" . Data.Aeson.toEncoding) soft
        )

instance Data.Aeson.FromJSON HostConfigUlimits where
    parseJSON = Data.Aeson.withObject "HostConfigUlimits" $ \o ->
        HostConfigUlimits
            <$> o Data.Aeson..:? "Hard"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Soft"

data HostConfig = HostConfig
    {
        annotations :: (Data.Maybe.Maybe (HostConfigAnnotations)),
        autoRemove :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        binds :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        blkioDeviceReadBps :: (Data.Maybe.Maybe ([ ThrottleDevice ])),
        blkioDeviceReadIOps :: (Data.Maybe.Maybe ([ ThrottleDevice ])),
        blkioDeviceWriteBps :: (Data.Maybe.Maybe ([ ThrottleDevice ])),
        blkioDeviceWriteIOps :: (Data.Maybe.Maybe ([ ThrottleDevice ])),
        blkioWeight :: (Data.Maybe.Maybe (GHC.Int.Int)),
        blkioWeightDevice :: (Data.Maybe.Maybe ([ HostConfigBlkioWeightDevice ])),
        capAdd :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        capDrop :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        cgroup :: (Data.Maybe.Maybe (Data.Text.Text)),
        cgroupParent :: (Data.Maybe.Maybe (Data.Text.Text)),
        cgroupnsMode :: (Data.Maybe.Maybe (HostConfigCgroupnsMode)),
        consoleSize :: (Data.Maybe.Maybe ([ GHC.Int.Int ])),
        containerIDFile :: (Data.Maybe.Maybe (Data.Text.Text)),
        cpuCount :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        cpuPercent :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        cpuPeriod :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        cpuQuota :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        cpuRealtimePeriod :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        cpuRealtimeRuntime :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        cpuShares :: (Data.Maybe.Maybe (GHC.Int.Int)),
        cpusetCpus :: (Data.Maybe.Maybe (Data.Text.Text)),
        cpusetMems :: (Data.Maybe.Maybe (Data.Text.Text)),
        deviceCgroupRules :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        deviceRequests :: (Data.Maybe.Maybe ([ DeviceRequest ])),
        devices :: (Data.Maybe.Maybe ([ DeviceMapping ])),
        dns :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        dnsOptions :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        dnsSearch :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        extraHosts :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        groupAdd :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        iOMaximumBandwidth :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        iOMaximumIOps :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        init :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        ipcMode :: (Data.Maybe.Maybe (Data.Text.Text)),
        isolation :: (Data.Maybe.Maybe (HostConfigIsolation)),
        kernelMemoryTCP :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        links :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        logConfig :: (Data.Maybe.Maybe (HostConfigLogConfig)),
        maskedPaths :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        memory :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        memoryReservation :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        memorySwap :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        memorySwappiness :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        mounts :: (Data.Maybe.Maybe ([ Mount ])),
        nanoCpus :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        networkMode :: (Data.Maybe.Maybe (Data.Text.Text)),
        oomKillDisable :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        oomScoreAdj :: (Data.Maybe.Maybe (GHC.Int.Int)),
        pidMode :: (Data.Maybe.Maybe (Data.Text.Text)),
        pidsLimit :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        portBindings :: (Data.Maybe.Maybe (PortMap)),
        privileged :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        publishAllPorts :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        readonlyPaths :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        readonlyRootfs :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        restartPolicy :: (Data.Maybe.Maybe (RestartPolicy)),
        runtime :: (Data.Maybe.Maybe (Data.Text.Text)),
        securityOpt :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        shmSize :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        storageOpt :: (Data.Maybe.Maybe (HostConfigStorageOpt)),
        sysctls :: (Data.Maybe.Maybe (HostConfigSysctls)),
        tmpfs :: (Data.Maybe.Maybe (HostConfigTmpfs)),
        uTSMode :: (Data.Maybe.Maybe (Data.Text.Text)),
        ulimits :: (Data.Maybe.Maybe ([ HostConfigUlimits ])),
        usernsMode :: (Data.Maybe.Maybe (Data.Text.Text)),
        volumeDriver :: (Data.Maybe.Maybe (Data.Text.Text)),
        volumesFrom :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON HostConfig where
    toJSON HostConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Annotations" Data.Aeson..= annotations | Just annotations <- [annotations] ]
        ++ [ "AutoRemove" Data.Aeson..= autoRemove | Just autoRemove <- [autoRemove] ]
        ++ [ "Binds" Data.Aeson..= binds | Just binds <- [binds] ]
        ++ [ "BlkioDeviceReadBps" Data.Aeson..= blkioDeviceReadBps | Just blkioDeviceReadBps <- [blkioDeviceReadBps] ]
        ++ [ "BlkioDeviceReadIOps" Data.Aeson..= blkioDeviceReadIOps | Just blkioDeviceReadIOps <- [blkioDeviceReadIOps] ]
        ++ [ "BlkioDeviceWriteBps" Data.Aeson..= blkioDeviceWriteBps | Just blkioDeviceWriteBps <- [blkioDeviceWriteBps] ]
        ++ [ "BlkioDeviceWriteIOps" Data.Aeson..= blkioDeviceWriteIOps | Just blkioDeviceWriteIOps <- [blkioDeviceWriteIOps] ]
        ++ [ "BlkioWeight" Data.Aeson..= blkioWeight | Just blkioWeight <- [blkioWeight] ]
        ++ [ "BlkioWeightDevice" Data.Aeson..= blkioWeightDevice | Just blkioWeightDevice <- [blkioWeightDevice] ]
        ++ [ "CapAdd" Data.Aeson..= capAdd | Just capAdd <- [capAdd] ]
        ++ [ "CapDrop" Data.Aeson..= capDrop | Just capDrop <- [capDrop] ]
        ++ [ "Cgroup" Data.Aeson..= cgroup | Just cgroup <- [cgroup] ]
        ++ [ "CgroupParent" Data.Aeson..= cgroupParent | Just cgroupParent <- [cgroupParent] ]
        ++ [ "CgroupnsMode" Data.Aeson..= cgroupnsMode | Just cgroupnsMode <- [cgroupnsMode] ]
        ++ [ "ConsoleSize" Data.Aeson..= consoleSize | Just consoleSize <- [consoleSize] ]
        ++ [ "ContainerIDFile" Data.Aeson..= containerIDFile | Just containerIDFile <- [containerIDFile] ]
        ++ [ "CpuCount" Data.Aeson..= cpuCount | Just cpuCount <- [cpuCount] ]
        ++ [ "CpuPercent" Data.Aeson..= cpuPercent | Just cpuPercent <- [cpuPercent] ]
        ++ [ "CpuPeriod" Data.Aeson..= cpuPeriod | Just cpuPeriod <- [cpuPeriod] ]
        ++ [ "CpuQuota" Data.Aeson..= cpuQuota | Just cpuQuota <- [cpuQuota] ]
        ++ [ "CpuRealtimePeriod" Data.Aeson..= cpuRealtimePeriod | Just cpuRealtimePeriod <- [cpuRealtimePeriod] ]
        ++ [ "CpuRealtimeRuntime" Data.Aeson..= cpuRealtimeRuntime | Just cpuRealtimeRuntime <- [cpuRealtimeRuntime] ]
        ++ [ "CpuShares" Data.Aeson..= cpuShares | Just cpuShares <- [cpuShares] ]
        ++ [ "CpusetCpus" Data.Aeson..= cpusetCpus | Just cpusetCpus <- [cpusetCpus] ]
        ++ [ "CpusetMems" Data.Aeson..= cpusetMems | Just cpusetMems <- [cpusetMems] ]
        ++ [ "DeviceCgroupRules" Data.Aeson..= deviceCgroupRules | Just deviceCgroupRules <- [deviceCgroupRules] ]
        ++ [ "DeviceRequests" Data.Aeson..= deviceRequests | Just deviceRequests <- [deviceRequests] ]
        ++ [ "Devices" Data.Aeson..= devices | Just devices <- [devices] ]
        ++ [ "Dns" Data.Aeson..= dns | Just dns <- [dns] ]
        ++ [ "DnsOptions" Data.Aeson..= dnsOptions | Just dnsOptions <- [dnsOptions] ]
        ++ [ "DnsSearch" Data.Aeson..= dnsSearch | Just dnsSearch <- [dnsSearch] ]
        ++ [ "ExtraHosts" Data.Aeson..= extraHosts | Just extraHosts <- [extraHosts] ]
        ++ [ "GroupAdd" Data.Aeson..= groupAdd | Just groupAdd <- [groupAdd] ]
        ++ [ "IOMaximumBandwidth" Data.Aeson..= iOMaximumBandwidth | Just iOMaximumBandwidth <- [iOMaximumBandwidth] ]
        ++ [ "IOMaximumIOps" Data.Aeson..= iOMaximumIOps | Just iOMaximumIOps <- [iOMaximumIOps] ]
        ++ [ "Init" Data.Aeson..= init | Just init <- [init] ]
        ++ [ "IpcMode" Data.Aeson..= ipcMode | Just ipcMode <- [ipcMode] ]
        ++ [ "Isolation" Data.Aeson..= isolation | Just isolation <- [isolation] ]
        ++ [ "KernelMemoryTCP" Data.Aeson..= kernelMemoryTCP | Just kernelMemoryTCP <- [kernelMemoryTCP] ]
        ++ [ "Links" Data.Aeson..= links | Just links <- [links] ]
        ++ [ "LogConfig" Data.Aeson..= logConfig | Just logConfig <- [logConfig] ]
        ++ [ "MaskedPaths" Data.Aeson..= maskedPaths | Just maskedPaths <- [maskedPaths] ]
        ++ [ "Memory" Data.Aeson..= memory | Just memory <- [memory] ]
        ++ [ "MemoryReservation" Data.Aeson..= memoryReservation | Just memoryReservation <- [memoryReservation] ]
        ++ [ "MemorySwap" Data.Aeson..= memorySwap | Just memorySwap <- [memorySwap] ]
        ++ [ "MemorySwappiness" Data.Aeson..= memorySwappiness | Just memorySwappiness <- [memorySwappiness] ]
        ++ [ "Mounts" Data.Aeson..= mounts | Just mounts <- [mounts] ]
        ++ [ "NanoCpus" Data.Aeson..= nanoCpus | Just nanoCpus <- [nanoCpus] ]
        ++ [ "NetworkMode" Data.Aeson..= networkMode | Just networkMode <- [networkMode] ]
        ++ [ "OomKillDisable" Data.Aeson..= oomKillDisable | Just oomKillDisable <- [oomKillDisable] ]
        ++ [ "OomScoreAdj" Data.Aeson..= oomScoreAdj | Just oomScoreAdj <- [oomScoreAdj] ]
        ++ [ "PidMode" Data.Aeson..= pidMode | Just pidMode <- [pidMode] ]
        ++ [ "PidsLimit" Data.Aeson..= pidsLimit | Just pidsLimit <- [pidsLimit] ]
        ++ [ "PortBindings" Data.Aeson..= portBindings | Just portBindings <- [portBindings] ]
        ++ [ "Privileged" Data.Aeson..= privileged | Just privileged <- [privileged] ]
        ++ [ "PublishAllPorts" Data.Aeson..= publishAllPorts | Just publishAllPorts <- [publishAllPorts] ]
        ++ [ "ReadonlyPaths" Data.Aeson..= readonlyPaths | Just readonlyPaths <- [readonlyPaths] ]
        ++ [ "ReadonlyRootfs" Data.Aeson..= readonlyRootfs | Just readonlyRootfs <- [readonlyRootfs] ]
        ++ [ "RestartPolicy" Data.Aeson..= restartPolicy | Just restartPolicy <- [restartPolicy] ]
        ++ [ "Runtime" Data.Aeson..= runtime | Just runtime <- [runtime] ]
        ++ [ "SecurityOpt" Data.Aeson..= securityOpt | Just securityOpt <- [securityOpt] ]
        ++ [ "ShmSize" Data.Aeson..= shmSize | Just shmSize <- [shmSize] ]
        ++ [ "StorageOpt" Data.Aeson..= storageOpt | Just storageOpt <- [storageOpt] ]
        ++ [ "Sysctls" Data.Aeson..= sysctls | Just sysctls <- [sysctls] ]
        ++ [ "Tmpfs" Data.Aeson..= tmpfs | Just tmpfs <- [tmpfs] ]
        ++ [ "UTSMode" Data.Aeson..= uTSMode | Just uTSMode <- [uTSMode] ]
        ++ [ "Ulimits" Data.Aeson..= ulimits | Just ulimits <- [ulimits] ]
        ++ [ "UsernsMode" Data.Aeson..= usernsMode | Just usernsMode <- [usernsMode] ]
        ++ [ "VolumeDriver" Data.Aeson..= volumeDriver | Just volumeDriver <- [volumeDriver] ]
        ++ [ "VolumesFrom" Data.Aeson..= volumesFrom | Just volumesFrom <- [volumesFrom] ])

    toEncoding HostConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Annotations" . Data.Aeson.toEncoding) annotations <>
          maybe mempty (Data.Aeson.Encoding.pair "AutoRemove" . Data.Aeson.toEncoding) autoRemove <>
          maybe mempty (Data.Aeson.Encoding.pair "Binds" . Data.Aeson.toEncoding) binds <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioDeviceReadBps" . Data.Aeson.toEncoding) blkioDeviceReadBps <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioDeviceReadIOps" . Data.Aeson.toEncoding) blkioDeviceReadIOps <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioDeviceWriteBps" . Data.Aeson.toEncoding) blkioDeviceWriteBps <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioDeviceWriteIOps" . Data.Aeson.toEncoding) blkioDeviceWriteIOps <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioWeight" . Data.Aeson.toEncoding) blkioWeight <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioWeightDevice" . Data.Aeson.toEncoding) blkioWeightDevice <>
          maybe mempty (Data.Aeson.Encoding.pair "CapAdd" . Data.Aeson.toEncoding) capAdd <>
          maybe mempty (Data.Aeson.Encoding.pair "CapDrop" . Data.Aeson.toEncoding) capDrop <>
          maybe mempty (Data.Aeson.Encoding.pair "Cgroup" . Data.Aeson.toEncoding) cgroup <>
          maybe mempty (Data.Aeson.Encoding.pair "CgroupParent" . Data.Aeson.toEncoding) cgroupParent <>
          maybe mempty (Data.Aeson.Encoding.pair "CgroupnsMode" . Data.Aeson.toEncoding) cgroupnsMode <>
          maybe mempty (Data.Aeson.Encoding.pair "ConsoleSize" . Data.Aeson.toEncoding) consoleSize <>
          maybe mempty (Data.Aeson.Encoding.pair "ContainerIDFile" . Data.Aeson.toEncoding) containerIDFile <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuCount" . Data.Aeson.toEncoding) cpuCount <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuPercent" . Data.Aeson.toEncoding) cpuPercent <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuPeriod" . Data.Aeson.toEncoding) cpuPeriod <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuQuota" . Data.Aeson.toEncoding) cpuQuota <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuRealtimePeriod" . Data.Aeson.toEncoding) cpuRealtimePeriod <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuRealtimeRuntime" . Data.Aeson.toEncoding) cpuRealtimeRuntime <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuShares" . Data.Aeson.toEncoding) cpuShares <>
          maybe mempty (Data.Aeson.Encoding.pair "CpusetCpus" . Data.Aeson.toEncoding) cpusetCpus <>
          maybe mempty (Data.Aeson.Encoding.pair "CpusetMems" . Data.Aeson.toEncoding) cpusetMems <>
          maybe mempty (Data.Aeson.Encoding.pair "DeviceCgroupRules" . Data.Aeson.toEncoding) deviceCgroupRules <>
          maybe mempty (Data.Aeson.Encoding.pair "DeviceRequests" . Data.Aeson.toEncoding) deviceRequests <>
          maybe mempty (Data.Aeson.Encoding.pair "Devices" . Data.Aeson.toEncoding) devices <>
          maybe mempty (Data.Aeson.Encoding.pair "Dns" . Data.Aeson.toEncoding) dns <>
          maybe mempty (Data.Aeson.Encoding.pair "DnsOptions" . Data.Aeson.toEncoding) dnsOptions <>
          maybe mempty (Data.Aeson.Encoding.pair "DnsSearch" . Data.Aeson.toEncoding) dnsSearch <>
          maybe mempty (Data.Aeson.Encoding.pair "ExtraHosts" . Data.Aeson.toEncoding) extraHosts <>
          maybe mempty (Data.Aeson.Encoding.pair "GroupAdd" . Data.Aeson.toEncoding) groupAdd <>
          maybe mempty (Data.Aeson.Encoding.pair "IOMaximumBandwidth" . Data.Aeson.toEncoding) iOMaximumBandwidth <>
          maybe mempty (Data.Aeson.Encoding.pair "IOMaximumIOps" . Data.Aeson.toEncoding) iOMaximumIOps <>
          maybe mempty (Data.Aeson.Encoding.pair "Init" . Data.Aeson.toEncoding) init <>
          maybe mempty (Data.Aeson.Encoding.pair "IpcMode" . Data.Aeson.toEncoding) ipcMode <>
          maybe mempty (Data.Aeson.Encoding.pair "Isolation" . Data.Aeson.toEncoding) isolation <>
          maybe mempty (Data.Aeson.Encoding.pair "KernelMemoryTCP" . Data.Aeson.toEncoding) kernelMemoryTCP <>
          maybe mempty (Data.Aeson.Encoding.pair "Links" . Data.Aeson.toEncoding) links <>
          maybe mempty (Data.Aeson.Encoding.pair "LogConfig" . Data.Aeson.toEncoding) logConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "MaskedPaths" . Data.Aeson.toEncoding) maskedPaths <>
          maybe mempty (Data.Aeson.Encoding.pair "Memory" . Data.Aeson.toEncoding) memory <>
          maybe mempty (Data.Aeson.Encoding.pair "MemoryReservation" . Data.Aeson.toEncoding) memoryReservation <>
          maybe mempty (Data.Aeson.Encoding.pair "MemorySwap" . Data.Aeson.toEncoding) memorySwap <>
          maybe mempty (Data.Aeson.Encoding.pair "MemorySwappiness" . Data.Aeson.toEncoding) memorySwappiness <>
          maybe mempty (Data.Aeson.Encoding.pair "Mounts" . Data.Aeson.toEncoding) mounts <>
          maybe mempty (Data.Aeson.Encoding.pair "NanoCpus" . Data.Aeson.toEncoding) nanoCpus <>
          maybe mempty (Data.Aeson.Encoding.pair "NetworkMode" . Data.Aeson.toEncoding) networkMode <>
          maybe mempty (Data.Aeson.Encoding.pair "OomKillDisable" . Data.Aeson.toEncoding) oomKillDisable <>
          maybe mempty (Data.Aeson.Encoding.pair "OomScoreAdj" . Data.Aeson.toEncoding) oomScoreAdj <>
          maybe mempty (Data.Aeson.Encoding.pair "PidMode" . Data.Aeson.toEncoding) pidMode <>
          maybe mempty (Data.Aeson.Encoding.pair "PidsLimit" . Data.Aeson.toEncoding) pidsLimit <>
          maybe mempty (Data.Aeson.Encoding.pair "PortBindings" . Data.Aeson.toEncoding) portBindings <>
          maybe mempty (Data.Aeson.Encoding.pair "Privileged" . Data.Aeson.toEncoding) privileged <>
          maybe mempty (Data.Aeson.Encoding.pair "PublishAllPorts" . Data.Aeson.toEncoding) publishAllPorts <>
          maybe mempty (Data.Aeson.Encoding.pair "ReadonlyPaths" . Data.Aeson.toEncoding) readonlyPaths <>
          maybe mempty (Data.Aeson.Encoding.pair "ReadonlyRootfs" . Data.Aeson.toEncoding) readonlyRootfs <>
          maybe mempty (Data.Aeson.Encoding.pair "RestartPolicy" . Data.Aeson.toEncoding) restartPolicy <>
          maybe mempty (Data.Aeson.Encoding.pair "Runtime" . Data.Aeson.toEncoding) runtime <>
          maybe mempty (Data.Aeson.Encoding.pair "SecurityOpt" . Data.Aeson.toEncoding) securityOpt <>
          maybe mempty (Data.Aeson.Encoding.pair "ShmSize" . Data.Aeson.toEncoding) shmSize <>
          maybe mempty (Data.Aeson.Encoding.pair "StorageOpt" . Data.Aeson.toEncoding) storageOpt <>
          maybe mempty (Data.Aeson.Encoding.pair "Sysctls" . Data.Aeson.toEncoding) sysctls <>
          maybe mempty (Data.Aeson.Encoding.pair "Tmpfs" . Data.Aeson.toEncoding) tmpfs <>
          maybe mempty (Data.Aeson.Encoding.pair "UTSMode" . Data.Aeson.toEncoding) uTSMode <>
          maybe mempty (Data.Aeson.Encoding.pair "Ulimits" . Data.Aeson.toEncoding) ulimits <>
          maybe mempty (Data.Aeson.Encoding.pair "UsernsMode" . Data.Aeson.toEncoding) usernsMode <>
          maybe mempty (Data.Aeson.Encoding.pair "VolumeDriver" . Data.Aeson.toEncoding) volumeDriver <>
          maybe mempty (Data.Aeson.Encoding.pair "VolumesFrom" . Data.Aeson.toEncoding) volumesFrom
        )

instance Data.Aeson.FromJSON HostConfig where
    parseJSON = Data.Aeson.withObject "HostConfig" $ \o ->
        HostConfig
            <$> o Data.Aeson..:? "Annotations"
            <*> o Data.Aeson..:? "AutoRemove"
            <*> o Data.Aeson..:? "Binds"
            <*> o Data.Aeson..:? "BlkioDeviceReadBps"
            <*> o Data.Aeson..:? "BlkioDeviceReadIOps"
            <*> o Data.Aeson..:? "BlkioDeviceWriteBps"
            <*> o Data.Aeson..:? "BlkioDeviceWriteIOps"
            <*> o Data.Aeson..:? "BlkioWeight"
            <*> o Data.Aeson..:? "BlkioWeightDevice"
            <*> o Data.Aeson..:? "CapAdd"
            <*> o Data.Aeson..:? "CapDrop"
            <*> o Data.Aeson..:? "Cgroup"
            <*> o Data.Aeson..:? "CgroupParent"
            <*> o Data.Aeson..:? "CgroupnsMode"
            <*> o Data.Aeson..:? "ConsoleSize"
            <*> o Data.Aeson..:? "ContainerIDFile"
            <*> o Data.Aeson..:? "CpuCount"
            <*> o Data.Aeson..:? "CpuPercent"
            <*> o Data.Aeson..:? "CpuPeriod"
            <*> o Data.Aeson..:? "CpuQuota"
            <*> o Data.Aeson..:? "CpuRealtimePeriod"
            <*> o Data.Aeson..:? "CpuRealtimeRuntime"
            <*> o Data.Aeson..:? "CpuShares"
            <*> o Data.Aeson..:? "CpusetCpus"
            <*> o Data.Aeson..:? "CpusetMems"
            <*> o Data.Aeson..:? "DeviceCgroupRules"
            <*> o Data.Aeson..:? "DeviceRequests"
            <*> o Data.Aeson..:? "Devices"
            <*> o Data.Aeson..:? "Dns"
            <*> o Data.Aeson..:? "DnsOptions"
            <*> o Data.Aeson..:? "DnsSearch"
            <*> o Data.Aeson..:? "ExtraHosts"
            <*> o Data.Aeson..:? "GroupAdd"
            <*> o Data.Aeson..:? "IOMaximumBandwidth"
            <*> o Data.Aeson..:? "IOMaximumIOps"
            <*> o Data.Aeson..:? "Init"
            <*> o Data.Aeson..:? "IpcMode"
            <*> o Data.Aeson..:? "Isolation"
            <*> o Data.Aeson..:? "KernelMemoryTCP"
            <*> o Data.Aeson..:? "Links"
            <*> o Data.Aeson..:? "LogConfig"
            <*> o Data.Aeson..:? "MaskedPaths"
            <*> o Data.Aeson..:? "Memory"
            <*> o Data.Aeson..:? "MemoryReservation"
            <*> o Data.Aeson..:? "MemorySwap"
            <*> o Data.Aeson..:? "MemorySwappiness"
            <*> o Data.Aeson..:? "Mounts"
            <*> o Data.Aeson..:? "NanoCpus"
            <*> o Data.Aeson..:? "NetworkMode"
            <*> o Data.Aeson..:? "OomKillDisable"
            <*> o Data.Aeson..:? "OomScoreAdj"
            <*> o Data.Aeson..:? "PidMode"
            <*> o Data.Aeson..:? "PidsLimit"
            <*> o Data.Aeson..:? "PortBindings"
            <*> o Data.Aeson..:? "Privileged"
            <*> o Data.Aeson..:? "PublishAllPorts"
            <*> o Data.Aeson..:? "ReadonlyPaths"
            <*> o Data.Aeson..:? "ReadonlyRootfs"
            <*> o Data.Aeson..:? "RestartPolicy"
            <*> o Data.Aeson..:? "Runtime"
            <*> o Data.Aeson..:? "SecurityOpt"
            <*> o Data.Aeson..:? "ShmSize"
            <*> o Data.Aeson..:? "StorageOpt"
            <*> o Data.Aeson..:? "Sysctls"
            <*> o Data.Aeson..:? "Tmpfs"
            <*> o Data.Aeson..:? "UTSMode"
            <*> o Data.Aeson..:? "Ulimits"
            <*> o Data.Aeson..:? "UsernsMode"
            <*> o Data.Aeson..:? "VolumeDriver"
            <*> o Data.Aeson..:? "VolumesFrom"