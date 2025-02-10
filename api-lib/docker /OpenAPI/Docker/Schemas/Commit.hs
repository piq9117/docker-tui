{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.Commit where

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





data Commit = Commit
    {
        expected :: (Data.Maybe.Maybe (Data.Text.Text)),
        iD :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON Commit where
    toJSON Commit {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Expected" Data.Aeson..= expected | Just expected <- [expected] ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ])

    toEncoding Commit {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Expected" . Data.Aeson.toEncoding) expected <>
          maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD
        )

instance Data.Aeson.FromJSON Commit where
    parseJSON = Data.Aeson.withObject "Commit" $ \o ->
        Commit
            <$> o Data.Aeson..:? "Expected"
            <*> o Data.Aeson..:? "ID"