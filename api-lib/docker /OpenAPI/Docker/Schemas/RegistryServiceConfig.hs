{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.RegistryServiceConfig where

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



import OpenAPI.Docker.Schemas.IndexInfo

newtype RegistryServiceConfigIndexConfigs = RegistryServiceConfigIndexConfigs
    (Data.Map.Map Data.Text.Text (IndexInfo))
    deriving (Show)

instance Data.Aeson.ToJSON RegistryServiceConfigIndexConfigs where
    toJSON (RegistryServiceConfigIndexConfigs x) =
        Data.Aeson.toJSON x

    toEncoding (RegistryServiceConfigIndexConfigs x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON RegistryServiceConfigIndexConfigs where
    parseJSON x =
        RegistryServiceConfigIndexConfigs <$> Data.Aeson.parseJSON x

data RegistryServiceConfig = RegistryServiceConfig
    {
        allowNondistributableArtifactsCIDRs :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        allowNondistributableArtifactsHostnames :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        indexConfigs :: (Data.Maybe.Maybe (RegistryServiceConfigIndexConfigs)),
        insecureRegistryCIDRs :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        mirrors :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON RegistryServiceConfig where
    toJSON RegistryServiceConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AllowNondistributableArtifactsCIDRs" Data.Aeson..= allowNondistributableArtifactsCIDRs | Just allowNondistributableArtifactsCIDRs <- [allowNondistributableArtifactsCIDRs] ]
        ++ [ "AllowNondistributableArtifactsHostnames" Data.Aeson..= allowNondistributableArtifactsHostnames | Just allowNondistributableArtifactsHostnames <- [allowNondistributableArtifactsHostnames] ]
        ++ [ "IndexConfigs" Data.Aeson..= indexConfigs | Just indexConfigs <- [indexConfigs] ]
        ++ [ "InsecureRegistryCIDRs" Data.Aeson..= insecureRegistryCIDRs | Just insecureRegistryCIDRs <- [insecureRegistryCIDRs] ]
        ++ [ "Mirrors" Data.Aeson..= mirrors | Just mirrors <- [mirrors] ])

    toEncoding RegistryServiceConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AllowNondistributableArtifactsCIDRs" . Data.Aeson.toEncoding) allowNondistributableArtifactsCIDRs <>
          maybe mempty (Data.Aeson.Encoding.pair "AllowNondistributableArtifactsHostnames" . Data.Aeson.toEncoding) allowNondistributableArtifactsHostnames <>
          maybe mempty (Data.Aeson.Encoding.pair "IndexConfigs" . Data.Aeson.toEncoding) indexConfigs <>
          maybe mempty (Data.Aeson.Encoding.pair "InsecureRegistryCIDRs" . Data.Aeson.toEncoding) insecureRegistryCIDRs <>
          maybe mempty (Data.Aeson.Encoding.pair "Mirrors" . Data.Aeson.toEncoding) mirrors
        )

instance Data.Aeson.FromJSON RegistryServiceConfig where
    parseJSON = Data.Aeson.withObject "RegistryServiceConfig" $ \o ->
        RegistryServiceConfig
            <$> o Data.Aeson..:? "AllowNondistributableArtifactsCIDRs"
            <*> o Data.Aeson..:? "AllowNondistributableArtifactsHostnames"
            <*> o Data.Aeson..:? "IndexConfigs"
            <*> o Data.Aeson..:? "InsecureRegistryCIDRs"
            <*> o Data.Aeson..:? "Mirrors"