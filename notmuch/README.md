# setup for notmuch <https://notmuchmail.org>

Email indexer

    ├── .config
    │   └── offlineimap
    │       └── postsync.d
    │           └── notmuch-new.sh
    └── .notmuch-config

## see also

* afew
* alot
* offlineimap

# Notification Hook for post-new

    #!/bin/bash
    #
    # ~/mail/.notmuch/hooks/post-new

    # initial tagging scripts go here... e.g.,
    # afew --tag --new

    # show desktop notification for any new messages
    QUERY_NEW="tag:inbox AND tag:unread AND NOT tag:killed"
    COUNT_NEW="$(notmuch count "$QUERY_NEW")"
    if [ "$COUNT_NEW" -gt 0 ]; then
      notify-send --urgency=normal --expire-time=10000 \
        --icon=notification-message-email \
        --category=email.arrived \
        "mailsync: $COUNT_NEW new message$([ "$COUNT_NEW" -eq 1 ] || echo s)" \
        "From: $(notmuch address --output=address --deduplicate=address "$QUERY_NEW" | sort)"
      mpv /usr/share/sounds/freedesktop/stereo/message.oga &
    fi
