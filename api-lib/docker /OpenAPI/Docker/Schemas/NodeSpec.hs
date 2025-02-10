{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.NodeSpec where

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





data NodeSpecAvailability
    = NodeSpecAvailabilityActive
    | NodeSpecAvailabilityPause
    | NodeSpecAvailabilityDrain
    deriving (Eq, Show)

instance Data.Aeson.ToJSON NodeSpecAvailability where
    toJSON x = case x of
        NodeSpecAvailabilityActive -> "active"
        NodeSpecAvailabilityPause -> "pause"
        NodeSpecAvailabilityDrain -> "drain"

    toEncoding x = case x of
        NodeSpecAvailabilityActive -> Data.Aeson.Encoding.text "active"
        NodeSpecAvailabilityPause -> Data.Aeson.Encoding.text "pause"
        NodeSpecAvailabilityDrain -> Data.Aeson.Encoding.text "drain"

instance Data.Aeson.FromJSON NodeSpecAvailability where
    parseJSON = Data.Aeson.withText "NodeSpecAvailability" $ \s ->
        case s of
            "active" -> pure NodeSpecAvailabilityActive
            "pause" -> pure NodeSpecAvailabilityPause
            "drain" -> pure NodeSpecAvailabilityDrain
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData NodeSpecAvailability where
    toQueryParam x = case x of
        NodeSpecAvailabilityActive -> "active"
        NodeSpecAvailabilityPause -> "pause"
        NodeSpecAvailabilityDrain -> "drain"

instance Web.HttpApiData.FromHttpApiData NodeSpecAvailability where
    parseUrlPiece x =
        case x of
            "active" -> pure NodeSpecAvailabilityActive
            "pause" -> pure NodeSpecAvailabilityPause
            "drain" -> pure NodeSpecAvailabilityDrain
            _ -> Left "invalid enum value"

newtype NodeSpecLabels = NodeSpecLabels
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON NodeSpecLabels where
    toJSON (NodeSpecLabels x) =
        Data.Aeson.toJSON x

    toEncoding (NodeSpecLabels x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON NodeSpecLabels where
    parseJSON x =
        NodeSpecLabels <$> Data.Aeson.parseJSON x

data NodeSpecRole
    = NodeSpecRoleWorker
    | NodeSpecRoleManager
    deriving (Eq, Show)

instance Data.Aeson.ToJSON NodeSpecRole where
    toJSON x = case x of
        NodeSpecRoleWorker -> "worker"
        NodeSpecRoleManager -> "manager"

    toEncoding x = case x of
        NodeSpecRoleWorker -> Data.Aeson.Encoding.text "worker"
        NodeSpecRoleManager -> Data.Aeson.Encoding.text "manager"

instance Data.Aeson.FromJSON NodeSpecRole where
    parseJSON = Data.Aeson.withText "NodeSpecRole" $ \s ->
        case s of
            "worker" -> pure NodeSpecRoleWorker
            "manager" -> pure NodeSpecRoleManager
            _ -> fail "invalid enum value"

instance Web.HttpApiData.ToHttpApiData NodeSpecRole where
    toQueryParam x = case x of
        NodeSpecRoleWorker -> "worker"
        NodeSpecRoleManager -> "manager"

instance Web.HttpApiData.FromHttpApiData NodeSpecRole where
    parseUrlPiece x =
        case x of
            "worker" -> pure NodeSpecRoleWorker
            "manager" -> pure NodeSpecRoleManager
            _ -> Left "invalid enum value"

data NodeSpec = NodeSpec
    {
        availability :: (Data.Maybe.Maybe (NodeSpecAvailability)),
        labels :: (Data.Maybe.Maybe (NodeSpecLabels)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        role :: (Data.Maybe.Maybe (NodeSpecRole))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NodeSpec where
    toJSON NodeSpec {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Availability" Data.Aeson..= availability | Just availability <- [availability] ]
        ++ [ "Labels" Data.Aeson..= labels | Just labels <- [labels] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Role" Data.Aeson..= role | Just role <- [role] ])

    toEncoding NodeSpec {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Availability" . Data.Aeson.toEncoding) availability <>
          maybe mempty (Data.Aeson.Encoding.pair "Labels" . Data.Aeson.toEncoding) labels <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Role" . Data.Aeson.toEncoding) role
        )

instance Data.Aeson.FromJSON NodeSpec where
    parseJSON = Data.Aeson.withObject "NodeSpec" $ \o ->
        NodeSpec
            <$> o Data.Aeson..:? "Availability"
            <*> o Data.Aeson..:? "Labels"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Role"