Return-Path: SRS0=KMw5=FK=redhat.com=mst@kernel.org
Date: Fri, 16 Feb 2018 09:26:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 15/16] conformance: link the new conformance clause
Message-ID: <20180216092643-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518765602-8739-1-git-send-email-mst@redhat.com>
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 conformance.tex | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conformance.tex b/conformance.tex
index 55d17b4..e4efe33 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -38,6 +38,7 @@ A driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}
-- 
MST

