{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.IPAM where

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



import OpenAPI.Docker.Schemas.IPAMConfig

newtype IPAMOptions = IPAMOptions
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON IPAMOptions where
    toJSON (IPAMOptions x) =
        Data.Aeson.toJSON x

    toEncoding (IPAMOptions x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON IPAMOptions where
    parseJSON x =
        IPAMOptions <$> Data.Aeson.parseJSON x

data IPAM = IPAM
    {
        config :: (Data.Maybe.Maybe ([ IPAMConfig ])),
        driver :: (Data.Maybe.Maybe (Data.Text.Text)),
        options :: (Data.Maybe.Maybe (IPAMOptions))
    }
    deriving (Show)

instance Data.Aeson.ToJSON IPAM where
    toJSON IPAM {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Config" Data.Aeson..= config | Just config <- [config] ]
        ++ [ "Driver" Data.Aeson..= driver | Just driver <- [driver] ]
        ++ [ "Options" Data.Aeson..= options | Just options <- [options] ])

    toEncoding IPAM {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Config" . Data.Aeson.toEncoding) config <>
          maybe mempty (Data.Aeson.Encoding.pair "Driver" . Data.Aeson.toEncoding) driver <>
          maybe mempty (Data.Aeson.Encoding.pair "Options" . Data.Aeson.toEncoding) options
        )

instance Data.Aeson.FromJSON IPAM where
    parseJSON = Data.Aeson.withObject "IPAM" $ \o ->
        IPAM
            <$> o Data.Aeson..:? "Config"
            <*> o Data.Aeson..:? "Driver"
            <*> o Data.Aeson..:? "Options"