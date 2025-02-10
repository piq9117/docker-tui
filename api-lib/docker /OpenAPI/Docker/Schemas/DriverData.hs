{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.DriverData where

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





newtype DriverDataData = DriverDataData
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON DriverDataData where
    toJSON (DriverDataData x) =
        Data.Aeson.toJSON x

    toEncoding (DriverDataData x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON DriverDataData where
    parseJSON x =
        DriverDataData <$> Data.Aeson.parseJSON x

data DriverData = DriverData
    {
        data' :: DriverDataData,
        name :: Data.Text.Text
    }
    deriving (Show)

instance Data.Aeson.ToJSON DriverData where
    toJSON DriverData {..} = Data.Aeson.object
        ([ "Data" Data.Aeson..= data',
           "Name" Data.Aeson..= name
        ]
        )

    toEncoding DriverData {..} = Data.Aeson.Encoding.pairs
        ( Data.Aeson.Encoding.pair "Data" (Data.Aeson.toEncoding data') <>
          Data.Aeson.Encoding.pair "Name" (Data.Aeson.toEncoding name)
        )

instance Data.Aeson.FromJSON DriverData where
    parseJSON = Data.Aeson.withObject "DriverData" $ \o ->
        DriverData
            <$> o Data.Aeson..: "Data"
            <*> o Data.Aeson..: "Name"