{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.PortBinding where

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





data PortBinding = PortBinding
    {
        hostIp :: (Data.Maybe.Maybe (Data.Text.Text)),
        hostPort :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON PortBinding where
    toJSON PortBinding {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "HostIp" Data.Aeson..= hostIp | Just hostIp <- [hostIp] ]
        ++ [ "HostPort" Data.Aeson..= hostPort | Just hostPort <- [hostPort] ])

    toEncoding PortBinding {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "HostIp" . Data.Aeson.toEncoding) hostIp <>
          maybe mempty (Data.Aeson.Encoding.pair "HostPort" . Data.Aeson.toEncoding) hostPort
        )

instance Data.Aeson.FromJSON PortBinding where
    parseJSON = Data.Aeson.withObject "PortBinding" $ \o ->
        PortBinding
            <$> o Data.Aeson..:? "HostIp"
            <*> o Data.Aeson..:? "HostPort"