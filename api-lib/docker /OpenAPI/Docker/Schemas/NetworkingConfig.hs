{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.NetworkingConfig where

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



import OpenAPI.Docker.Schemas.EndpointSettings

newtype NetworkingConfigEndpointsConfig = NetworkingConfigEndpointsConfig
    (Data.Map.Map Data.Text.Text (EndpointSettings))
    deriving (Show)

instance Data.Aeson.ToJSON NetworkingConfigEndpointsConfig where
    toJSON (NetworkingConfigEndpointsConfig x) =
        Data.Aeson.toJSON x

    toEncoding (NetworkingConfigEndpointsConfig x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NetworkingConfigEndpointsConfig where
    parseJSON x =
        NetworkingConfigEndpointsConfig <$> Data.Aeson.parseJSON x

newtype NetworkingConfig = NetworkingConfig
    {
        endpointsConfig :: (Data.Maybe.Maybe (NetworkingConfigEndpointsConfig))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NetworkingConfig where
    toJSON NetworkingConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "EndpointsConfig" Data.Aeson..= endpointsConfig | Just endpointsConfig <- [endpointsConfig] ])

    toEncoding NetworkingConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "EndpointsConfig" . Data.Aeson.toEncoding) endpointsConfig
        )

instance Data.Aeson.FromJSON NetworkingConfig where
    parseJSON = Data.Aeson.withObject "NetworkingConfig" $ \o ->
        NetworkingConfig
            <$> o Data.Aeson..:? "EndpointsConfig"