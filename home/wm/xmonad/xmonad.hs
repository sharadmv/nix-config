module Main where

import Graphics.X11.ExtraTypes.XF86  

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.Volume
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Circle
import XMonad.Layout.Grid
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Util.EZConfig (additionalKeys)

import qualified Codec.Binary.UTF8.String              as UTF8
import qualified DBus                                  as D
import qualified DBus.Client                           as D

modm = mod4Mask
myTerminal = "alacritty"

myLayoutHook = id
       . avoidStruts
       . smartBorders
       . mkToggle (NOBORDERS ?? FULL ?? EOT)
       . mkToggle (single MIRROR)
       . (spacingRaw True (Border 16 16 16 16) True (Border 10 16 16 16) True)
       $ tiled ||| Grid ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/100

myLogHook = fadeInactiveLogHook 0.9
------------------------------------------------------------------------
-- Polybar settings (needs DBus client).
--
mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
 where
  opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath  = D.objectPath_ "/org/xmonad/Log"
      iname  = D.interfaceName_ "org.xmonad.Log"
      mname  = D.memberName_ "Update"
      signal = D.signal opath iname mname
      body   = [D.toVariant $ UTF8.decodeString str]
  in  D.emit dbus $ signal { D.signalBody = body }

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
                  | otherwise  = mempty
      blue   = "#2E9AFE"
      gray   = "#7F7F7F"
      orange = "#ea4300"
      purple = "#9058c7"
      red    = "#722222"
  in  def { ppOutput          = dbusOutput dbus
          , ppCurrent         = wrapper blue
          , ppVisible         = wrapper gray
          , ppUrgent          = wrapper orange
          , ppHidden          = wrapper gray
          , ppHiddenNoWindows = wrapper red
          , ppTitle           = shorten 100 . wrapper purple
          }

myPolybarLogHook dbus = myLogHook <+> dynamicLogWithPP (polybarHook dbus)


myKeys = 
  [ ((modm, xK_p), spawn "exe=`launcher`")
  , ((modm, xK_o), spawn "exe=`powermenu`")
  , ((modm, xK_y), sendMessage $ ToggleStruts)
  , ((modm, xK_u), sendMessage $ Toggle NOBORDERS)
  , ((modm, xK_i), toggleWindowSpacingEnabled >> toggleScreenSpacingEnabled)
  , ((controlMask .|. shiftMask, xK_Up), raiseVolume 5 >> return ())
  , ((0, xF86XK_AudioRaiseVolume), raiseVolume 5 >> return ())
  , ((0, xF86XK_AudioLowerVolume), lowerVolume 5 >> return ())
  , ((0, xF86XK_AudioMute), toggleMute >> return ())
  , ((0, xF86XK_AudioPlay), spawn "exe=`playerctl play-pause`")
  , ((0, xF86XK_AudioPause), spawn "exe=`playerctl play-pause`")
  , ((0, xF86XK_AudioNext), spawn "exe=`playerctl next`")
  , ((0, xF86XK_AudioPrev), spawn "exe=`playerctl previous`")
  , ((controlMask .|. shiftMask, xK_Down), lowerVolume 5 >> return ())
  , ((controlMask .|. shiftMask, xK_m), toggleMute >> return ())
  , ((modm .|. shiftMask, xK_l), spawn "exe=`betterlockscreen -l`")
  ]

main :: IO ()
main = mkDbusClient >>= main'

main' dbus = xmonad $
       docks $
       ewmh $ def 
         { modMask = modm
         , terminal = myTerminal
         , handleEventHook = handleEventHook def <+> fullscreenEventHook
         , layoutHook = myLayoutHook
         , logHook = myPolybarLogHook dbus
         } `additionalKeys` myKeys
