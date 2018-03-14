Return-Path: virtio-return-3015-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Mar 2018 15:46:16 +0000
Message-Id: <20180314154618.13069-6-stefanha@redhat.com>
In-Reply-To: <20180314154618.13069-1-stefanha@redhat.com>
References: <20180314154618.13069-1-stefanha@redhat.com>
Subject: [virtio] [PATCH 5/7] packed-ring: fix plurals
To: virtio@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

There are two instances where plural needs to be used instead of
singular:

1. "descriptor(s)" is used later in the text, so use it consistently
   instead of starting with "descriptor" and switching later.

2. "What follows is the requirements" ->
   "What follows are the requirements"

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 packed-ring.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index 4e5c9b2..00befae 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -525,7 +525,7 @@ when using the packed virtqueue format in more detail.
 The driver offers buffers to one of the device's virtqueues as follows:
 
 \begin{enumerate}
-\item The driver places the buffer into free descriptor in the Descriptor Ring.
+\item The driver places the buffer into free descriptor(s) in the Descriptor Ring.
 
 \item The driver performs a suitable memory barrier to ensure that it updates
   the descriptor(s) before checking for notification suppression.
@@ -534,7 +534,7 @@ The driver offers buffers to one of the device's virtqueues as follows:
     of the new available buffers.
 \end{enumerate}
 
-What follows is the requirements of each stage in more detail.
+What follows are the requirements of each stage in more detail.
 
 \subsubsection{Placing Available Buffers Into The Descriptor Ring}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Placing Available Buffers Into The Descriptor Ring}
 
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

