{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Reachability where

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





data Reachability
    = ReachabilityUnknown
    | ReachabilityUnreachable
    | ReachabilityReachable
    deriving (Eq, Show)

instance Data.Aeson.ToJSON Reachability where
    toJSON x = case x of
        ReachabilityUnknown -> "unknown"
        ReachabilityUnreachable -> "unreachable"
        ReachabilityReachable -> "reachable"

    toEncoding x = case x of
        ReachabilityUnknown -> Data.Aeson.Encoding.text "unknown"
        ReachabilityUnreachable -> Data.Aeson.Encoding.text "unreachable"
        ReachabilityReachable -> Data.Aeson.Encoding.text "reachable"

instance Data.Aeson.FromJSON Reachability where
    parseJSON = Data.Aeson.withText "Reachability" $ \s ->
        case s of
            "unknown" -> pure ReachabilityUnknown
            "unreachable" -> pure ReachabilityUnreachable
            "reachable" -> pure ReachabilityReachable
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData Reachability where
    toQueryParam x = case x of
        ReachabilityUnknown -> "unknown"
        ReachabilityUnreachable -> "unreachable"
        ReachabilityReachable -> "reachable"

instance Web.HttpApiData.FromHttpApiData Reachability where
    parseUrlPiece x =
        case x of
            "unknown" -> pure ReachabilityUnknown
            "unreachable" -> pure ReachabilityUnreachable
            "reachable" -> pure ReachabilityReachable
            _ -> Left "invalid enum value"