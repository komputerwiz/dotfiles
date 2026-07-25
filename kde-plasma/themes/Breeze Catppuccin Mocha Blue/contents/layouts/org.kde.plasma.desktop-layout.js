var plasma = getApiVersion(1);

var layout = {
    "desktops": [
        {
            "applets": [
            ],
            "config": {
                "/": {
                    "ItemGeometries-0x0": "",
                    "ItemGeometries-2560x1440": "",
                    "ItemGeometriesHorizontal": "",
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "540",
                    "DialogWidth": "720"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Image": "file:///home/matthew/.local/share/wallpapers/dolphins-dynamic/",
                    "SlidePaths": "/usr/share/wallpapers/"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        },
        {
            "applets": [
            ],
            "config": {
                "/": {
                    "ItemGeometries-0x0": "",
                    "ItemGeometries-2560x1440": "",
                    "ItemGeometriesHorizontal": "",
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "1",
                    "wallpaperplugin": "org.kde.image"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Image": "file:///home/matthew/.local/share/wallpapers/dolphins-dynamic/",
                    "SlidePaths": "/usr/share/wallpapers/"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        },
        {
            "applets": [
            ],
            "config": {
                "/": {
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "2",
                    "wallpaperplugin": "org.kde.image"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        }
    ],
    "panels": [
        {
            "alignment": "center",
            "applets": [
                {
                    "config": {
                        "/": {
                            "popupHeight": "510",
                            "popupWidth": "647"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/General": {
                            "favoritesPortedToKAstats": "true"
                        }
                    },
                    "plugin": "org.kde.plasma.kickoff"
                },
                {
                    "config": {
                        "/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/General": {
                            "showActivityIcon": "false",
                            "showActivityName": "false"
                        }
                    },
                    "plugin": "org.kde.plasma.showActivityManager"
                },
                {
                    "config": {
                        "/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/General": {
                            "launchers": "applications:org.kde.dolphin.desktop,applications:com.mitchellh.ghostty.desktop,file:///var/lib/flatpak/exports/share/applications/app.zen_browser.zen.desktop,applications:com.todoist.Todoist.desktop"
                        }
                    },
                    "plugin": "org.kde.plasma.icontasks"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.panelspacer"
                },
                {
                    "config": {
                        "/ConfigDialog": {
                            "DialogHeight": "630",
                            "DialogWidth": "810"
                        },
                        "/General": {
                            "launcherUrls": "file:///home/matthew/.local/share/applications/Single Monitor Mode.desktop,file:///home/matthew/.local/share/applications/Restore Monitor Layout.desktop"
                        }
                    },
                    "plugin": "org.kde.plasma.quicklaunch"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.marginsseparator"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.systemtray"
                },
                {
                    "config": {
                        "/": {
                            "popupHeight": "451",
                            "popupWidth": "560"
                        },
                        "/Appearance": {
                            "dateDisplayFormat": "BesideTime",
                            "dateFormat": "isoDate",
                            "showSeconds": "Always",
                            "use24hFormat": "2"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "630",
                            "DialogWidth": "810"
                        }
                    },
                    "plugin": "org.kde.plasma.digitalclock"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.marginsseparator"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.showdesktop"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                }
            },
            "height": 1.7777777777777777,
            "hiding": "dodgewindows",
            "lengthMode": "fill",
            "location": "bottom",
            "maximumLength": 142.22222222222223,
            "minimumLength": 142.22222222222223,
            "offset": 0,
            "opacity": "adaptive"
        },
        {
            "applets": [
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.clipboard"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.keyboardlayout"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.notifications"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.manage-inputmethod"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.cameraindicator"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.devicenotifier"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.battery"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.kscreen"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.mediacontroller"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.volume"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.networkmanagement"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "popupHeight": "432",
                    "popupWidth": "432",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "540",
                    "DialogWidth": "720"
                },
                "/Configuration": {
                    "PreloadWeight": "42"
                },
                "/General": {
                    "extraItems": "org.kde.plasma.clipboard,org.kde.plasma.keyboardlayout,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.plasma.manage-inputmethod,org.kde.plasma.cameraindicator,org.kde.plasma.devicenotifier,org.kde.plasma.battery,org.kde.kscreen,org.kde.plasma.networkmanagement,org.kde.plasma.volume",
                    "knownItems": "org.kde.plasma.clipboard,org.kde.plasma.keyboardlayout,org.kde.plasma.brightness,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.plasma.manage-inputmethod,org.kde.plasma.cameraindicator,org.kde.plasma.devicenotifier,org.kde.plasma.battery,org.kde.kscreen,org.kde.plasma.networkmanagement,org.kde.plasma.volume"
                }
            },
            "height": 4,
            "location": "bottom"
        },
        {
            "applets": [
                {
                    "config": {
                    },
                    "plugin": "org.kde.kscreen"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.clipboard"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.keyboardlayout"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.notifications"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.manage-inputmethod"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.cameraindicator"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.devicenotifier"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.battery"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.brightness"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.mediacontroller"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.volume"
                },
                {
                    "config": {
                    },
                    "plugin": "org.kde.plasma.networkmanagement"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "-1",
                    "wallpaperplugin": "org.kde.image"
                },
                "/Configuration": {
                    "PreloadWeight": "42"
                },
                "/General": {
                    "extraItems": "org.kde.kscreen,org.kde.plasma.clipboard,org.kde.plasma.keyboardlayout,org.kde.plasma.brightness,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.plasma.manage-inputmethod,org.kde.plasma.cameraindicator,org.kde.plasma.devicenotifier,org.kde.plasma.battery,org.kde.plasma.networkmanagement,org.kde.plasma.volume",
                    "knownItems": "org.kde.kscreen,org.kde.plasma.clipboard,org.kde.plasma.keyboardlayout,org.kde.plasma.brightness,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.plasma.manage-inputmethod,org.kde.plasma.cameraindicator,org.kde.plasma.devicenotifier,org.kde.plasma.battery,org.kde.plasma.networkmanagement,org.kde.plasma.volume"
                }
            },
            "height": 4,
            "location": "top"
        }
    ],
    "serializationFormatVersion": "1"
}
;

plasma.loadSerializedLayout(layout);
