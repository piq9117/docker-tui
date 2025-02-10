{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.RestartPolicy where

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





data RestartPolicyName
    = RestartPolicyName
    | RestartPolicyNameNo
    | RestartPolicyNameAlways
    | RestartPolicyNameUnlessStopped
    | RestartPolicyNameOnFailure
    deriving (Eq, Show)

instance Data.Aeson.ToJSON RestartPolicyName where
    toJSON x = case x of
        RestartPolicyName -> ""
        RestartPolicyNameNo -> "no"
        RestartPolicyNameAlways -> "always"
        RestartPolicyNameUnlessStopped -> "unless-stopped"
        RestartPolicyNameOnFailure -> "on-failure"

    toEncoding x = case x of
        RestartPolicyName -> Data.Aeson.Encoding.text ""
        RestartPolicyNameNo -> Data.Aeson.Encoding.text "no"
        RestartPolicyNameAlways -> Data.Aeson.Encoding.text "always"
        RestartPolicyNameUnlessStopped -> Data.Aeson.Encoding.text "unless-stopped"
        RestartPolicyNameOnFailure -> Data.Aeson.Encoding.text "on-failure"

instance Data.Aeson.FromJSON RestartPolicyName where
    parseJSON = Data.Aeson.withText "RestartPolicyName" $ \s ->
        case s of
            "" -> pure RestartPolicyName
            "no" -> pure RestartPolicyNameNo
            "always" -> pure RestartPolicyNameAlways
            "unless-stopped" -> pure RestartPolicyNameUnlessStopped
            "on-failure" -> pure RestartPolicyNameOnFailure
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData RestartPolicyName where
    toQueryParam x = case x of
        RestartPolicyName -> ""
        RestartPolicyNameNo -> "no"
        RestartPolicyNameAlways -> "always"
        RestartPolicyNameUnlessStopped -> "unless-stopped"
        RestartPolicyNameOnFailure -> "on-failure"

instance Web.HttpApiData.FromHttpApiData RestartPolicyName where
    parseUrlPiece x =
        case x of
            "" -> pure RestartPolicyName
            "no" -> pure RestartPolicyNameNo
            "always" -> pure RestartPolicyNameAlways
            "unless-stopped" -> pure RestartPolicyNameUnlessStopped
            "on-failure" -> pure RestartPolicyNameOnFailure
            _ -> Left "invalid enum value"

data RestartPolicy = RestartPolicy
    {
        maximumRetryCount :: (Data.Maybe.Maybe (GHC.Int.Int)),
        name :: (Data.Maybe.Maybe (RestartPolicyName))
    }
    deriving (Show)

instance Data.Aeson.ToJSON RestartPolicy where
    toJSON RestartPolicy {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "MaximumRetryCount" Data.Aeson..= maximumRetryCount | Just maximumRetryCount <- [maximumRetryCount] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ])

    toEncoding RestartPolicy {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "MaximumRetryCount" . Data.Aeson.toEncoding) maximumRetryCount <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name
        )

instance Data.Aeson.FromJSON RestartPolicy where
    parseJSON = Data.Aeson.withObject "RestartPolicy" $ \o ->
        RestartPolicy
            <$> o Data.Aeson..:? "MaximumRetryCount"
            <*> o Data.Aeson..:? "Name"