{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.EventActor where

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





newtype EventActorAttributes = EventActorAttributes
    (Data.Map.Map Data.Text.Text (Data.Text.Text))
    deriving (Show)

instance Data.Aeson.ToJSON EventActorAttributes where
    toJSON (EventActorAttributes x) =
        Data.Aeson.toJSON x

    toEncoding (EventActorAttributes x) =
        Data.Aeson.toEncoding x

instance Data.Aeson.FromJSON EventActorAttributes where
    parseJSON x =
        EventActorAttributes <$> Data.Aeson.parseJSON x

data EventActor = EventActor
    {
        attributes :: (Data.Maybe.Maybe (EventActorAttributes)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON EventActor where
    toJSON EventActor {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Attributes" Data.Aeson..= attributes | Just attributes <- [attributes] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ])

    toEncoding EventActor {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Attributes" . Data.Aeson.toEncoding) attributes <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD
        )

instance Data.Aeson.FromJSON EventActor where
    parseJSON = Data.Aeson.withObject "EventActor" $ \o ->
        EventActor
            <$> o Data.Aeson..:? "Attributes"
            <*> o Data.Aeson..:? "ID"