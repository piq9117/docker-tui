{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.HealthConfig where

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





data HealthConfig = HealthConfig
    {
        interval :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        retries :: (Data.Maybe.Maybe (GHC.Int.Int)),
        startInterval :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        startPeriod :: (Data.Maybe.Maybe (GHC.Int.Int64)),
        test :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        timeout :: (Data.Maybe.Maybe (GHC.Int.Int64))
    }
    deriving (Show)

instance Data.Aeson.ToJSON HealthConfig where
    toJSON HealthConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Interval" Data.Aeson..= interval | Just interval <- [interval] ]
        ++ [ "Retries" Data.Aeson..= retries | Just retries <- [retries] ]
        ++ [ "StartInterval" Data.Aeson..= startInterval | Just startInterval <- [startInterval] ]
        ++ [ "StartPeriod" Data.Aeson..= startPeriod | Just startPeriod <- [startPeriod] ]
        ++ [ "Test" Data.Aeson..= test | Just test <- [test] ]
        ++ [ "Timeout" Data.Aeson..= timeout | Just timeout <- [timeout] ])

    toEncoding HealthConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Interval" . Data.Aeson.toEncoding) interval <>
          maybe mempty (Data.Aeson.Encoding.pair "Retries" . Data.Aeson.toEncoding) retries <>
          maybe mempty (Data.Aeson.Encoding.pair "StartInterval" . Data.Aeson.toEncoding) startInterval <>
          maybe mempty (Data.Aeson.Encoding.pair "StartPeriod" . Data.Aeson.toEncoding) startPeriod <>
          maybe mempty (Data.Aeson.Encoding.pair "Test" . Data.Aeson.toEncoding) test <>
          maybe mempty (Data.Aeson.Encoding.pair "Timeout" . Data.Aeson.toEncoding) timeout
        )

instance Data.Aeson.FromJSON HealthConfig where
    parseJSON = Data.Aeson.withObject "HealthConfig" $ \o ->
        HealthConfig
            <$> o Data.Aeson..:? "Interval"
            <*> o Data.Aeson..:? "Retries"
            <*> o Data.Aeson..:? "StartInterval"
            <*> o Data.Aeson..:? "StartPeriod"
            <*> o Data.Aeson..:? "Test"
            <*> o Data.Aeson..:? "Timeout"