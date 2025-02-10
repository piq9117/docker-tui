{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.JoinTokens where

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





data JoinTokens = JoinTokens
    {
        manager :: (Data.Maybe.Maybe (Data.Text.Text)),
        worker :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON JoinTokens where
    toJSON JoinTokens {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Manager" Data.Aeson..= manager | Just manager <- [manager] ]
        ++ [ "Worker" Data.Aeson..= worker | Just worker <- [worker] ])

    toEncoding JoinTokens {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Manager" . Data.Aeson.toEncoding) manager <>
          maybe mempty (Data.Aeson.Encoding.pair "Worker" . Data.Aeson.toEncoding) worker
        )

instance Data.Aeson.FromJSON JoinTokens where
    parseJSON = Data.Aeson.withObject "JoinTokens" $ \o ->
        JoinTokens
            <$> o Data.Aeson..:? "Manager"
            <*> o Data.Aeson..:? "Worker"