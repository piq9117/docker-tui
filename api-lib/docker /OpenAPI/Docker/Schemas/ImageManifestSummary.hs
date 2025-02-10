{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ImageManifestSummary where

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



import OpenAPI.Docker.Schemas.OCIDescriptor
import OpenAPI.Docker.Schemas.OCIPlatform

newtype ImageManifestSummaryAttestationData = ImageManifestSummaryAttestationData
    {
        for :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageManifestSummaryAttestationData where
    toJSON ImageManifestSummaryAttestationData {..} = Data.Aeson.object
        ([ "For" Data.Aeson..= for
        ]
        )

    toEncoding ImageManifestSummaryAttestationData {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "For" (Data.Aeson.toEncoding for)
        )

instance Data.Aeson.FromJSON ImageManifestSummaryAttestationData where
    parseJSON = Data.Aeson.withObject "ImageManifestSummaryAttestationData" $ \o ->
        ImageManifestSummaryAttestationData
            <$> o Data.Aeson..: "For"

data ImageManifestSummaryImageData = ImageManifestSummaryImageData
    {
        containers :: [ Data.Text.Text ],
        platform :: OCIPlatform,
        size :: ImageManifestSummaryImageDataSize
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageManifestSummaryImageData where
    toJSON ImageManifestSummaryImageData {..} = Data.Aeson.object
        ([ "Containers" Data.Aeson..= containers,
           "Platform" Data.Aeson..= platform,
           "Size" Data.Aeson..= size
        ]
        )

    toEncoding ImageManifestSummaryImageData {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Containers" (Data.Aeson.toEncoding containers) <>
          Data.Aeson.Encoding.pair "Platform" (Data.Aeson.toEncoding platform) <>
          Data.Aeson.Encoding.pair "Size" (Data.Aeson.toEncoding size)
        )

instance Data.Aeson.FromJSON ImageManifestSummaryImageData where
    parseJSON = Data.Aeson.withObject "ImageManifestSummaryImageData" $ \o ->
        ImageManifestSummaryImageData
            <$> o Data.Aeson..: "Containers"
            <*> o Data.Aeson..: "Platform"
            <*> o Data.Aeson..: "Size"

newtype ImageManifestSummaryImageDataSize = ImageManifestSummaryImageDataSize
    {
        unpacked :: GHC.Int.Int64
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageManifestSummaryImageDataSize where
    toJSON ImageManifestSummaryImageDataSize {..} = Data.Aeson.object
        ([ "Unpacked" Data.Aeson..= unpacked
        ]
        )

    toEncoding ImageManifestSummaryImageDataSize {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Unpacked" (Data.Aeson.toEncoding unpacked)
        )

instance Data.Aeson.FromJSON ImageManifestSummaryImageDataSize where
    parseJSON = Data.Aeson.withObject "ImageManifestSummaryImageDataSize" $ \o ->
        ImageManifestSummaryImageDataSize
            <$> o Data.Aeson..: "Unpacked"

data ImageManifestSummaryKind
    = ImageManifestSummaryKindImage
    | ImageManifestSummaryKindAttestation
    | ImageManifestSummaryKindUnknown
    deriving (Eq, Show)

instance Data.Aeson.ToJSON ImageManifestSummaryKind where
    toJSON x = case x of
        ImageManifestSummaryKindImage -> "image"
        ImageManifestSummaryKindAttestation -> "attestation"
        ImageManifestSummaryKindUnknown -> "unknown"

    toEncoding x = case x of
        ImageManifestSummaryKindImage -> Data.Aeson.Encoding.text "image"
        ImageManifestSummaryKindAttestation -> Data.Aeson.Encoding.text "attestation"
        ImageManifestSummaryKindUnknown -> Data.Aeson.Encoding.text "unknown"

instance Data.Aeson.FromJSON ImageManifestSummaryKind where
    parseJSON = Data.Aeson.withText "ImageManifestSummaryKind" $ \s ->
        case s of
            "image" -> pure ImageManifestSummaryKindImage
            "attestation" -> pure ImageManifestSummaryKindAttestation
            "unknown" -> pure ImageManifestSummaryKindUnknown
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData ImageManifestSummaryKind where
    toQueryParam x = case x of
        ImageManifestSummaryKindImage -> "image"
        ImageManifestSummaryKindAttestation -> "attestation"
        ImageManifestSummaryKindUnknown -> "unknown"

instance Web.HttpApiData.FromHttpApiData ImageManifestSummaryKind where
    parseUrlPiece x =
        case x of
            "image" -> pure ImageManifestSummaryKindImage
            "attestation" -> pure ImageManifestSummaryKindAttestation
            "unknown" -> pure ImageManifestSummaryKindUnknown
            _ -> Left "invalid enum value"

data ImageManifestSummarySize = ImageManifestSummarySize
    {
        content :: GHC.Int.Int64,
        total :: GHC.Int.Int64
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageManifestSummarySize where
    toJSON ImageManifestSummarySize {..} = Data.Aeson.object
        ([ "Content" Data.Aeson..= content,
           "Total" Data.Aeson..= total
        ]
        )

    toEncoding ImageManifestSummarySize {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Content" (Data.Aeson.toEncoding content) <>
          Data.Aeson.Encoding.pair "Total" (Data.Aeson.toEncoding total)
        )

instance Data.Aeson.FromJSON ImageManifestSummarySize where
    parseJSON = Data.Aeson.withObject "ImageManifestSummarySize" $ \o ->
        ImageManifestSummarySize
            <$> o Data.Aeson..: "Content"
            <*> o Data.Aeson..: "Total"

data ImageManifestSummary = ImageManifestSummary
    {
        attestationData :: (Data.Maybe.Maybe (ImageManifestSummaryAttestationData)),
        available :: GHC.Types.Bool,
        descriptor :: OCIDescriptor,
        iD :: Data.Text.Text,
        imageData :: (Data.Maybe.Maybe (ImageManifestSummaryImageData)),
        kind :: ImageManifestSummaryKind,
        size :: ImageManifestSummarySize
    }
    deriving (Show)

instance Data.Aeson.ToJSON ImageManifestSummary where
    toJSON ImageManifestSummary {..} = Data.Aeson.object
        ([ "Available" Data.Aeson..= available,
           "Descriptor" Data.Aeson..= descriptor,
           "ID" Data.Aeson..= iD,
           "Kind" Data.Aeson..= kind,
           "Size" Data.Aeson..= size
        ]
        ++ [ "AttestationData" Data.Aeson..= attestationData | Just attestationData <- [attestationData] ]
        ++ [ "ImageData" Data.Aeson..= imageData | Just imageData <- [imageData] ])

    toEncoding ImageManifestSummary {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AttestationData" . Data.Aeson.toEncoding) attestationData <>
          Data.Aeson.Encoding.pair "Available" (Data.Aeson.toEncoding available) <>
          Data.Aeson.Encoding.pair "Descriptor" (Data.Aeson.toEncoding descriptor) <>
          Data.Aeson.Encoding.pair "ID" (Data.Aeson.toEncoding iD) <>
          maybe mempty (Data.Aeson.Encoding.pair "ImageData" . Data.Aeson.toEncoding) imageData <>
          Data.Aeson.Encoding.pair "Kind" (Data.Aeson.toEncoding kind) <>
          Data.Aeson.Encoding.pair "Size" (Data.Aeson.toEncoding size)
        )

instance Data.Aeson.FromJSON ImageManifestSummary where
    parseJSON = Data.Aeson.withObject "ImageManifestSummary" $ \o ->
        ImageManifestSummary
            <$> o Data.Aeson..:? "AttestationData"
            <*> o Data.Aeson..: "Available"
            <*> o Data.Aeson..: "Descriptor"
            <*> o Data.Aeson..: "ID"
            <*> o Data.Aeson..:? "ImageData"
            <*> o Data.Aeson..: "Kind"
            <*> o Data.Aeson..: "Size"