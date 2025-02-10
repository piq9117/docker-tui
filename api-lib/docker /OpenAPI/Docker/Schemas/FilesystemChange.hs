{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.FilesystemChange where

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



import OpenAPI.Docker.Schemas.ChangeType

data FilesystemChange = FilesystemChange
    {
        kind :: ChangeType,
        path :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON FilesystemChange where
    toJSON FilesystemChange {..} = Data.Aeson.object
        ([ "Kind" Data.Aeson..= kind,
           "Path" Data.Aeson..= path
        ]
        )

    toEncoding FilesystemChange {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Kind" (Data.Aeson.toEncoding kind) <>
          Data.Aeson.Encoding.pair "Path" (Data.Aeson.toEncoding path)
        )

instance Data.Aeson.FromJSON FilesystemChange where
    parseJSON = Data.Aeson.withObject "FilesystemChange" $ \o ->
        FilesystemChange
            <$> o Data.Aeson..: "Kind"
            <*> o Data.Aeson..: "Path"