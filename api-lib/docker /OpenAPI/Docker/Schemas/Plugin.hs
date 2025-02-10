{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Plugin where

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



import OpenAPI.Docker.Schemas.PluginDevice
import OpenAPI.Docker.Schemas.PluginEnv
import OpenAPI.Docker.Schemas.PluginInterfaceType
import OpenAPI.Docker.Schemas.PluginMount

data PluginConfig = PluginConfig
    {
        args :: PluginConfigArgs,
        description :: Data.Text.Text,
        dockerVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        documentation :: Data.Text.Text,
        entrypoint :: [ Data.Text.Text ],
        env :: [ PluginEnv ],
        interface :: PluginConfigInterface,
        ipcHost :: GHC.Types.Bool,
        linux :: PluginConfigLinux,
        mounts :: [ PluginMount ],
        network :: PluginConfigNetwork,
        pidHost :: GHC.Types.Bool,
        propagatedMount :: Data.Text.Text,
        user :: (Data.Maybe.Maybe (PluginConfigUser)),
        workDir :: Data.Text.Text,
        rootfs :: (Data.Maybe.Maybe (PluginConfigRootfs))
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginConfig where
    toJSON PluginConfig {..} = Data.Aeson.object
        ([ "Args" Data.Aeson..= args,
           "Description" Data.Aeson..= description,
           "Documentation" Data.Aeson..= documentation,
           "Entrypoint" Data.Aeson..= entrypoint,
           "Env" Data.Aeson..= env,
           "Interface" Data.Aeson..= interface,
           "IpcHost" Data.Aeson..= ipcHost,
           "Linux" Data.Aeson..= linux,
           "Mounts" Data.Aeson..= mounts,
           "Network" Data.Aeson..= network,
           "PidHost" Data.Aeson..= pidHost,
           "PropagatedMount" Data.Aeson..= propagatedMount,
           "WorkDir" Data.Aeson..= workDir
        ]
        ++ [ "DockerVersion" Data.Aeson..= dockerVersion | Just dockerVersion <- [dockerVersion] ]
        ++ [ "User" Data.Aeson..= user | Just user <- [user] ]
        ++ [ "rootfs" Data.Aeson..= rootfs | Just rootfs <- [rootfs] ])

    toEncoding PluginConfig {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Args" (Data.Aeson.toEncoding args) <>
          Data.Aeson.Encoding.pair "Description" (Data.Aeson.toEncoding description) <>
          maybe mempty (Data.Aeson.Encoding.pair "DockerVersion" . Data.Aeson.toEncoding) dockerVersion <>
          Data.Aeson.Encoding.pair "Documentation" (Data.Aeson.toEncoding documentation) <>
          Data.Aeson.Encoding.pair "Entrypoint" (Data.Aeson.toEncoding entrypoint) <>
          Data.Aeson.Encoding.pair "Env" (Data.Aeson.toEncoding env) <>
          Data.Aeson.Encoding.pair "Interface" (Data.Aeson.toEncoding interface) <>
          Data.Aeson.Encoding.pair "IpcHost" (Data.Aeson.toEncoding ipcHost) <>
          Data.Aeson.Encoding.pair "Linux" (Data.Aeson.toEncoding linux) <>
          Data.Aeson.Encoding.pair "Mounts" (Data.Aeson.toEncoding mounts) <>
          Data.Aeson.Encoding.pair "Network" (Data.Aeson.toEncoding network) <>
          Data.Aeson.Encoding.pair "PidHost" (Data.Aeson.toEncoding pidHost) <>
          Data.Aeson.Encoding.pair "PropagatedMount" (Data.Aeson.toEncoding propagatedMount) <>
          maybe mempty (Data.Aeson.Encoding.pair "User" . Data.Aeson.toEncoding) user <>
          Data.Aeson.Encoding.pair "WorkDir" (Data.Aeson.toEncoding workDir) <>
          maybe mempty (Data.Aeson.Encoding.pair "rootfs" . Data.Aeson.toEncoding) rootfs
        )

instance Data.Aeson.FromJSON PluginConfig where
    parseJSON = Data.Aeson.withObject "PluginConfig" $ \o ->
        PluginConfig
            <$> o Data.Aeson..: "Args"
            <*> o Data.Aeson..: "Description"
            <*> o Data.Aeson..:? "DockerVersion"
            <*> o Data.Aeson..: "Documentation"
            <*> o Data.Aeson..: "Entrypoint"
            <*> o Data.Aeson..: "Env"
            <*> o Data.Aeson..: "Interface"
            <*> o Data.Aeson..: "IpcHost"
            <*> o Data.Aeson..: "Linux"
            <*> o Data.Aeson..: "Mounts"
            <*> o Data.Aeson..: "Network"
            <*> o Data.Aeson..: "PidHost"
            <*> o Data.Aeson..: "PropagatedMount"
            <*> o Data.Aeson..:? "User"
            <*> o Data.Aeson..: "WorkDir"
            <*> o Data.Aeson..:? "rootfs"

data PluginConfigArgs = PluginConfigArgs
    {
        description :: Data.Text.Text,
        name :: Data.Text.Text,
        settable :: [ Data.Text.Text ],
        value :: [ Data.Text.Text ]
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginConfigArgs where
    toJSON PluginConfigArgs {..} = Data.Aeson.object
        ([ "Description" Data.Aeson..= description,
           "Name" Data.Aeson..= name,
           "Settable" Data.Aeson..= settable,
           "Value" Data.Aeson..= value
        ]
        )

    toEncoding PluginConfigArgs {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Description" (Data.Aeson.toEncoding description) <>
          Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name) <>
          Data.Aeson.Encoding.pair "Settable" (Data.Aeson.toEncoding settable) <>
          Data.Aeson.Encoding.pair "Value" (Data.Aeson.toEncoding value)
        )

instance Data.Aeson.FromJSON PluginConfigArgs where
    parseJSON = Data.Aeson.withObject "PluginConfigArgs" $ \o ->
        PluginConfigArgs
            <$> o Data.Aeson..: "Description"
            <*> o Data.Aeson..: "Name"
            <*> o Data.Aeson..: "Settable"
            <*> o Data.Aeson..: "Value"

data PluginConfigInterface = PluginConfigInterface
    {
        protocolScheme :: (Data.Maybe.Maybe (PluginConfigInterfaceProtocolScheme)),
        socket :: Data.Text.Text,
        types :: [ PluginInterfaceType ]
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginConfigInterface where
    toJSON PluginConfigInterface {..} = Data.Aeson.object
        ([ "Socket" Data.Aeson..= socket,
           "Types" Data.Aeson..= types
        ]
        ++ [ "ProtocolScheme" Data.Aeson..= protocolScheme | Just protocolScheme <- [protocolScheme] ])

    toEncoding PluginConfigInterface {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ProtocolScheme" . Data.Aeson.toEncoding) protocolScheme <>
          Data.Aeson.Encoding.pair "Socket" (Data.Aeson.toEncoding socket) <>
          Data.Aeson.Encoding.pair "Types" (Data.Aeson.toEncoding types)
        )

instance Data.Aeson.FromJSON PluginConfigInterface where
    parseJSON = Data.Aeson.withObject "PluginConfigInterface" $ \o ->
        PluginConfigInterface
            <$> o Data.Aeson..:? "ProtocolScheme"
            <*> o Data.Aeson..: "Socket"
            <*> o Data.Aeson..: "Types"

data PluginConfigInterfaceProtocolScheme
    = PluginConfigInterfaceProtocolScheme
    | PluginConfigInterfaceProtocolSchemeMoby.plugins.http/v1
    deriving (Eq, Show)

instance Data.Aeson.ToJSON PluginConfigInterfaceProtocolScheme where
    toJSON x = case x of
        PluginConfigInterfaceProtocolScheme -> ""
        PluginConfigInterfaceProtocolSchemeMoby.plugins.http/v1 -> "moby.plugins.http/v1"

    toEncoding x = case x of
        PluginConfigInterfaceProtocolScheme -> Data.Aeson.Encoding.text ""
        PluginConfigInterfaceProtocolSchemeMoby.plugins.http/v1 -> Data.Aeson.Encoding.text "moby.plugins.http/v1"

instance Data.Aeson.FromJSON PluginConfigInterfaceProtocolScheme where
    parseJSON = Data.Aeson.withText "PluginConfigInterfaceProtocolScheme" $ \s ->
        case s of
            "" -> pure PluginConfigInterfaceProtocolScheme
            "moby.plugins.http/v1" -> pure PluginConfigInterfaceProtocolSchemeMoby.plugins.http/v1
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData PluginConfigInterfaceProtocolScheme where
    toQueryParam x = case x of
        PluginConfigInterfaceProtocolScheme -> ""
        PluginConfigInterfaceProtocolSchemeMoby.plugins.http/v1 -> "moby.plugins.http/v1"

instance Web.HttpApiData.FromHttpApiData PluginConfigInterfaceProtocolScheme where
    parseUrlPiece x =
        case x of
            "" -> pure PluginConfigInterfaceProtocolScheme
            "moby.plugins.http/v1" -> pure PluginConfigInterfaceProtocolSchemeMoby.plugins.http/v1
            _ -> Left "invalid enum value"

data PluginConfigLinux = PluginConfigLinux
    {
        allowAllDevices :: GHC.Types.Bool,
        capabilities :: [ Data.Text.Text ],
        devices :: [ PluginDevice ]
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginConfigLinux where
    toJSON PluginConfigLinux {..} = Data.Aeson.object
        ([ "AllowAllDevices" Data.Aeson..= allowAllDevices,
           "Capabilities" Data.Aeson..= capabilities,
           "Devices" Data.Aeson..= devices
        ]
        )

    toEncoding PluginConfigLinux {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "AllowAllDevices" (Data.Aeson.toEncoding allowAllDevices) <>
          Data.Aeson.Encoding.pair "Capabilities" (Data.Aeson.toEncoding capabilities) <>
          Data.Aeson.Encoding.pair "Devices" (Data.Aeson.toEncoding devices)
        )

instance Data.Aeson.FromJSON PluginConfigLinux where
    parseJSON = Data.Aeson.withObject "PluginConfigLinux" $ \o ->
        PluginConfigLinux
            <$> o Data.Aeson..: "AllowAllDevices"
            <*> o Data.Aeson..: "Capabilities"
            <*> o Data.Aeson..: "Devices"

newtype PluginConfigNetwork = PluginConfigNetwork
    {
        type' :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginConfigNetwork where
    toJSON PluginConfigNetwork {..} = Data.Aeson.object
        ([ "Type" Data.Aeson..= type'
        ]
        )

    toEncoding PluginConfigNetwork {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Type" (Data.Aeson.toEncoding type')
        )

instance Data.Aeson.FromJSON PluginConfigNetwork where
    parseJSON = Data.Aeson.withObject "PluginConfigNetwork" $ \o ->
        PluginConfigNetwork
            <$> o Data.Aeson..: "Type"

data PluginConfigRootfs = PluginConfigRootfs
    {
        diffIds :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        type' :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginConfigRootfs where
    toJSON PluginConfigRootfs {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "diff_ids" Data.Aeson..= diffIds | Just diffIds <- [diffIds] ]
        ++ [ "type" Data.Aeson..= type' | Just type' <- [type'] ])

    toEncoding PluginConfigRootfs {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "diff_ids" . Data.Aeson.toEncoding) diffIds <>
          maybe mempty (Data.Aeson.Encoding.pair "type" . Data.Aeson.toEncoding) type'
        )

instance Data.Aeson.FromJSON PluginConfigRootfs where
    parseJSON = Data.Aeson.withObject "PluginConfigRootfs" $ \o ->
        PluginConfigRootfs
            <$> o Data.Aeson..:? "diff_ids"
            <*> o Data.Aeson..:? "type"

data PluginConfigUser = PluginConfigUser
    {
        gID :: (Data.Maybe.Maybe (GHC.Int.Int)),
        uID :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginConfigUser where
    toJSON PluginConfigUser {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "GID" Data.Aeson..= gID | Just gID <- [gID] ]
        ++ [ "UID" Data.Aeson..= uID | Just uID <- [uID] ])

    toEncoding PluginConfigUser {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "GID" . Data.Aeson.toEncoding) gID <>
          maybe mempty (Data.Aeson.Encoding.pair "UID" . Data.Aeson.toEncoding) uID
        )

instance Data.Aeson.FromJSON PluginConfigUser where
    parseJSON = Data.Aeson.withObject "PluginConfigUser" $ \o ->
        PluginConfigUser
            <$> o Data.Aeson..:? "GID"
            <*> o Data.Aeson..:? "UID"

data PluginSettings = PluginSettings
    {
        args :: [ Data.Text.Text ],
        devices :: [ PluginDevice ],
        env :: [ Data.Text.Text ],
        mounts :: [ PluginMount ]
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginSettings where
    toJSON PluginSettings {..} = Data.Aeson.object
        ([ "Args" Data.Aeson..= args,
           "Devices" Data.Aeson..= devices,
           "Env" Data.Aeson..= env,
           "Mounts" Data.Aeson..= mounts
        ]
        )

    toEncoding PluginSettings {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Args" (Data.Aeson.toEncoding args) <>
          Data.Aeson.Encoding.pair "Devices" (Data.Aeson.toEncoding devices) <>
          Data.Aeson.Encoding.pair "Env" (Data.Aeson.toEncoding env) <>
          Data.Aeson.Encoding.pair "Mounts" (Data.Aeson.toEncoding mounts)
        )

instance Data.Aeson.FromJSON PluginSettings where
    parseJSON = Data.Aeson.withObject "PluginSettings" $ \o ->
        PluginSettings
            <$> o Data.Aeson..: "Args"
            <*> o Data.Aeson..: "Devices"
            <*> o Data.Aeson..: "Env"
            <*> o Data.Aeson..: "Mounts"

data Plugin = Plugin
    {
        config :: PluginConfig,
        enabled :: GHC.Types.Bool,
        id :: (Data.Maybe.Maybe (Data.Text.Text)),
        name :: Data.Text.Text,
        pluginReference :: (Data.Maybe.Maybe (Data.Text.Text)),
        settings :: PluginSettings
    }
    deriving (Show)

instance Data.Aeson.ToJSON Plugin where
    toJSON Plugin {..} = Data.Aeson.object
        ([ "Config" Data.Aeson..= config,
           "Enabled" Data.Aeson..= enabled,
           "Name" Data.Aeson..= name,
           "Settings" Data.Aeson..= settings
        ]
        ++ [ "Id" Data.Aeson..= id | Just id <- [id] ]
        ++ [ "PluginReference" Data.Aeson..= pluginReference | Just pluginReference <- [pluginReference] ])

    toEncoding Plugin {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Config" (Data.Aeson.toEncoding config) <>
          Data.Aeson.Encoding.pair "Enabled" (Data.Aeson.toEncoding enabled) <>
          maybe mempty (Data.Aeson.Encoding.pair "Id" . Data.Aeson.toEncoding) id <>
          Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name) <>
          maybe mempty (Data.Aeson.Encoding.pair "PluginReference" . Data.Aeson.toEncoding) pluginReference <>
          Data.Aeson.Encoding.pair "Settings" (Data.Aeson.toEncoding settings)
        )

instance Data.Aeson.FromJSON Plugin where
    parseJSON = Data.Aeson.withObject "Plugin" $ \o ->
        Plugin
            <$> o Data.Aeson..: "Config"
            <*> o Data.Aeson..: "Enabled"
            <*> o Data.Aeson..:? "Id"
            <*> o Data.Aeson..: "Name"
            <*> o Data.Aeson..:? "PluginReference"
            <*> o Data.Aeson..: "Settings"