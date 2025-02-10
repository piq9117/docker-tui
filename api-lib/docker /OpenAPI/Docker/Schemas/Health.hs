{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Health where

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



import OpenAPI.Docker.Schemas.HealthcheckResult

data HealthStatus
    = HealthStatusNone
    | HealthStatusStarting
    | HealthStatusHealthy
    | HealthStatusUnhealthy
    deriving (Eq, Show)

instance Data.Aeson.ToJSON HealthStatus where
    toJSON x = case x of
        HealthStatusNone -> "none"
        HealthStatusStarting -> "starting"
        HealthStatusHealthy -> "healthy"
        HealthStatusUnhealthy -> "unhealthy"

    toEncoding x = case x of
        HealthStatusNone -> Data.Aeson.Encoding.text "none"
        HealthStatusStarting -> Data.Aeson.Encoding.text "starting"
        HealthStatusHealthy -> Data.Aeson.Encoding.text "healthy"
        HealthStatusUnhealthy -> Data.Aeson.Encoding.text "unhealthy"

instance Data.Aeson.FromJSON HealthStatus where
    parseJSON = Data.Aeson.withText "HealthStatus" $ \s ->
        case s of
            "none" -> pure HealthStatusNone
            "starting" -> pure HealthStatusStarting
            "healthy" -> pure HealthStatusHealthy
            "unhealthy" -> pure HealthStatusUnhealthy
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData HealthStatus where
    toQueryParam x = case x of
        HealthStatusNone -> "none"
        HealthStatusStarting -> "starting"
        HealthStatusHealthy -> "healthy"
        HealthStatusUnhealthy -> "unhealthy"

instance Web.HttpApiData.FromHttpApiData HealthStatus where
    parseUrlPiece x =
        case x of
            "none" -> pure HealthStatusNone
            "starting" -> pure HealthStatusStarting
            "healthy" -> pure HealthStatusHealthy
            "unhealthy" -> pure HealthStatusUnhealthy
            _ -> Left "invalid enum value"

data Health = Health
    {
        failingStreak :: (Data.Maybe.Maybe (GHC.Int.Int)),
        log :: (Data.Maybe.Maybe ([ HealthcheckResult ])),
        status :: (Data.Maybe.Maybe (HealthStatus))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Health where
    toJSON Health {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "FailingStreak" Data.Aeson..= failingStreak | Just failingStreak <- [failingStreak] ]
        ++ [ "Log" Data.Aeson..= log | Just log <- [log] ]
        ++ [ "Status" Data.Aeson..= status | Just status <- [status] ])

    toEncoding Health {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "FailingStreak" . Data.Aeson.toEncoding) failingStreak <>
          maybe mempty (Data.Aeson.Encoding.pair "Log" . Data.Aeson.toEncoding) log <>
          maybe mempty (Data.Aeson.Encoding.pair "Status" . Data.Aeson.toEncoding) status
        )

instance Data.Aeson.FromJSON Health where
    parseJSON = Data.Aeson.withObject "Health" $ \o ->
        Health
            <$> o Data.Aeson..:? "FailingStreak"
            <*> o Data.Aeson..:? "Log"
            <*> o Data.Aeson..:? "Status"