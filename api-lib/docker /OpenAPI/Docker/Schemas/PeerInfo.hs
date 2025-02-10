{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.PeerInfo where

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





data PeerInfo = PeerInfo
    {
        iP :: (Data.Maybe.Maybe (Data.Text.Text)),
        name :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON PeerInfo where
    toJSON PeerInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "IP" Data.Aeson..= iP | Just iP <- [iP] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ])

    toEncoding PeerInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "IP" . Data.Aeson.toEncoding) iP <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name
        )

instance Data.Aeson.FromJSON PeerInfo where
    parseJSON = Data.Aeson.withObject "PeerInfo" $ \o ->
        PeerInfo
            <$> o Data.Aeson..:? "IP"
            <*> o Data.Aeson..:? "Name"