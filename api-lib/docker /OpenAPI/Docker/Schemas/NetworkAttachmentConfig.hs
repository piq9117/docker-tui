{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.NetworkAttachmentConfig where

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





newtype NetworkAttachmentConfigDriverOpts = NetworkAttachmentConfigDriverOpts
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON NetworkAttachmentConfigDriverOpts where
    toJSON (NetworkAttachmentConfigDriverOpts x) =
        Data.Aeson.toJSON x

    toEncoding (NetworkAttachmentConfigDriverOpts x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NetworkAttachmentConfigDriverOpts where
    parseJSON x =
        NetworkAttachmentConfigDriverOpts <$> Data.Aeson.parseJSON x

data NetworkAttachmentConfig = NetworkAttachmentConfig
    {
        aliases :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        driverOpts :: (Data.Maybe.Maybe (NetworkAttachmentConfigDriverOpts)),
        target :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NetworkAttachmentConfig where
    toJSON NetworkAttachmentConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Aliases" Data.Aeson..= aliases | Just aliases <- [aliases] ]
        ++ [ "DriverOpts" Data.Aeson..= driverOpts | Just driverOpts <- [driverOpts] ]
        ++ [ "Target" Data.Aeson..= target | Just target <- [target] ])

    toEncoding NetworkAttachmentConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Aliases" . Data.Aeson.toEncoding) aliases <>
          maybe mempty (Data.Aeson.Encoding.pair "DriverOpts" . Data.Aeson.toEncoding) driverOpts <>
          maybe mempty (Data.Aeson.Encoding.pair "Target" . Data.Aeson.toEncoding) target
        )

instance Data.Aeson.FromJSON NetworkAttachmentConfig where
    parseJSON = Data.Aeson.withObject "NetworkAttachmentConfig" $ \o ->
        NetworkAttachmentConfig
            <$> o Data.Aeson..:? "Aliases"
            <*> o Data.Aeson..:? "DriverOpts"
            <*> o Data.Aeson..:? "Target"