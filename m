Return-Path: <mst@redhat.com>
Date: Fri, 12 Aug 2022 13:19:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 7/8] admin: document that structures can be shorter or
 longer
Message-ID: <20220812171841.12183-8-mst@redhat.com>
References: <20220812171841.12183-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220812171841.12183-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

ensures forward and backward compatibility as long as
we tuck new structures at the end.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/admin.tex b/admin.tex
index a0008c7..99b6c2a 100644
--- a/admin.tex
+++ b/admin.tex
@@ -136,6 +136,12 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
 \field{command_specific_error} value is undefined and should be ignored by the driver.
 
+It is legal for the driver to submit commands with device-writeable and
+device-readable structures both shorter and longer than what
+is described in this specification. Device silently truncates the
+structures to the shorter of the two (submitted by driver and
+described in this specification).
+
 \section{Administration Virtqueue}\label{sec:Basic Facilities of a Virtio Device / Group Administration Virtqueues}
 
 An administration virtqueue of a parent device is used to submit
-- 
MST

