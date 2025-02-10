{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Address where

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





data Address = Address
    {
        addr :: (Data.Maybe.Maybe (Data.Text.Text)),
        prefixLen :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Address where
    toJSON Address {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Addr" Data.Aeson..= addr | Just addr <- [addr] ]
        ++ [ "PrefixLen" Data.Aeson..= prefixLen | Just prefixLen <- [prefixLen] ])

    toEncoding Address {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Addr" . Data.Aeson.toEncoding) addr <>
          maybe mempty (Data.Aeson.Encoding.pair "PrefixLen" . Data.Aeson.toEncoding) prefixLen
        )

instance Data.Aeson.FromJSON Address where
    parseJSON = Data.Aeson.withObject "Address" $ \o ->
        Address
            <$> o Data.Aeson..:? "Addr"
            <*> o Data.Aeson..:? "PrefixLen"