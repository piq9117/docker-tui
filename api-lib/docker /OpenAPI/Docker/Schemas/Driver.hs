{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Driver where

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





newtype DriverOptions = DriverOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON DriverOptions where
    toJSON (DriverOptions x) =
        Data.Aeson.toJSON x

    toEncoding (DriverOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON DriverOptions where
    parseJSON x =
        DriverOptions <$> Data.Aeson.parseJSON x

data Driver = Driver
    {
        name :: Data.Text.Text,
        options :: (Data.Maybe.Maybe (DriverOptions))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Driver where
    toJSON Driver {..} = Data.Aeson.object
        ([ "Name" Data.Aeson..= name
        ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ])

    toEncoding Driver {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name) <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options
        )

instance Data.Aeson.FromJSON Driver where
    parseJSON = Data.Aeson.withObject "Driver" $ \o ->
        Driver
            <$> o Data.Aeson..: "Name"
            <*> o Data.Aeson..:? "Options"