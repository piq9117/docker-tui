{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.SystemInfo where

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



import OpenAPI.Docker.Schemas.Commit
import OpenAPI.Docker.Schemas.ContainerdInfo
import OpenAPI.Docker.Schemas.GenericResources
import OpenAPI.Docker.Schemas.PluginsInfo
import OpenAPI.Docker.Schemas.RegistryServiceConfig
import OpenAPI.Docker.Schemas.Runtime
import OpenAPI.Docker.Schemas.SwarmInfo

data SystemInfoCgroupDriver
    = SystemInfoCgroupDriverCgroupfs
    | SystemInfoCgroupDriverSystemd
    | SystemInfoCgroupDriverNone
    deriving (Eq, Show)

instance Data.Aeson.ToJSON SystemInfoCgroupDriver where
    toJSON x = case x of
        SystemInfoCgroupDriverCgroupfs -> "cgroupfs"
        SystemInfoCgroupDriverSystemd -> "systemd"
        SystemInfoCgroupDriverNone -> "none"

    toEncoding x = case x of
        SystemInfoCgroupDriverCgroupfs -> Data.Aeson.Encoding.text "cgroupfs"
        SystemInfoCgroupDriverSystemd -> Data.Aeson.Encoding.text "systemd"
        SystemInfoCgroupDriverNone -> Data.Aeson.Encoding.text "none"

instance Data.Aeson.FromJSON SystemInfoCgroupDriver where
    parseJSON = Data.Aeson.withText "SystemInfoCgroupDriver" $ \s ->
        case s of
            "cgroupfs" -> pure SystemInfoCgroupDriverCgroupfs
            "systemd" -> pure SystemInfoCgroupDriverSystemd
            "none" -> pure SystemInfoCgroupDriverNone
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData SystemInfoCgroupDriver where
    toQueryParam x = case x of
        SystemInfoCgroupDriverCgroupfs -> "cgroupfs"
        SystemInfoCgroupDriverSystemd -> "systemd"
        SystemInfoCgroupDriverNone -> "none"

instance Web.HttpApiData.FromHttpApiData SystemInfoCgroupDriver where
    parseUrlPiece x =
        case x of
            "cgroupfs" -> pure SystemInfoCgroupDriverCgroupfs
            "systemd" -> pure SystemInfoCgroupDriverSystemd
            "none" -> pure SystemInfoCgroupDriverNone
            _ -> Left "invalid enum value"

data SystemInfoCgroupVersion
    = SystemInfoCgroupVersion1
    | SystemInfoCgroupVersion2
    deriving (Eq, Show)

instance Data.Aeson.ToJSON SystemInfoCgroupVersion where
    toJSON x = case x of
        SystemInfoCgroupVersion1 -> "1"
        SystemInfoCgroupVersion2 -> "2"

    toEncoding x = case x of
        SystemInfoCgroupVersion1 -> Data.Aeson.Encoding.text "1"
        SystemInfoCgroupVersion2 -> Data.Aeson.Encoding.text "2"

instance Data.Aeson.FromJSON SystemInfoCgroupVersion where
    parseJSON = Data.Aeson.withText "SystemInfoCgroupVersion" $ \s ->
        case s of
            "1" -> pure SystemInfoCgroupVersion1
            "2" -> pure SystemInfoCgroupVersion2
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData SystemInfoCgroupVersion where
    toQueryParam x = case x of
        SystemInfoCgroupVersion1 -> "1"
        SystemInfoCgroupVersion2 -> "2"

instance Web.HttpApiData.FromHttpApiData SystemInfoCgroupVersion where
    parseUrlPiece x =
        case x of
            "1" -> pure SystemInfoCgroupVersion1
            "2" -> pure SystemInfoCgroupVersion2
            _ -> Left "invalid enum value"

data SystemInfoDefaultAddressPools = SystemInfoDefaultAddressPools
    {
        base :: (Data.Maybe.Maybe (Data.Text.Text)),
        size :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemInfoDefaultAddressPools where
    toJSON SystemInfoDefaultAddressPools {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Base" Data.Aeson..= base | Just base <- [base] ]
        ++ [ "Size" Data.Aeson..= size | Just size <- [size] ])

    toEncoding SystemInfoDefaultAddressPools {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Base" . Data.Aeson.toEncoding) base <>
          maybe mempty (Data.Aeson.Encoding.pair "Size" . Data.Aeson.toEncoding) size
        )

instance Data.Aeson.FromJSON SystemInfoDefaultAddressPools where
    parseJSON = Data.Aeson.withObject "SystemInfoDefaultAddressPools" $ \o ->
        SystemInfoDefaultAddressPools
            <$> o Data.Aeson..:? "Base"
            <*> o Data.Aeson..:? "Size"

data SystemInfoIsolation
    = SystemInfoIsolationDefault
    | SystemInfoIsolationHyperv
    | SystemInfoIsolationProcess
    | SystemInfoIsolation
    deriving (Eq, Show)

instance Data.Aeson.ToJSON SystemInfoIsolation where
    toJSON x = case x of
        SystemInfoIsolationDefault -> "default"
        SystemInfoIsolationHyperv -> "hyperv"
        SystemInfoIsolationProcess -> "process"
        SystemInfoIsolation -> ""

    toEncoding x = case x of
        SystemInfoIsolationDefault -> Data.Aeson.Encoding.text "default"
        SystemInfoIsolationHyperv -> Data.Aeson.Encoding.text "hyperv"
        SystemInfoIsolationProcess -> Data.Aeson.Encoding.text "process"
        SystemInfoIsolation -> Data.Aeson.Encoding.text ""

instance Data.Aeson.FromJSON SystemInfoIsolation where
    parseJSON = Data.Aeson.withText "SystemInfoIsolation" $ \s ->
        case s of
            "default" -> pure SystemInfoIsolationDefault
            "hyperv" -> pure SystemInfoIsolationHyperv
            "process" -> pure SystemInfoIsolationProcess
            "" -> pure SystemInfoIsolation
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData SystemInfoIsolation where
    toQueryParam x = case x of
        SystemInfoIsolationDefault -> "default"
        SystemInfoIsolationHyperv -> "hyperv"
        SystemInfoIsolationProcess -> "process"
        SystemInfoIsolation -> ""

instance Web.HttpApiData.FromHttpApiData SystemInfoIsolation where
    parseUrlPiece x =
        case x of
            "default" -> pure SystemInfoIsolationDefault
            "hyperv" -> pure SystemInfoIsolationHyperv
            "process" -> pure SystemInfoIsolationProcess
            "" -> pure SystemInfoIsolation
            _ -> Left "invalid enum value"

newtype SystemInfoRuntimes = SystemInfoRuntimes
    (Data.Map.Map Data.Text.Text (Runtime))
    deriving (Show)

instance Data.Aeson.ToJSON SystemInfoRuntimes where
    toJSON (SystemInfoRuntimes x) =
        Data.Aeson.toJSON x

    toEncoding (SystemInfoRuntimes x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON SystemInfoRuntimes where
    parseJSON x =
        SystemInfoRuntimes <$> Data.Aeson.parseJSON x

data SystemInfo = SystemInfo
    {
        architecture :: (Data.Maybe.Maybe (Data.Text.Text)),
        bridgeNfIp6tables :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        bridgeNfIptables :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        cDISpecDirs :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        cPUSet :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        cPUShares :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        cgroupDriver :: (Data.Maybe.Maybe (SystemInfoCgroupDriver)),
        cgroupVersion :: (Data.Maybe.Maybe (SystemInfoCgroupVersion)),
        containerd :: (Data.Maybe.Maybe (ContainerdInfo)),
        containerdCommit :: (Data.Maybe.Maybe (Commit)),
        containers :: (Data.Maybe.Maybe (GHC.Int.Int)),
        containersPaused :: (Data.Maybe.Maybe (GHC.Int.Int)),
        containersRunning :: (Data.Maybe.Maybe (GHC.Int.Int)),
        containersStopped :: (Data.Maybe.Maybe (GHC.Int.Int)),
        cpuCfsPeriod :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        cpuCfsQuota :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        debug :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        defaultAddressPools :: (Data.Maybe.Maybe ([ SystemInfoDefaultAddressPools ])),
        defaultRuntime :: (Data.Maybe.Maybe (Data.Text.Text)),
        dockerRootDir :: (Data.Maybe.Maybe (Data.Text.Text)),
        driver :: (Data.Maybe.Maybe (Data.Text.Text)),
        driverStatus :: (Data.Maybe.Maybe ([ [ Data.Text.Text ] ])),
        experimentalBuild :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        genericResources :: (Data.Maybe.Maybe (GenericResources)),
        httpProxy :: (Data.Maybe.Maybe (Data.Text.Text)),
        httpsProxy :: (Data.Maybe.Maybe (Data.Text.Text)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        iPv4Forwarding :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        images :: (Data.Maybe.Maybe (GHC.Int.Int)),
        indexServerAddress :: (Data.Maybe.Maybe (Data.Text.Text)),
        initBinary :: (Data.Maybe.Maybe (Data.Text.Text)),
        initCommit :: (Data.Maybe.Maybe (Commit)),
        isolation :: (Data.Maybe.Maybe (SystemInfoIsolation)),
        kernelMemoryTCP :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        kernelVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        labels :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        liveRestoreEnabled :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        loggingDriver :: (Data.Maybe.Maybe (Data.Text.Text)),
        memTotal :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        memoryLimit :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        nCPU :: (Data.Maybe.Maybe (GHC.Int.Int)),
        nEventsListener :: (Data.Maybe.Maybe (GHC.Int.Int)),
        nFd :: (Data.Maybe.Maybe (GHC.Int.Int)),
        nGoroutines :: (Data.Maybe.Maybe (GHC.Int.Int)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        noProxy :: (Data.Maybe.Maybe (Data.Text.Text)),
        oSType :: (Data.Maybe.Maybe (Data.Text.Text)),
        oSVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        oomKillDisable :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        operatingSystem :: (Data.Maybe.Maybe (Data.Text.Text)),
        pidsLimit :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        plugins :: (Data.Maybe.Maybe (PluginsInfo)),
        productLicense :: (Data.Maybe.Maybe (Data.Text.Text)),
        registryConfig :: (Data.Maybe.Maybe (RegistryServiceConfig)),
        runcCommit :: (Data.Maybe.Maybe (Commit)),
        runtimes :: (Data.Maybe.Maybe (SystemInfoRuntimes)),
        securityOptions :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        serverVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        swapLimit :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        swarm :: (Data.Maybe.Maybe (SwarmInfo)),
        systemTime :: (Data.Maybe.Maybe (Data.Text.Text)),
        warnings :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemInfo where
    toJSON SystemInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Architecture" Data.Aeson..= architecture | Just architecture <- [architecture] ]
        ++ [ "BridgeNfIp6tables" Data.Aeson..= bridgeNfIp6tables | Just bridgeNfIp6tables <- [bridgeNfIp6tables] ]
        ++ [ "BridgeNfIptables" Data.Aeson..= bridgeNfIptables | Just bridgeNfIptables <- [bridgeNfIptables] ]
        ++ [ "CDISpecDirs" Data.Aeson..= cDISpecDirs | Just cDISpecDirs <- [cDISpecDirs] ]
        ++ [ "CPUSet" Data.Aeson..= cPUSet | Just cPUSet <- [cPUSet] ]
        ++ [ "CPUShares" Data.Aeson..= cPUShares | Just cPUShares <- [cPUShares] ]
        ++ [ "CgroupDriver" Data.Aeson..= cgroupDriver | Just cgroupDriver <- [cgroupDriver] ]
        ++ [ "CgroupVersion" Data.Aeson..= cgroupVersion | Just cgroupVersion <- [cgroupVersion] ]
        ++ [ "Containerd" Data.Aeson..= containerd | Just containerd <- [containerd] ]
        ++ [ "ContainerdCommit" Data.Aeson..= containerdCommit | Just containerdCommit <- [containerdCommit] ]
        ++ [ "Containers" Data.Aeson..= containers | Just containers <- [containers] ]
        ++ [ "ContainersPaused" Data.Aeson..= containersPaused | Just containersPaused <- [containersPaused] ]
        ++ [ "ContainersRunning" Data.Aeson..= containersRunning | Just containersRunning <- [containersRunning] ]
        ++ [ "ContainersStopped" Data.Aeson..= containersStopped | Just containersStopped <- [containersStopped] ]
        ++ [ "CpuCfsPeriod" Data.Aeson..= cpuCfsPeriod | Just cpuCfsPeriod <- [cpuCfsPeriod] ]
        ++ [ "CpuCfsQuota" Data.Aeson..= cpuCfsQuota | Just cpuCfsQuota <- [cpuCfsQuota] ]
        ++ [ "Debug" Data.Aeson..= debug | Just debug <- [debug] ]
        ++ [ "DefaultAddressPools" Data.Aeson..= defaultAddressPools | Just defaultAddressPools <- [defaultAddressPools] ]
        ++ [ "DefaultRuntime" Data.Aeson..= defaultRuntime | Just defaultRuntime <- [defaultRuntime] ]
        ++ [ "DockerRootDir" Data.Aeson..= dockerRootDir | Just dockerRootDir <- [dockerRootDir] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "DriverStatus" Data.Aeson..= driverStatus | Just driverStatus <- [driverStatus] ]
        ++ [ "ExperimentalBuild" Data.Aeson..= experimentalBuild | Just experimentalBuild <- [experimentalBuild] ]
        ++ [ "GenericResources" Data.Aeson..= genericResources | Just genericResources <- [genericResources] ]
        ++ [ "HttpProxy" Data.Aeson..= httpProxy | Just httpProxy <- [httpProxy] ]
        ++ [ "HttpsProxy" Data.Aeson..= httpsProxy | Just httpsProxy <- [httpsProxy] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "IPv4Forwarding" Data.Aeson..= iPv4Forwarding | Just iPv4Forwarding <- [iPv4Forwarding] ]
        ++ [ "Images" Data.Aeson..= images | Just images <- [images] ]
        ++ [ "IndexServerAddress" Data.Aeson..= indexServerAddress | Just indexServerAddress <- [indexServerAddress] ]
        ++ [ "InitBinary" Data.Aeson..= initBinary | Just initBinary <- [initBinary] ]
        ++ [ "InitCommit" Data.Aeson..= initCommit | Just initCommit <- [initCommit] ]
        ++ [ "Isolation" Data.Aeson..= isolation | Just isolation <- [isolation] ]
        ++ [ "KernelMemoryTCP" Data.Aeson..= kernelMemoryTCP | Just kernelMemoryTCP <- [kernelMemoryTCP] ]
        ++ [ "KernelVersion" Data.Aeson..= kernelVersion | Just kernelVersion <- [kernelVersion] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "LiveRestoreEnabled" Data.Aeson..= liveRestoreEnabled | Just liveRestoreEnabled <- [liveRestoreEnabled] ]
        ++ [ "LoggingDriver" Data.Aeson..= loggingDriver | Just loggingDriver <- [loggingDriver] ]
        ++ [ "MemTotal" Data.Aeson..= memTotal | Just memTotal <- [memTotal] ]
        ++ [ "MemoryLimit" Data.Aeson..= memoryLimit | Just memoryLimit <- [memoryLimit] ]
        ++ [ "NCPU" Data.Aeson..= nCPU | Just nCPU <- [nCPU] ]
        ++ [ "NEventsListener" Data.Aeson..= nEventsListener | Just nEventsListener <- [nEventsListener] ]
        ++ [ "NFd" Data.Aeson..= nFd | Just nFd <- [nFd] ]
        ++ [ "NGoroutines" Data.Aeson..= nGoroutines | Just nGoroutines <- [nGoroutines] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "NoProxy" Data.Aeson..= noProxy | Just noProxy <- [noProxy] ]
        ++ [ "OSType" Data.Aeson..= oSType | Just oSType <- [oSType] ]
        ++ [ "OSVersion" Data.Aeson..= oSVersion | Just oSVersion <- [oSVersion] ]
        ++ [ "OomKillDisable" Data.Aeson..= oomKillDisable | Just oomKillDisable <- [oomKillDisable] ]
        ++ [ "OperatingSystem" Data.Aeson..= operatingSystem | Just operatingSystem <- [operatingSystem] ]
        ++ [ "PidsLimit" Data.Aeson..= pidsLimit | Just pidsLimit <- [pidsLimit] ]
        ++ [ "Plugins" Data.Aeson..= plugins | Just plugins <- [plugins] ]
        ++ [ "ProductLicense" Data.Aeson..= productLicense | Just productLicense <- [productLicense] ]
        ++ [ "RegistryConfig" Data.Aeson..= registryConfig | Just registryConfig <- [registryConfig] ]
        ++ [ "RuncCommit" Data.Aeson..= runcCommit | Just runcCommit <- [runcCommit] ]
        ++ [ "Runtimes" Data.Aeson..= runtimes | Just runtimes <- [runtimes] ]
        ++ [ "SecurityOptions" Data.Aeson..= securityOptions | Just securityOptions <- [securityOptions] ]
        ++ [ "ServerVersion" Data.Aeson..= serverVersion | Just serverVersion <- [serverVersion] ]
        ++ [ "SwapLimit" Data.Aeson..= swapLimit | Just swapLimit <- [swapLimit] ]
        ++ [ "Swarm" Data.Aeson..= swarm | Just swarm <- [swarm] ]
        ++ [ "SystemTime" Data.Aeson..= systemTime | Just systemTime <- [systemTime] ]
        ++ [ "Warnings" Data.Aeson..= warnings | Just warnings <- [warnings] ])

    toEncoding SystemInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Architecture" . Data.Aeson.toEncoding) architecture <>
          maybe mempty (Data.Aeson.Encoding.pair "BridgeNfIp6tables" . Data.Aeson.toEncoding) bridgeNfIp6tables <>
          maybe mempty (Data.Aeson.Encoding.pair "BridgeNfIptables" . Data.Aeson.toEncoding) bridgeNfIptables <>
          maybe mempty (Data.Aeson.Encoding.pair "CDISpecDirs" . Data.Aeson.toEncoding) cDISpecDirs <>
          maybe mempty (Data.Aeson.Encoding.pair "CPUSet" . Data.Aeson.toEncoding) cPUSet <>
          maybe mempty (Data.Aeson.Encoding.pair "CPUShares" . Data.Aeson.toEncoding) cPUShares <>
          maybe mempty (Data.Aeson.Encoding.pair "CgroupDriver" . Data.Aeson.toEncoding) cgroupDriver <>
          maybe mempty (Data.Aeson.Encoding.pair "CgroupVersion" . Data.Aeson.toEncoding) cgroupVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "Containerd" . Data.Aeson.toEncoding) containerd <>
          maybe mempty (Data.Aeson.Encoding.pair "ContainerdCommit" . Data.Aeson.toEncoding) containerdCommit <>
          maybe mempty (Data.Aeson.Encoding.pair "Containers" . Data.Aeson.toEncoding) containers <>
          maybe mempty (Data.Aeson.Encoding.pair "ContainersPaused" . Data.Aeson.toEncoding) containersPaused <>
          maybe mempty (Data.Aeson.Encoding.pair "ContainersRunning" . Data.Aeson.toEncoding) containersRunning <>
          maybe mempty (Data.Aeson.Encoding.pair "ContainersStopped" . Data.Aeson.toEncoding) containersStopped <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuCfsPeriod" . Data.Aeson.toEncoding) cpuCfsPeriod <>
          maybe mempty (Data.Aeson.Encoding.pair "CpuCfsQuota" . Data.Aeson.toEncoding) cpuCfsQuota <>
          maybe mempty (Data.Aeson.Encoding.pair "Debug" . Data.Aeson.toEncoding) debug <>
          maybe mempty (Data.Aeson.Encoding.pair "DefaultAddressPools" . Data.Aeson.toEncoding) defaultAddressPools <>
          maybe mempty (Data.Aeson.Encoding.pair "DefaultRuntime" . Data.Aeson.toEncoding) defaultRuntime <>
          maybe mempty (Data.Aeson.Encoding.pair "DockerRootDir" . Data.Aeson.toEncoding) dockerRootDir <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "DriverStatus" . Data.Aeson.toEncoding) driverStatus <>
          maybe mempty (Data.Aeson.Encoding.pair "ExperimentalBuild" . Data.Aeson.toEncoding) experimentalBuild <>
          maybe mempty (Data.Aeson.Encoding.pair "GenericResources" . Data.Aeson.toEncoding) genericResources <>
          maybe mempty (Data.Aeson.Encoding.pair "HttpProxy" . Data.Aeson.toEncoding) httpProxy <>
          maybe mempty (Data.Aeson.Encoding.pair "HttpsProxy" . Data.Aeson.toEncoding) httpsProxy <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "IPv4Forwarding" . Data.Aeson.toEncoding) iPv4Forwarding <>
          maybe mempty (Data.Aeson.Encoding.pair "Images" . Data.Aeson.toEncoding) images <>
          maybe mempty (Data.Aeson.Encoding.pair "IndexServerAddress" . Data.Aeson.toEncoding) indexServerAddress <>
          maybe mempty (Data.Aeson.Encoding.pair "InitBinary" . Data.Aeson.toEncoding) initBinary <>
          maybe mempty (Data.Aeson.Encoding.pair "InitCommit" . Data.Aeson.toEncoding) initCommit <>
          maybe mempty (Data.Aeson.Encoding.pair "Isolation" . Data.Aeson.toEncoding) isolation <>
          maybe mempty (Data.Aeson.Encoding.pair "KernelMemoryTCP" . Data.Aeson.toEncoding) kernelMemoryTCP <>
          maybe mempty (Data.Aeson.Encoding.pair "KernelVersion" . Data.Aeson.toEncoding) kernelVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "LiveRestoreEnabled" . Data.Aeson.toEncoding) liveRestoreEnabled <>
          maybe mempty (Data.Aeson.Encoding.pair "LoggingDriver" . Data.Aeson.toEncoding) loggingDriver <>
          maybe mempty (Data.Aeson.Encoding.pair "MemTotal" . Data.Aeson.toEncoding) memTotal <>
          maybe mempty (Data.Aeson.Encoding.pair "MemoryLimit" . Data.Aeson.toEncoding) memoryLimit <>
          maybe mempty (Data.Aeson.Encoding.pair "NCPU" . Data.Aeson.toEncoding) nCPU <>
          maybe mempty (Data.Aeson.Encoding.pair "NEventsListener" . Data.Aeson.toEncoding) nEventsListener <>
          maybe mempty (Data.Aeson.Encoding.pair "NFd" . Data.Aeson.toEncoding) nFd <>
          maybe mempty (Data.Aeson.Encoding.pair "NGoroutines" . Data.Aeson.toEncoding) nGoroutines <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "NoProxy" . Data.Aeson.toEncoding) noProxy <>
          maybe mempty (Data.Aeson.Encoding.pair "OSType" . Data.Aeson.toEncoding) oSType <>
          maybe mempty (Data.Aeson.Encoding.pair "OSVersion" . Data.Aeson.toEncoding) oSVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "OomKillDisable" . Data.Aeson.toEncoding) oomKillDisable <>
          maybe mempty (Data.Aeson.Encoding.pair "OperatingSystem" . Data.Aeson.toEncoding) operatingSystem <>
          maybe mempty (Data.Aeson.Encoding.pair "PidsLimit" . Data.Aeson.toEncoding) pidsLimit <>
          maybe mempty (Data.Aeson.Encoding.pair "Plugins" . Data.Aeson.toEncoding) plugins <>
          maybe mempty (Data.Aeson.Encoding.pair "ProductLicense" . Data.Aeson.toEncoding) productLicense <>
          maybe mempty (Data.Aeson.Encoding.pair "RegistryConfig" . Data.Aeson.toEncoding) registryConfig <>
          maybe mempty (Data.Aeson.Encoding.pair "RuncCommit" . Data.Aeson.toEncoding) runcCommit <>
          maybe mempty (Data.Aeson.Encoding.pair "Runtimes" . Data.Aeson.toEncoding) runtimes <>
          maybe mempty (Data.Aeson.Encoding.pair "SecurityOptions" . Data.Aeson.toEncoding) securityOptions <>
          maybe mempty (Data.Aeson.Encoding.pair "ServerVersion" . Data.Aeson.toEncoding) serverVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "SwapLimit" . Data.Aeson.toEncoding) swapLimit <>
          maybe mempty (Data.Aeson.Encoding.pair "Swarm" . Data.Aeson.toEncoding) swarm <>
          maybe mempty (Data.Aeson.Encoding.pair "SystemTime" . Data.Aeson.toEncoding) systemTime <>
          maybe mempty (Data.Aeson.Encoding.pair "Warnings" . Data.Aeson.toEncoding) warnings
        )

instance Data.Aeson.FromJSON SystemInfo where
    parseJSON = Data.Aeson.withObject "SystemInfo" $ \o ->
        SystemInfo
            <$> o Data.Aeson..:? "Architecture"
            <*> o Data.Aeson..:? "BridgeNfIp6tables"
            <*> o Data.Aeson..:? "BridgeNfIptables"
            <*> o Data.Aeson..:? "CDISpecDirs"
            <*> o Data.Aeson..:? "CPUSet"
            <*> o Data.Aeson..:? "CPUShares"
            <*> o Data.Aeson..:? "CgroupDriver"
            <*> o Data.Aeson..:? "CgroupVersion"
            <*> o Data.Aeson..:? "Containerd"
            <*> o Data.Aeson..:? "ContainerdCommit"
            <*> o Data.Aeson..:? "Containers"
            <*> o Data.Aeson..:? "ContainersPaused"
            <*> o Data.Aeson..:? "ContainersRunning"
            <*> o Data.Aeson..:? "ContainersStopped"
            <*> o Data.Aeson..:? "CpuCfsPeriod"
            <*> o Data.Aeson..:? "CpuCfsQuota"
            <*> o Data.Aeson..:? "Debug"
            <*> o Data.Aeson..:? "DefaultAddressPools"
            <*> o Data.Aeson..:? "DefaultRuntime"
            <*> o Data.Aeson..:? "DockerRootDir"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "DriverStatus"
            <*> o Data.Aeson..:? "ExperimentalBuild"
            <*> o Data.Aeson..:? "GenericResources"
            <*> o Data.Aeson..:? "HttpProxy"
            <*> o Data.Aeson..:? "HttpsProxy"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "IPv4Forwarding"
            <*> o Data.Aeson..:? "Images"
            <*> o Data.Aeson..:? "IndexServerAddress"
            <*> o Data.Aeson..:? "InitBinary"
            <*> o Data.Aeson..:? "InitCommit"
            <*> o Data.Aeson..:? "Isolation"
            <*> o Data.Aeson..:? "KernelMemoryTCP"
            <*> o Data.Aeson..:? "KernelVersion"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "LiveRestoreEnabled"
            <*> o Data.Aeson..:? "LoggingDriver"
            <*> o Data.Aeson..:? "MemTotal"
            <*> o Data.Aeson..:? "MemoryLimit"
            <*> o Data.Aeson..:? "NCPU"
            <*> o Data.Aeson..:? "NEventsListener"
            <*> o Data.Aeson..:? "NFd"
            <*> o Data.Aeson..:? "NGoroutines"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "NoProxy"
            <*> o Data.Aeson..:? "OSType"
            <*> o Data.Aeson..:? "OSVersion"
            <*> o Data.Aeson..:? "OomKillDisable"
            <*> o Data.Aeson..:? "OperatingSystem"
            <*> o Data.Aeson..:? "PidsLimit"
            <*> o Data.Aeson..:? "Plugins"
            <*> o Data.Aeson..:? "ProductLicense"
            <*> o Data.Aeson..:? "RegistryConfig"
            <*> o Data.Aeson..:? "RuncCommit"
            <*> o Data.Aeson..:? "Runtimes"
            <*> o Data.Aeson..:? "SecurityOptions"
            <*> o Data.Aeson..:? "ServerVersion"
            <*> o Data.Aeson..:? "SwapLimit"
            <*> o Data.Aeson..:? "Swarm"
            <*> o Data.Aeson..:? "SystemTime"
            <*> o Data.Aeson..:? "Warnings"