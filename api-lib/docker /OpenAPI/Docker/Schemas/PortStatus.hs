{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.PortStatus where

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

newtype PortStatus = PortStatus
    {
        ports :: (Data.Maybe.Maybe ([ EndpointPortConfig ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON PortStatus where
    toJSON PortStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Ports" Data.Aeson..= ports | Just ports <- [ports] ])

    toEncoding PortStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Ports" . Data.Aeson.toEncoding) ports
        )

instance Data.Aeson.FromJSON PortStatus where
    parseJSON = Data.Aeson.withObject "PortStatus" $ \o ->
        PortStatus
            <$> o Data.Aeson..:? "Ports"