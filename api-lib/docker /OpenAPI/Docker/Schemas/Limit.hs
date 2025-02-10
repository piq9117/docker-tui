{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Limit where

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





data Limit = Limit
    {
        memoryBytes :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        nanoCPUs :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        pids :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Limit where
    toJSON Limit {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "MemoryBytes" Data.Aeson..= memoryBytes | Just memoryBytes <- [memoryBytes] ]
        ++ [ "NanoCPUs" Data.Aeson..= nanoCPUs | Just nanoCPUs <- [nanoCPUs] ]
        ++ [ "Pids" Data.Aeson..= pids | Just pids <- [pids] ])

    toEncoding Limit {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "MemoryBytes" . Data.Aeson.toEncoding) memoryBytes <>
          maybe mempty (Data.Aeson.Encoding.pair "NanoCPUs" . Data.Aeson.toEncoding) nanoCPUs <>
          maybe mempty (Data.Aeson.Encoding.pair "Pids" . Data.Aeson.toEncoding) pids
        )

instance Data.Aeson.FromJSON Limit where
    parseJSON = Data.Aeson.withObject "Limit" $ \o ->
        Limit
            <$> o Data.Aeson..:? "MemoryBytes"
            <*> o Data.Aeson..:? "NanoCPUs"
            <*> o Data.Aeson..:? "Pids"