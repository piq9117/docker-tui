{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ClusterInfo where

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



import OpenAPI.Docker.Schemas.ObjectVersion
import OpenAPI.Docker.Schemas.SwarmSpec
import OpenAPI.Docker.Schemas.TLSInfo

data ClusterInfo = ClusterInfo
    {
        createdAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        dataPathPort :: (Data.Maybe.Maybe (GHC.Int.Int)),
        defaultAddrPool :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        rootRotationInProgress :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        spec :: (Data.Maybe.Maybe (SwarmSpec)),
        subnetSize :: (Data.Maybe.Maybe (GHC.Int.Int)),
        tLSInfo :: (Data.Maybe.Maybe (TLSInfo)),
        updatedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        version :: (Data.Maybe.Maybe (ObjectVersion))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ClusterInfo where
    toJSON ClusterInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CreatedAt" Data.Aeson..= createdAt | Just createdAt <- [createdAt] ]
        ++ [ "DataPathPort" Data.Aeson..= dataPathPort | Just dataPathPort <- [dataPathPort] ]
        ++ [ "DefaultAddrPool" Data.Aeson..= defaultAddrPool | Just defaultAddrPool <- [defaultAddrPool] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "RootRotationInProgress" Data.Aeson..= rootRotationInProgress | Just rootRotationInProgress <- [rootRotationInProgress] ]
        ++ [ "Spec" Data.Aeson..= spec | Just spec <- [spec] ]
        ++ [ "SubnetSize" Data.Aeson..= subnetSize | Just subnetSize <- [subnetSize] ]
        ++ [ "TLSInfo" Data.Aeson..= tLSInfo | Just tLSInfo <- [tLSInfo] ]
        ++ [ "UpdatedAt" Data.Aeson..= updatedAt | Just updatedAt <- [updatedAt] ]
        ++ [ "Version" Data.Aeson..= version | Just version <- [version] ])

    toEncoding ClusterInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CreatedAt" . Data.Aeson.toEncoding) createdAt <>
          maybe mempty (Data.Aeson.Encoding.pair "DataPathPort" . Data.Aeson.toEncoding) dataPathPort <>
          maybe mempty (Data.Aeson.Encoding.pair "DefaultAddrPool" . Data.Aeson.toEncoding) defaultAddrPool <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "RootRotationInProgress" . Data.Aeson.toEncoding) rootRotationInProgress <>
          maybe mempty (Data.Aeson.Encoding.pair "Spec" . Data.Aeson.toEncoding) spec <>
          maybe mempty (Data.Aeson.Encoding.pair "SubnetSize" . Data.Aeson.toEncoding) subnetSize <>
          maybe mempty (Data.Aeson.Encoding.pair "TLSInfo" . Data.Aeson.toEncoding) tLSInfo <>
          maybe mempty (Data.Aeson.Encoding.pair "UpdatedAt" . Data.Aeson.toEncoding) updatedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Version" . Data.Aeson.toEncoding) version
        )

instance Data.Aeson.FromJSON ClusterInfo where
    parseJSON = Data.Aeson.withObject "ClusterInfo" $ \o ->
        ClusterInfo
            <$> o Data.Aeson..:? "CreatedAt"
            <*> o Data.Aeson..:? "DataPathPort"
            <*> o Data.Aeson..:? "DefaultAddrPool"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "RootRotationInProgress"
            <*> o Data.Aeson..:? "Spec"
            <*> o Data.Aeson..:? "SubnetSize"
            <*> o Data.Aeson..:? "TLSInfo"
            <*> o Data.Aeson..:? "UpdatedAt"
            <*> o Data.Aeson..:? "Version"