{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ContainerdInfo where

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





data ContainerdInfoNamespaces = ContainerdInfoNamespaces
    {
        containers :: (Data.Maybe.Maybe (Data.Text.Text)),
        plugins :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerdInfoNamespaces where
    toJSON ContainerdInfoNamespaces {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Containers" Data.Aeson..= containers | Just containers <- [containers] ]
        ++ [ "Plugins" Data.Aeson..= plugins | Just plugins <- [plugins] ])

    toEncoding ContainerdInfoNamespaces {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Containers" . Data.Aeson.toEncoding) containers <>
          maybe mempty (Data.Aeson.Encoding.pair "Plugins" . Data.Aeson.toEncoding) plugins
        )

instance Data.Aeson.FromJSON ContainerdInfoNamespaces where
    parseJSON = Data.Aeson.withObject "ContainerdInfoNamespaces" $ \o ->
        ContainerdInfoNamespaces
            <$> o Data.Aeson..:? "Containers"
            <*> o Data.Aeson..:? "Plugins"

data ContainerdInfo = ContainerdInfo
    {
        address :: (Data.Maybe.Maybe (Data.Text.Text)),
        namespaces :: (Data.Maybe.Maybe (ContainerdInfoNamespaces))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerdInfo where
    toJSON ContainerdInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Address" Data.Aeson..= address | Just address <- [address] ]
        ++ [ "Namespaces" Data.Aeson..= namespaces | Just namespaces <- [namespaces] ])

    toEncoding ContainerdInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Address" . Data.Aeson.toEncoding) address <>
          maybe mempty (Data.Aeson.Encoding.pair "Namespaces" . Data.Aeson.toEncoding) namespaces
        )

instance Data.Aeson.FromJSON ContainerdInfo where
    parseJSON = Data.Aeson.withObject "ContainerdInfo" $ \o ->
        ContainerdInfo
            <$> o Data.Aeson..:? "Address"
            <*> o Data.Aeson..:? "Namespaces"