{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.NodeStatus where

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



import OpenAPI.Docker.Schemas.NodeState

data NodeStatus = NodeStatus
    {
        addr :: (Data.Maybe.Maybe (Data.Text.Text)),
        message :: (Data.Maybe.Maybe (Data.Text.Text)),
        state :: (Data.Maybe.Maybe (NodeState))
    }
    deriving (Show)

instance Data.Aeson.ToJSON NodeStatus where
    toJSON NodeStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Addr" Data.Aeson..= addr | Just addr <- [addr] ]
        ++ [ "Message" Data.Aeson..= message | Just message <- [message] ]
        ++ [ "State" Data.Aeson..= state | Just state <- [state] ])

    toEncoding NodeStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Addr" . Data.Aeson.toEncoding) addr <>
          maybe mempty (Data.Aeson.Encoding.pair "Message" . Data.Aeson.toEncoding) message <>
          maybe mempty (Data.Aeson.Encoding.pair "State" . Data.Aeson.toEncoding) state
        )

instance Data.Aeson.FromJSON NodeStatus where
    parseJSON = Data.Aeson.withObject "NodeStatus" $ \o ->
        NodeStatus
            <$> o Data.Aeson..:? "Addr"
            <*> o Data.Aeson..:? "Message"
            <*> o Data.Aeson..:? "State"