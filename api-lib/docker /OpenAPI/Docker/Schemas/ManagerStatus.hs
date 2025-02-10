{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ManagerStatus where

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



import OpenAPI.Docker.Schemas.Reachability

data ManagerStatus = ManagerStatus
    {
        addr :: (Data.Maybe.Maybe (Data.Text.Text)),
        leader :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        reachability :: (Data.Maybe.Maybe (Reachability))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ManagerStatus where
    toJSON ManagerStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Addr" Data.Aeson..= addr | Just addr <- [addr] ]
        ++ [ "Leader" Data.Aeson..= leader | Just leader <- [leader] ]
        ++ [ "Reachability" Data.Aeson..= reachability | Just reachability <- [reachability] ])

    toEncoding ManagerStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Addr" . Data.Aeson.toEncoding) addr <>
          maybe mempty (Data.Aeson.Encoding.pair "Leader" . Data.Aeson.toEncoding) leader <>
          maybe mempty (Data.Aeson.Encoding.pair "Reachability" . Data.Aeson.toEncoding) reachability
        )

instance Data.Aeson.FromJSON ManagerStatus where
    parseJSON = Data.Aeson.withObject "ManagerStatus" $ \o ->
        ManagerStatus
            <$> o Data.Aeson..:? "Addr"
            <*> o Data.Aeson..:? "Leader"
            <*> o Data.Aeson..:? "Reachability"