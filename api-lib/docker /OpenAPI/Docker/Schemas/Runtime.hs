{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Runtime where

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





newtype RuntimeStatus = RuntimeStatus
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON RuntimeStatus where
    toJSON (RuntimeStatus x) =
        Data.Aeson.toJSON x

    toEncoding (RuntimeStatus x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON RuntimeStatus where
    parseJSON x =
        RuntimeStatus <$> Data.Aeson.parseJSON x

data Runtime = Runtime
    {
        path :: (Data.Maybe.Maybe (Data.Text.Text)),
        runtimeArgs :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        status :: (Data.Maybe.Maybe (RuntimeStatus))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Runtime where
    toJSON Runtime {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "path" Data.Aeson..= path | Just path <- [path] ]
        ++ [ "runtimeArgs" Data.Aeson..= runtimeArgs | Just runtimeArgs <- [runtimeArgs] ]
        ++ [ "status" Data.Aeson..= status | Just status <- [status] ])

    toEncoding Runtime {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "path" . Data.Aeson.toEncoding) path <>
          maybe mempty (Data.Aeson.Encoding.pair "runtimeArgs" . Data.Aeson.toEncoding) runtimeArgs <>
          maybe mempty (Data.Aeson.Encoding.pair "status" . Data.Aeson.toEncoding) status
        )

instance Data.Aeson.FromJSON Runtime where
    parseJSON = Data.Aeson.withObject "Runtime" $ \o ->
        Runtime
            <$> o Data.Aeson..:? "path"
            <*> o Data.Aeson..:? "runtimeArgs"
            <*> o Data.Aeson..:? "status"