{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.BuildCache where

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





data BuildCacheType
    = BuildCacheTypeInternal
    | BuildCacheTypeFrontend
    | BuildCacheTypeSource.local
    | BuildCacheTypeSource.git.checkout
    | BuildCacheTypeExec.cachemount
    | BuildCacheTypeRegular
    deriving (Eq, Show)

instance Data.Aeson.ToJSON BuildCacheType where
    toJSON x = case x of
        BuildCacheTypeInternal -> "internal"
        BuildCacheTypeFrontend -> "frontend"
        BuildCacheTypeSource.local -> "source.local"
        BuildCacheTypeSource.git.checkout -> "source.git.checkout"
        BuildCacheTypeExec.cachemount -> "exec.cachemount"
        BuildCacheTypeRegular -> "regular"

    toEncoding x = case x of
        BuildCacheTypeInternal -> Data.Aeson.Encoding.text "internal"
        BuildCacheTypeFrontend -> Data.Aeson.Encoding.text "frontend"
        BuildCacheTypeSource.local -> Data.Aeson.Encoding.text "source.local"
        BuildCacheTypeSource.git.checkout -> Data.Aeson.Encoding.text "source.git.checkout"
        BuildCacheTypeExec.cachemount -> Data.Aeson.Encoding.text "exec.cachemount"
        BuildCacheTypeRegular -> Data.Aeson.Encoding.text "regular"

instance Data.Aeson.FromJSON BuildCacheType where
    parseJSON = Data.Aeson.withText "BuildCacheType" $ \s ->
        case s of
            "internal" -> pure BuildCacheTypeInternal
            "frontend" -> pure BuildCacheTypeFrontend
            "source.local" -> pure BuildCacheTypeSource.local
            "source.git.checkout" -> pure BuildCacheTypeSource.git.checkout
            "exec.cachemount" -> pure BuildCacheTypeExec.cachemount
            "regular" -> pure BuildCacheTypeRegular
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData BuildCacheType where
    toQueryParam x = case x of
        BuildCacheTypeInternal -> "internal"
        BuildCacheTypeFrontend -> "frontend"
        BuildCacheTypeSource.local -> "source.local"
        BuildCacheTypeSource.git.checkout -> "source.git.checkout"
        BuildCacheTypeExec.cachemount -> "exec.cachemount"
        BuildCacheTypeRegular -> "regular"

instance Web.HttpApiData.FromHttpApiData BuildCacheType where
    parseUrlPiece x =
        case x of
            "internal" -> pure BuildCacheTypeInternal
            "frontend" -> pure BuildCacheTypeFrontend
            "source.local" -> pure BuildCacheTypeSource.local
            "source.git.checkout" -> pure BuildCacheTypeSource.git.checkout
            "exec.cachemount" -> pure BuildCacheTypeExec.cachemount
            "regular" -> pure BuildCacheTypeRegular
            _ -> Left "invalid enum value"

data BuildCache = BuildCache
    {
        createdAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        description :: (Data.Maybe.Maybe (Data.Text.Text)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        inUse :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        lastUsedAt :: (Data.Maybe.Maybe (Data.Text.Text)),
        parent :: (Data.Maybe.Maybe (Data.Text.Text)),
        parents :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        shared :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        size :: (Data.Maybe.Maybe (GHC.Int.Int)),
        type' :: (Data.Maybe.Maybe (BuildCacheType)),
        usageCount :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON BuildCache where
    toJSON BuildCache {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CreatedAt" Data.Aeson..= createdAt | Just createdAt <- [createdAt] ]
        ++ [ "Description" Data.Aeson..= description | Just description <- [description] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "InUse" Data.Aeson..= inUse | Just inUse <- [inUse] ]
        ++ [ "LastUsedAt" Data.Aeson..= lastUsedAt | Just lastUsedAt <- [lastUsedAt] ]
        ++ [ "Parent" Data.Aeson..= parent | Just parent <- [parent] ]
        ++ [ "Parents" Data.Aeson..= parents | Just parents <- [parents] ]
        ++ [ "Shared" Data.Aeson..= shared | Just shared <- [shared] ]
        ++ [ "Size" Data.Aeson..= size | Just size <- [size] ]
        ++ [ "Type" Data.Aeson..= type' | Just type' <- [type'] ]
        ++ [ "UsageCount" Data.Aeson..= usageCount | Just usageCount <- [usageCount] ])

    toEncoding BuildCache {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CreatedAt" . Data.Aeson.toEncoding) createdAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Description" . Data.Aeson.toEncoding) description <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "InUse" . Data.Aeson.toEncoding) inUse <>
          maybe mempty (Data.Aeson.Encoding.pair "LastUsedAt" . Data.Aeson.toEncoding) lastUsedAt <>
          maybe mempty (Data.Aeson.Encoding.pair "Parent" . Data.Aeson.toEncoding) parent <>
          maybe mempty (Data.Aeson.Encoding.pair "Parents" . Data.Aeson.toEncoding) parents <>
          maybe mempty (Data.Aeson.Encoding.pair "Shared" . Data.Aeson.toEncoding) shared <>
          maybe mempty (Data.Aeson.Encoding.pair "Size" . Data.Aeson.toEncoding) size <>
          maybe mempty (Data.Aeson.Encoding.pair "Type" . Data.Aeson.toEncoding) type' <>
          maybe mempty (Data.Aeson.Encoding.pair "UsageCount" . Data.Aeson.toEncoding) usageCount
        )

instance Data.Aeson.FromJSON BuildCache where
    parseJSON = Data.Aeson.withObject "BuildCache" $ \o ->
        BuildCache
            <$> o Data.Aeson..:? "CreatedAt"
            <*> o Data.Aeson..:? "Description"
            <*> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "InUse"
            <*> o Data.Aeson..:? "LastUsedAt"
            <*> o Data.Aeson..:? "Parent"
            <*> o Data.Aeson..:? "Parents"
            <*> o Data.Aeson..:? "Shared"
            <*> o Data.Aeson..:? "Size"
            <*> o Data.Aeson..:? "Type"
            <*> o Data.Aeson..:? "UsageCount"