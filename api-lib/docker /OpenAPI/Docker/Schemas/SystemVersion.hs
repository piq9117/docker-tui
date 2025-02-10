{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.SystemVersion where

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





data SystemVersionComponents = SystemVersionComponents
    {
        details :: (Data.Maybe.Maybe (SystemVersionComponentsDetails)),
        name :: Data.Text.Text,
        version :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemVersionComponents where
    toJSON SystemVersionComponents {..} = Data.Aeson.object
        ([ "Name" Data.Aeson..= name,
           "Version" Data.Aeson..= version
        ]
        ++ [ "Details" Data.Aeson..= details | Just details <- [details] ])

    toEncoding SystemVersionComponents {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Details" . Data.Aeson.toEncoding) details <>
          Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name) <>
          Data.Aeson.Encoding.pair "Version" (Data.Aeson.toEncoding version)
        )

instance Data.Aeson.FromJSON SystemVersionComponents where
    parseJSON = Data.Aeson.withObject "SystemVersionComponents" $ \o ->
        SystemVersionComponents
            <$> o Data.Aeson..:? "Details"
            <*> o Data.Aeson..: "Name"
            <*> o Data.Aeson..: "Version"

data SystemVersionComponentsDetails = SystemVersionComponentsDetails
    {
        
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemVersionComponentsDetails where
    toJSON SystemVersionComponentsDetails {..} = Data.Aeson.object
        ([ 
        ]
        )

    toEncoding SystemVersionComponentsDetails {..} = Data.Aeson.Encoding.pairs
        ( 
        )

instance Data.Aeson.FromJSON SystemVersionComponentsDetails where
    parseJSON = Data.Aeson.withObject "SystemVersionComponentsDetails" $ \o ->
        SystemVersionComponentsDetails
            

newtype SystemVersionPlatform = SystemVersionPlatform
    {
        name :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemVersionPlatform where
    toJSON SystemVersionPlatform {..} = Data.Aeson.object
        ([ "Name" Data.Aeson..= name
        ]
        )

    toEncoding SystemVersionPlatform {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name)
        )

instance Data.Aeson.FromJSON SystemVersionPlatform where
    parseJSON = Data.Aeson.withObject "SystemVersionPlatform" $ \o ->
        SystemVersionPlatform
            <$> o Data.Aeson..: "Name"

data SystemVersion = SystemVersion
    {
        apiVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        arch :: (Data.Maybe.Maybe (Data.Text.Text)),
        buildTime :: (Data.Maybe.Maybe (Data.Text.Text)),
        components :: (Data.Maybe.Maybe ([ SystemVersionComponents ])),
        experimental :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        gitCommit :: (Data.Maybe.Maybe (Data.Text.Text)),
        goVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        kernelVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        minAPIVersion :: (Data.Maybe.Maybe (Data.Text.Text)),
        os :: (Data.Maybe.Maybe (Data.Text.Text)),
        platform :: (Data.Maybe.Maybe (SystemVersionPlatform)),
        version :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON SystemVersion where
    toJSON SystemVersion {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ApiVersion" Data.Aeson..= apiVersion | Just apiVersion <- [apiVersion] ]
        ++ [ "Arch" Data.Aeson..= arch | Just arch <- [arch] ]
        ++ [ "BuildTime" Data.Aeson..= buildTime | Just buildTime <- [buildTime] ]
        ++ [ "Components" Data.Aeson..= components | Just components <- [components] ]
        ++ [ "Experimental" Data.Aeson..= experimental | Just experimental <- [experimental] ]
        ++ [ "GitCommit" Data.Aeson..= gitCommit | Just gitCommit <- [gitCommit] ]
        ++ [ "GoVersion" Data.Aeson..= goVersion | Just goVersion <- [goVersion] ]
        ++ [ "KernelVersion" Data.Aeson..= kernelVersion | Just kernelVersion <- [kernelVersion] ]
        ++ [ "MinAPIVersion" Data.Aeson..= minAPIVersion | Just minAPIVersion <- [minAPIVersion] ]
        ++ [ "Os" Data.Aeson..= os | Just os <- [os] ]
        ++ [ "Platform" Data.Aeson..= platform | Just platform <- [platform] ]
        ++ [ "Version" Data.Aeson..= version | Just version <- [version] ])

    toEncoding SystemVersion {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ApiVersion" . Data.Aeson.toEncoding) apiVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "Arch" . Data.Aeson.toEncoding) arch <>
          maybe mempty (Data.Aeson.Encoding.pair "BuildTime" . Data.Aeson.toEncoding) buildTime <>
          maybe mempty (Data.Aeson.Encoding.pair "Components" . Data.Aeson.toEncoding) components <>
          maybe mempty (Data.Aeson.Encoding.pair "Experimental" . Data.Aeson.toEncoding) experimental <>
          maybe mempty (Data.Aeson.Encoding.pair "GitCommit" . Data.Aeson.toEncoding) gitCommit <>
          maybe mempty (Data.Aeson.Encoding.pair "GoVersion" . Data.Aeson.toEncoding) goVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "KernelVersion" . Data.Aeson.toEncoding) kernelVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "MinAPIVersion" . Data.Aeson.toEncoding) minAPIVersion <>
          maybe mempty (Data.Aeson.Encoding.pair "Os" . Data.Aeson.toEncoding) os <>
          maybe mempty (Data.Aeson.Encoding.pair "Platform" . Data.Aeson.toEncoding) platform <>
          maybe mempty (Data.Aeson.Encoding.pair "Version" . Data.Aeson.toEncoding) version
        )

instance Data.Aeson.FromJSON SystemVersion where
    parseJSON = Data.Aeson.withObject "SystemVersion" $ \o ->
        SystemVersion
            <$> o Data.Aeson..:? "ApiVersion"
            <*> o Data.Aeson..:? "Arch"
            <*> o Data.Aeson..:? "BuildTime"
            <*> o Data.Aeson..:? "Components"
            <*> o Data.Aeson..:? "Experimental"
            <*> o Data.Aeson..:? "GitCommit"
            <*> o Data.Aeson..:? "GoVersion"
            <*> o Data.Aeson..:? "KernelVersion"
            <*> o Data.Aeson..:? "MinAPIVersion"
            <*> o Data.Aeson..:? "Os"
            <*> o Data.Aeson..:? "Platform"
            <*> o Data.Aeson..:? "Version"