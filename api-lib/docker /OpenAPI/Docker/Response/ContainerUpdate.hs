{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Response.ContainerUpdate where

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
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.Resources
import OpenAPI.Docker.Schemas.RestartPolicy
import OpenAPI.Docker.Schemas.ThrottleDevice

import OpenAPI.Docker.Response

data ContainerUpdateRequestBody = ContainerUpdateRequestBody
    {
        blkioDeviceReadBps :: (Data.Maybe.Maybe ([ ThrottleDevice ])),
        blkioDeviceReadIOps :: (Data.Maybe.Maybe ([ ThrottleDevice ])),
        blkioDeviceWriteBps :: (Data.Maybe.Maybe ([ ThrottleDevice ])),
        blkioDeviceWriteIOps :: (Data.Maybe.Maybe ([ ThrottleDevice ])),
        blkioWeight :: (Data.Maybe.Maybe (GHC.Int.Int)),
        blkioWeightDevice :: (Data.Maybe.Maybe ([ ContainerUpdateRequestBodyBlkioWeightDevice ])),
        cgroupParent :: (Data.Maybe.Maybe (Data.Text.Text)),
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
        iOMaximumBandwidth :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        iOMaximumIOps :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        init :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        kernelMemoryTCP :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        memory :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        memoryReservation :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        memorySwap :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        memorySwappiness :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        nanoCpus :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        oomKillDisable :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        pidsLimit :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        restartPolicy :: (Data.Maybe.Maybe (RestartPolicy)),
        ulimits :: (Data.Maybe.Maybe ([ ContainerUpdateRequestBodyUlimits ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerUpdateRequestBody where
    toJSON ContainerUpdateRequestBody {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "BlkioDeviceReadBps" Data.Aeson..= blkioDeviceReadBps | Just blkioDeviceReadBps <- [blkioDeviceReadBps] ]
        ++ [ "BlkioDeviceReadIOps" Data.Aeson..= blkioDeviceReadIOps | Just blkioDeviceReadIOps <- [blkioDeviceReadIOps] ]
        ++ [ "BlkioDeviceWriteBps" Data.Aeson..= blkioDeviceWriteBps | Just blkioDeviceWriteBps <- [blkioDeviceWriteBps] ]
        ++ [ "BlkioDeviceWriteIOps" Data.Aeson..= blkioDeviceWriteIOps | Just blkioDeviceWriteIOps <- [blkioDeviceWriteIOps] ]
        ++ [ "BlkioWeight" Data.Aeson..= blkioWeight | Just blkioWeight <- [blkioWeight] ]
        ++ [ "BlkioWeightDevice" Data.Aeson..= blkioWeightDevice | Just blkioWeightDevice <- [blkioWeightDevice] ]
        ++ [ "CgroupParent" Data.Aeson..= cgroupParent | Just cgroupParent <- [cgroupParent] ]
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
        ++ [ "IOMaximumBandwidth" Data.Aeson..= iOMaximumBandwidth | Just iOMaximumBandwidth <- [iOMaximumBandwidth] ]
        ++ [ "IOMaximumIOps" Data.Aeson..= iOMaximumIOps | Just iOMaximumIOps <- [iOMaximumIOps] ]
        ++ [ "Init" Data.Aeson..= init | Just init <- [init] ]
        ++ [ "KernelMemoryTCP" Data.Aeson..= kernelMemoryTCP | Just kernelMemoryTCP <- [kernelMemoryTCP] ]
        ++ [ "Memory" Data.Aeson..= memory | Just memory <- [memory] ]
        ++ [ "MemoryReservation" Data.Aeson..= memoryReservation | Just memoryReservation <- [memoryReservation] ]
        ++ [ "MemorySwap" Data.Aeson..= memorySwap | Just memorySwap <- [memorySwap] ]
        ++ [ "MemorySwappiness" Data.Aeson..= memorySwappiness | Just memorySwappiness <- [memorySwappiness] ]
        ++ [ "NanoCpus" Data.Aeson..= nanoCpus | Just nanoCpus <- [nanoCpus] ]
        ++ [ "OomKillDisable" Data.Aeson..= oomKillDisable | Just oomKillDisable <- [oomKillDisable] ]
        ++ [ "PidsLimit" Data.Aeson..= pidsLimit | Just pidsLimit <- [pidsLimit] ]
        ++ [ "RestartPolicy" Data.Aeson..= restartPolicy | Just restartPolicy <- [restartPolicy] ]
        ++ [ "Ulimits" Data.Aeson..= ulimits | Just ulimits <- [ulimits] ])

    toEncoding ContainerUpdateRequestBody {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "BlkioDeviceReadBps" . Data.Aeson.toEncoding) blkioDeviceReadBps <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioDeviceReadIOps" . Data.Aeson.toEncoding) blkioDeviceReadIOps <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioDeviceWriteBps" . Data.Aeson.toEncoding) blkioDeviceWriteBps <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioDeviceWriteIOps" . Data.Aeson.toEncoding) blkioDeviceWriteIOps <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioWeight" . Data.Aeson.toEncoding) blkioWeight <>
          maybe mempty (Data.Aeson.Encoding.pair "BlkioWeightDevice" . Data.Aeson.toEncoding) blkioWeightDevice <>
          maybe mempty (Data.Aeson.Encoding.pair "CgroupParent" . Data.Aeson.toEncoding) cgroupParent <>
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
          maybe mempty (Data.Aeson.Encoding.pair "IOMaximumBandwidth" . Data.Aeson.toEncoding) iOMaximumBandwidth <>
          maybe mempty (Data.Aeson.Encoding.pair "IOMaximumIOps" . Data.Aeson.toEncoding) iOMaximumIOps <>
          maybe mempty (Data.Aeson.Encoding.pair "Init" . Data.Aeson.toEncoding) init <>
          maybe mempty (Data.Aeson.Encoding.pair "KernelMemoryTCP" . Data.Aeson.toEncoding) kernelMemoryTCP <>
          maybe mempty (Data.Aeson.Encoding.pair "Memory" . Data.Aeson.toEncoding) memory <>
          maybe mempty (Data.Aeson.Encoding.pair "MemoryReservation" . Data.Aeson.toEncoding) memoryReservation <>
          maybe mempty (Data.Aeson.Encoding.pair "MemorySwap" . Data.Aeson.toEncoding) memorySwap <>
          maybe mempty (Data.Aeson.Encoding.pair "MemorySwappiness" . Data.Aeson.toEncoding) memorySwappiness <>
          maybe mempty (Data.Aeson.Encoding.pair "NanoCpus" . Data.Aeson.toEncoding) nanoCpus <>
          maybe mempty (Data.Aeson.Encoding.pair "OomKillDisable" . Data.Aeson.toEncoding) oomKillDisable <>
          maybe mempty (Data.Aeson.Encoding.pair "PidsLimit" . Data.Aeson.toEncoding) pidsLimit <>
          maybe mempty (Data.Aeson.Encoding.pair "RestartPolicy" . Data.Aeson.toEncoding) restartPolicy <>
          maybe mempty (Data.Aeson.Encoding.pair "Ulimits" . Data.Aeson.toEncoding) ulimits
        )

instance Data.Aeson.FromJSON ContainerUpdateRequestBody where
    parseJSON = Data.Aeson.withObject "ContainerUpdateRequestBody" $ \o ->
        ContainerUpdateRequestBody
            <$> o Data.Aeson..:? "BlkioDeviceReadBps"
            <*> o Data.Aeson..:? "BlkioDeviceReadIOps"
            <*> o Data.Aeson..:? "BlkioDeviceWriteBps"
            <*> o Data.Aeson..:? "BlkioDeviceWriteIOps"
            <*> o Data.Aeson..:? "BlkioWeight"
            <*> o Data.Aeson..:? "BlkioWeightDevice"
            <*> o Data.Aeson..:? "CgroupParent"
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
            <*> o Data.Aeson..:? "IOMaximumBandwidth"
            <*> o Data.Aeson..:? "IOMaximumIOps"
            <*> o Data.Aeson..:? "Init"
            <*> o Data.Aeson..:? "KernelMemoryTCP"
            <*> o Data.Aeson..:? "Memory"
            <*> o Data.Aeson..:? "MemoryReservation"
            <*> o Data.Aeson..:? "MemorySwap"
            <*> o Data.Aeson..:? "MemorySwappiness"
            <*> o Data.Aeson..:? "NanoCpus"
            <*> o Data.Aeson..:? "OomKillDisable"
            <*> o Data.Aeson..:? "PidsLimit"
            <*> o Data.Aeson..:? "RestartPolicy"
            <*> o Data.Aeson..:? "Ulimits"

data ContainerUpdateRequestBodyBlkioWeightDevice = ContainerUpdateRequestBodyBlkioWeightDevice
    {
        path :: (Data.Maybe.Maybe (Data.Text.Text)),
        weight :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerUpdateRequestBodyBlkioWeightDevice where
    toJSON ContainerUpdateRequestBodyBlkioWeightDevice {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Path" Data.Aeson..= path | Just path <- [path] ]
        ++ [ "Weight" Data.Aeson..= weight | Just weight <- [weight] ])

    toEncoding ContainerUpdateRequestBodyBlkioWeightDevice {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Path" . Data.Aeson.toEncoding) path <>
          maybe mempty (Data.Aeson.Encoding.pair "Weight" . Data.Aeson.toEncoding) weight
        )

instance Data.Aeson.FromJSON ContainerUpdateRequestBodyBlkioWeightDevice where
    parseJSON = Data.Aeson.withObject "ContainerUpdateRequestBodyBlkioWeightDevice" $ \o ->
        ContainerUpdateRequestBodyBlkioWeightDevice
            <$> o Data.Aeson..:? "Path"
            <*> o Data.Aeson..:? "Weight"

data ContainerUpdateRequestBodyUlimits = ContainerUpdateRequestBodyUlimits
    {
        hard :: (Data.Maybe.Maybe (GHC.Int.Int)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        soft :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerUpdateRequestBodyUlimits where
    toJSON ContainerUpdateRequestBodyUlimits {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Hard" Data.Aeson..= hard | Just hard <- [hard] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Soft" Data.Aeson..= soft | Just soft <- [soft] ])

    toEncoding ContainerUpdateRequestBodyUlimits {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Hard" . Data.Aeson.toEncoding) hard <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Soft" . Data.Aeson.toEncoding) soft
        )

instance Data.Aeson.FromJSON ContainerUpdateRequestBodyUlimits where
    parseJSON = Data.Aeson.withObject "ContainerUpdateRequestBodyUlimits" $ \o ->
        ContainerUpdateRequestBodyUlimits
            <$> o Data.Aeson..:? "Hard"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Soft"

newtype ContainerUpdateResponseBody200 = ContainerUpdateResponseBody200
    {
        warnings :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerUpdateResponseBody200 where
    toJSON ContainerUpdateResponseBody200 {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Warnings" Data.Aeson..= warnings | Just warnings <- [warnings] ])

    toEncoding ContainerUpdateResponseBody200 {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Warnings" . Data.Aeson.toEncoding) warnings
        )

instance Data.Aeson.FromJSON ContainerUpdateResponseBody200 where
    parseJSON = Data.Aeson.withObject "ContainerUpdateResponseBody200" $ \o ->
        ContainerUpdateResponseBody200
            <$> o Data.Aeson..:? "Warnings"

data ContainerUpdateResponse
    = ContainerUpdateResponse200 ContainerUpdateResponseBody200
    | ContainerUpdateResponse404 ErrorResponse
    | ContainerUpdateResponse500 ErrorResponse
    deriving (Show)

instance ToResponse ContainerUpdateResponse where
    toResponse (ContainerUpdateResponse200 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status200 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerUpdateResponse404 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status404 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))
    toResponse (ContainerUpdateResponse500 x) =
        Network.Wai.responseBuilder Network.HTTP.Types.status500 ([(Network.HTTP.Types.hContentType, "application/json")]) (Data.Aeson.fromEncoding (Data.Aeson.toEncoding x))

instance GHC.Records.HasField "status" ContainerUpdateResponse Network.HTTP.Types.Status where
    getField (ContainerUpdateResponse200 {}) = Network.HTTP.Types.status200
    getField (ContainerUpdateResponse404 {}) = Network.HTTP.Types.status404
    getField (ContainerUpdateResponse500 {}) = Network.HTTP.Types.status500