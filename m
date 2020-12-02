Return-Path: virtio-return-3449-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 2 Dec 2020 04:35:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201202093517.114406-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] typo: VIRTIO_NET_F_MAC_ADDR -> VIRTIO_NET_F_MAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

VIRTIO_NET_F_MAC_ADDR isn't defined. It's clear from context
that what is meant is VIRTIO_NET_F_MAC which controls whether
mac in config space is valid.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/90
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 5b3121e..d5d779a 100644
--- a/content.tex
+++ b/content.tex
@@ -3948,7 +3948,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 The VIRTIO_NET_CTRL_MAC_ADDR_SET command is used to set the
 default MAC address which rx filtering
-accepts (and if VIRTIO_NET_F_MAC_ADDR has been negotiated,
+accepts (and if VIRTIO_NET_F_MAC has been negotiated,
 this will be reflected in \field{mac} in config space).
 
 The command-specific-data for VIRTIO_NET_CTRL_MAC_ADDR_SET is
@@ -3962,7 +3962,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 the VIRTIO_NET_CTRL_MAC_TABLE_SET command.
 
 The device MUST update \field{mac} in config space before it consumes
-the VIRTIO_NET_CTRL_MAC_ADDR_SET command, if VIRTIO_NET_F_MAC_ADDR has
+the VIRTIO_NET_CTRL_MAC_ADDR_SET command, if VIRTIO_NET_F_MAC has
 been negotiated.
 
 The device SHOULD drop incoming packets which have a destination MAC which
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

