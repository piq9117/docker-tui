{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.HealthcheckResult where

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





data HealthcheckResult = HealthcheckResult
    {
        end :: (Data.Maybe.Maybe (Data.Text.Text)),
        exitCode :: (Data.Maybe.Maybe (GHC.Int.Int)),
        output :: (Data.Maybe.Maybe (Data.Text.Text)),
        start :: (Data.Maybe.Maybe (Data.Time.UTCTime))
    }
    deriving (Show)

instance Data.Aeson.ToJSON HealthcheckResult where
    toJSON HealthcheckResult {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "End" Data.Aeson..= end | Just end <- [end] ]
        ++ [ "ExitCode" Data.Aeson..= exitCode | Just exitCode <- [exitCode] ]
        ++ [ "Output" Data.Aeson..= output | Just output <- [output] ]
        ++ [ "Start" Data.Aeson..= start | Just start <- [start] ])

    toEncoding HealthcheckResult {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "End" . Data.Aeson.toEncoding) end <>
          maybe mempty (Data.Aeson.Encoding.pair "ExitCode" . Data.Aeson.toEncoding) exitCode <>
          maybe mempty (Data.Aeson.Encoding.pair "Output" . Data.Aeson.toEncoding) output <>
          maybe mempty (Data.Aeson.Encoding.pair "Start" . Data.Aeson.toEncoding) start
        )

instance Data.Aeson.FromJSON HealthcheckResult where
    parseJSON = Data.Aeson.withObject "HealthcheckResult" $ \o ->
        HealthcheckResult
            <$> o Data.Aeson..:? "End"
            <*> o Data.Aeson..:? "ExitCode"
            <*> o Data.Aeson..:? "Output"
            <*> o Data.Aeson..:? "Start"