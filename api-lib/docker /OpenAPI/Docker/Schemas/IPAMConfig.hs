{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.IPAMConfig where

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





newtype IPAMConfigAuxiliaryAddresses = IPAMConfigAuxiliaryAddresses
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON IPAMConfigAuxiliaryAddresses where
    toJSON (IPAMConfigAuxiliaryAddresses x) =
        Data.Aeson.toJSON x

    toEncoding (IPAMConfigAuxiliaryAddresses x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON IPAMConfigAuxiliaryAddresses where
    parseJSON x =
        IPAMConfigAuxiliaryAddresses <$> Data.Aeson.parseJSON x

data IPAMConfig = IPAMConfig
    {
        auxiliaryAddresses :: (Data.Maybe.Maybe (IPAMConfigAuxiliaryAddresses)),
        gateway :: (Data.Maybe.Maybe (Data.Text.Text)),
        iPRange :: (Data.Maybe.Maybe (Data.Text.Text)),
        subnet :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON IPAMConfig where
    toJSON IPAMConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "AuxiliaryAddresses" Data.Aeson..= auxiliaryAddresses | Just auxiliaryAddresses <- [auxiliaryAddresses] ]
        ++ [ "Gateway" Data.Aeson..= gateway | Just gateway <- [gateway] ]
        ++ [ "IPRange" Data.Aeson..= iPRange | Just iPRange <- [iPRange] ]
        ++ [ "Subnet" Data.Aeson..= subnet | Just subnet <- [subnet] ])

    toEncoding IPAMConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "AuxiliaryAddresses" . Data.Aeson.toEncoding) auxiliaryAddresses <>
          maybe mempty (Data.Aeson.Encoding.pair "Gateway" . Data.Aeson.toEncoding) gateway <>
          maybe mempty (Data.Aeson.Encoding.pair "IPRange" . Data.Aeson.toEncoding) iPRange <>
          maybe mempty (Data.Aeson.Encoding.pair "Subnet" . Data.Aeson.toEncoding) subnet
        )

instance Data.Aeson.FromJSON IPAMConfig where
    parseJSON = Data.Aeson.withObject "IPAMConfig" $ \o ->
        IPAMConfig
            <$> o Data.Aeson..:? "AuxiliaryAddresses"
            <*> o Data.Aeson..:? "Gateway"
            <*> o Data.Aeson..:? "IPRange"
            <*> o Data.Aeson..:? "Subnet"