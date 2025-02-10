{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Platform where

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





data Platform = Platform
    {
        architecture :: (Data.Maybe.Maybe (Data.Text.Text)),
        oS :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Platform where
    toJSON Platform {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Architecture" Data.Aeson..= architecture | Just architecture <- [architecture] ]
        ++ [ "OS" Data.Aeson..= oS | Just oS <- [oS] ])

    toEncoding Platform {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Architecture" . Data.Aeson.toEncoding) architecture <>
          maybe mempty (Data.Aeson.Encoding.pair "OS" . Data.Aeson.toEncoding) oS
        )

instance Data.Aeson.FromJSON Platform where
    parseJSON = Data.Aeson.withObject "Platform" $ \o ->
        Platform
            <$> o Data.Aeson..:? "Architecture"
            <*> o Data.Aeson..:? "OS"