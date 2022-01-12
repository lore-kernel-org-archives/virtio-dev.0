Return-Path: <virtio-comment-return-2508-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
References: <oasis-tcs/virtio-spec/issues/131@github.com>
Date: Wed, 12 Jan 2022 18:20:53 +0100
Message-ID: <87lezkx43u.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] [oasis-tcs/virtio-spec] Device specific Feature bits numbering is
 not aligned (Issue #131)
Content-Type: text/plain
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


> Feature bits 56 to 63 are taken by the virtio-net device and not reflected in the generic feature bits accounting.

Thank you for reporting this, forwarding to the lists for discussion.

It seems like we're in a bit of a pickle: The spec says that the higher
feature bits are reserved for future generic extensions, but virtio-net
is already using some bits in that space (as they have already exhausted
the lower device-specific bits). Now we cannot undo the already reserved
bits, but obviously we need space both for generic extensions and
device-specific extensions. Fortunately, we're not short on feature
bits, we can simply consider the bits beyond 63.

I'd like to propose the following:

- bits 41-49: reserved for future extensions
- bits 50-63: used for specific device types
- bits 64-127: used for specific device types
- bits 128 and above: reserved for future extensions

This gives us room for both generic and device-specific extensions in
the first 64 bits for some more time before we have to go to bit 64 and
beyond.

Thoughts? We need to figure that out before the 1.2 release.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

