{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.IndexInfo where

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





data IndexInfo = IndexInfo
    {
        mirrors :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        official :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        secure :: (Data.Maybe.Maybe (GHC.Types.Bool))
    }
    deriving (Show)

instance Data.Aeson.ToJSON IndexInfo where
    toJSON IndexInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Mirrors" Data.Aeson..= mirrors | Just mirrors <- [mirrors] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Official" Data.Aeson..= official | Just official <- [official] ]
        ++ [ "Secure" Data.Aeson..= secure | Just secure <- [secure] ])

    toEncoding IndexInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Mirrors" . Data.Aeson.toEncoding) mirrors <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Official" . Data.Aeson.toEncoding) official <>
          maybe mempty (Data.Aeson.Encoding.pair "Secure" . Data.Aeson.toEncoding) secure
        )

instance Data.Aeson.FromJSON IndexInfo where
    parseJSON = Data.Aeson.withObject "IndexInfo" $ \o ->
        IndexInfo
            <$> o Data.Aeson..:? "Mirrors"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Official"
            <*> o Data.Aeson..:? "Secure"