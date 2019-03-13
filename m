Return-Path: virtio-return-3300-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 12 Mar 2019 21:48:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190313014750.3438-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH v4] conformance: clarify transitional/non-transitional
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

We already have a specification for conformance targets for
non-transitional devices.
Just add another clause that transitional devices satisfy.

VIRTIO-167

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Same patch was previouly sent as v2.

 conformance.tex | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 6df113b..8b69e39 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -341,13 +341,9 @@ A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
 Interface: Terminology}.
 
-A non-transitional implementation conforms to this specification
-if it satisfies all of the MUST or REQUIRED level requirements
-defined above.
-
-An implementation MAY choose to implement OPTIONAL support for the
+A transitional implementation MUST implement support for the
 legacy interface, including support for legacy drivers
-or devices, by additionally conforming to all of the MUST or
+or devices, by conforming to all of the MUST or
 REQUIRED level requirements for the legacy interface
 for the transitional devices and drivers.
 
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

