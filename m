Return-Path: virtio-return-3272-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 12:00:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190311160018.29995-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH v3] conformance: clarify transitional/non-transitional
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Clarify that:
- non-transitional just satisfy 3 main clauses
- transitional also has a legacy interface:
  however note that it's not an optional component
  *for transitional devices* so MAY is inappropriate
- legacy device descriptions are non-normative.
  In fact virtio 0.9 is non-normative as a whole
  and always was by design: it was early days and
  spec evolved to document bugs in implementations.

VIRTIO-167

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
	address remaining comments by Cornelia
Changes from v1:
	address comments by Cornelia

 conformance.tex | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 1577c0c..c0df2a2 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -344,16 +344,26 @@ Interface: Terminology}.
 
 A non-transitional implementation conforms to this specification
 if it satisfies all of the MUST or REQUIRED level requirements
-defined above.
+defined in section \ref{sec:Conformance / Conformance Targets} above.
 
-An implementation MAY choose to implement OPTIONAL support for the
-legacy interface, including support for legacy drivers
-or devices, by additionally conforming to all of the MUST or
-REQUIRED level requirements for the legacy interface
-for the transitional devices and drivers.
+A transitional implementation conforms to this specification
+if it satisfies all of the MUST or REQUIRED level requirements
+defined in section \ref{sec:Conformance / Conformance Targets} above
+and additionally implements the legacy interface
+for devices and drivers, described in
+\hyperref[intro:Virtio PCI Draft]{[Virtio PCI Draft]}.
 
-The requirements for the legacy interface for transitional implementations
-are located in sections named ``Legacy Interface'' listed below:
+\begin{note}
+No normative specification for the legacy interface exists,
+instead the ability of the device or the driver to inter-operate
+with the existing body of devices and drivers is a quality of
+implementation issue.
+\end{note}
+
+To facilitate creating transitional implementations, as well as
+to assist in converting legacy interfaces to conforming ones,
+the requirements for the legacy interface for transitional implementations
+are located in non-normative sections named ``Legacy Interface'' listed below:
 \begin{itemize}
 \item Section \ref{sec:Basic Facilities of a Virtio Device /
 Feature Bits / Legacy Interface: A Note on Feature Bits}
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

