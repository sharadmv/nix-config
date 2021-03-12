{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Exception.Base
import           Control.Monad 
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Reader
import qualified Data.ByteString.Char8 as BS
import           Data.List
import           Data.List.Split
import qualified Data.Map as M
import           Data.Maybe
import           Network.HostName
import           StatusNotifier.Tray
import           System.Directory
import           System.Environment
import           System.FilePath.Posix
import           System.IO
import           System.Log.Handler.Simple
import           System.Log.Logger
import           System.Process
import           System.Taffybar
import           System.Taffybar.Auth
import           System.Taffybar.Context (appendHook)
import           System.Taffybar.DBus
import           System.Taffybar.DBus.Toggle
import           System.Taffybar.Hooks
import           System.Taffybar.Information.CPU
import           System.Taffybar.Information.EWMHDesktopInfo
import           System.Taffybar.Information.Memory
import           System.Taffybar.Information.X11DesktopInfo
import           System.Environment.XDG.BaseDir
import           System.Taffybar.SimpleConfig
import           System.Taffybar.Util
import           System.Taffybar.Widget
import           System.Taffybar.Widget.Generic.PollingGraph
import           System.Taffybar.Widget.Generic.PollingLabel
import           System.Taffybar.Widget.Util
import           System.Taffybar.Widget.Workspaces
import           Text.Printf
import           Text.Read hiding (lift)

getFullWorkspaceNames :: X11Property [(WorkspaceId, String)]
getFullWorkspaceNames = go <$> readAsListOfString Nothing "_NET_DESKTOP_FULL_NAMES"
  where go = zip [WorkspaceId i | i <- [0..]]

workspaceNamesLabelSetter workspace =
  fromMaybe "" . lookup (workspaceIdx workspace) <$>
            liftX11Def [] getFullWorkspaceNames

enableLogger logger level = do
  logger <- getLogger logger
  saveGlobalLogger $ setLevel level logger

logDebug = do
  global <- getLogger ""
  saveGlobalLogger $ setLevel DEBUG global
  logger3 <- getLogger "System.Taffybar"
  saveGlobalLogger $ setLevel DEBUG logger3
  logger <- getLogger "System.Taffybar.Widget.Generic.AutoSizeImage"
  saveGlobalLogger $ setLevel DEBUG logger
  logger2 <- getLogger "StatusNotifier.Tray"
  saveGlobalLogger $ setLevel DEBUG logger2


main = do
  hostName <- getHostName
  homeDirectory <- getHomeDirectory
  cssFilePath <-
    traverse (getUserConfigFile "taffybar") $ Just "taffybar.css"
  let myIcons = scaledWindowIconPixbufGetter $
                getWindowIconPixbufFromChrome <|||>
                unscaledDefaultGetWindowIconPixbuf <|||>
                (\size _ -> lift $ loadPixbufByName size "application-default-icon")
      layout = layoutNew defaultLayoutConfig
      windows = windowsNew defaultWindowsConfig
      notifySystemD = void $ runCommandFromPath ["systemd-notify", "--ready"]
      myWorkspacesConfig =
        defaultWorkspacesConfig
        { underlineHeight = 3
        , underlinePadding = 2
        , minIcons = 1
        , getWindowIconPixbuf = myIcons
        , widgetGap = 0
        , showWorkspaceFn = hideEmpty
        , updateRateLimitMicroseconds = 100000
        , labelSetter = workspaceNamesLabelSetter
        }
      workspaces = workspacesNew myWorkspacesConfig
      myClock =
        textClockNewWith
        defaultClockConfig
        { clockUpdateStrategy = RoundedTargetInterval 60 0.0
        , clockFormatString = "%a %b %_d %I:%M %p"
        }
      fullEndWidgets =
        map (>>= buildContentsBox)
              [ myClock
              , sniTrayNew
              , mpris2New
              ]
      baseConfig =
        defaultSimpleTaffyConfig
        { startWidgets =
             workspaces : map (>>= buildContentsBox) [layout, windows]
        , endWidgets = fullEndWidgets
        , barPosition = Top
        , barPadding = 0
        , barHeight = 30
        , cssPath = cssFilePath
        }
      selectedConfig = baseConfig { endWidgets = fullEndWidgets, barHeight = 42 }
      simpleTaffyConfig = selectedConfig
        { centerWidgets = []
        }
  startTaffybar $
    appendHook notifySystemD $
    appendHook (void $ getHost False) $
    withLogServer $
    withToggleServer $
    toTaffyConfig simpleTaffyConfig
