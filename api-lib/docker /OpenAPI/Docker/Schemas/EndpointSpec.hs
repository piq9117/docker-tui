{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.EndpointSpec where

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



import OpenAPI.Docker.Schemas.EndpointPortConfig

data EndpointSpecMode
    = EndpointSpecModeVip
    | EndpointSpecModeDnsrr
    deriving (Eq, Show)

instance Data.Aeson.ToJSON EndpointSpecMode where
    toJSON x = case x of
        EndpointSpecModeVip -> "vip"
        EndpointSpecModeDnsrr -> "dnsrr"

    toEncoding x = case x of
        EndpointSpecModeVip -> Data.Aeson.Encoding.text "vip"
        EndpointSpecModeDnsrr -> Data.Aeson.Encoding.text "dnsrr"

instance Data.Aeson.FromJSON EndpointSpecMode where
    parseJSON = Data.Aeson.withText "EndpointSpecMode" $ \s ->
        case s of
            "vip" -> pure EndpointSpecModeVip
            "dnsrr" -> pure EndpointSpecModeDnsrr
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData EndpointSpecMode where
    toQueryParam x = case x of
        EndpointSpecModeVip -> "vip"
        EndpointSpecModeDnsrr -> "dnsrr"

instance Web.HttpApiData.FromHttpApiData EndpointSpecMode where
    parseUrlPiece x =
        case x of
            "vip" -> pure EndpointSpecModeVip
            "dnsrr" -> pure EndpointSpecModeDnsrr
            _ -> Left "invalid enum value"

data EndpointSpec = EndpointSpec
    {
        mode :: (Data.Maybe.Maybe (EndpointSpecMode)),
        ports :: (Data.Maybe.Maybe ([ EndpointPortConfig ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON EndpointSpec where
    toJSON EndpointSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Mode" Data.Aeson..= mode | Just mode <- [mode] ]
        ++ [ "Ports" Data.Aeson..= ports | Just ports <- [ports] ])

    toEncoding EndpointSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Mode" . Data.Aeson.toEncoding) mode <>
          maybe mempty (Data.Aeson.Encoding.pair "Ports" . Data.Aeson.toEncoding) ports
        )

instance Data.Aeson.FromJSON EndpointSpec where
    parseJSON = Data.Aeson.withObject "EndpointSpec" $ \o ->
        EndpointSpec
            <$> o Data.Aeson..:? "Mode"
            <*> o Data.Aeson..:? "Ports"