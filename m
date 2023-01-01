Return-Path: <virtio-comment-return-3640-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:08:18 +0200
Message-ID: <20230101180824.325172-15-parav@nvidia.com>
In-Reply-To: <20230101180824.325172-1-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 14/20] virtio-iommu: Maintain iommu device spec in separate directory
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Place device specification, its driver and device
conformance into its own directory to have self contained device
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- new patch
---
 conformance.tex                               | 37 +------------------
 content.tex                                   |  2 +-
 .../virtio-iommu/device-conformance.tex       | 16 ++++++++
 .../virtio-iommu/device.tex                   |  0
 .../virtio-iommu/driver-conformance.tex       | 17 +++++++++
 5 files changed, 36 insertions(+), 36 deletions(-)
 create mode 100644 device-types/virtio-iommu/device-conformance.tex
 rename virtio-iommu.tex =3D> device-types/virtio-iommu/device.tex (100%)
 create mode 100644 device-types/virtio-iommu/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index c109fbd..88ae166 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -145,24 +145,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-vsock/}{driver-conformance}
 \import{device-types/virtio-fs/}{driver-conformance}
 \import{device-types/virtio-rpmb/}{driver-conformance}
-
-\conformance{\subsection}{IOMMU Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / IOMMU Driver Conformance}
-
-An IOMMU driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / IOMMU Device / Feature bits}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device configurat=
ion layout}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device Initializa=
tion}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / ATTACH request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / DETACH request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / MAP request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / UNMAP request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / PROBE request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / PROBE properties / RESVMEM}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
-\end{itemize}
+\import{device-types/virtio-iommu/}{driver-conformance}
=20
 \conformance{\subsection}{Sound Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Sound Driver Conformance}
=20
@@ -305,23 +288,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-vsock/}{device-conformance}
 \import{device-types/virtio-fs/}{device-conformance}
 \import{device-types/virtio-rpmb/}{device-conformance}
-
-\conformance{\subsection}{IOMMU Device Conformance}\label{sec:Conformance =
/ Device Conformance / IOMMU Device Conformance}
-
-An IOMMU device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / IOMMU Device / Feature bits}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device configurat=
ion layout}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / ATTACH request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / DETACH request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / MAP request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / UNMAP request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / PROBE request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / PROBE properties / RESVMEM}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
-\end{itemize}
+\import{device-types/virtio-iommu/}{device-conformance}
=20
 \conformance{\subsection}{Sound Device Conformance}\label{sec:Conformance =
/ Device Conformance / Sound Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 13a2a94..49f3edc 100644
--- a/content.tex
+++ b/content.tex
@@ -3014,7 +3014,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-crypto/}{device}
 \import{device-types/virtio-vsock/}{device}
 \import{device-types/virtio-fs/}{device}
-\input{virtio-iommu.tex}
+\import{device-types/virtio-iommu/}{device}
 \input{virtio-sound.tex}
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
diff --git a/device-types/virtio-iommu/device-conformance.tex b/device-type=
s/virtio-iommu/device-conformance.tex
new file mode 100644
index 0000000..bc5b3b8
--- /dev/null
+++ b/device-types/virtio-iommu/device-conformance.tex
@@ -0,0 +1,16 @@
+\conformance{\subsection}{IOMMU Device Conformance}\label{sec:Conformance =
/ Device Conformance / IOMMU Device Conformance}
+
+An IOMMU device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / IOMMU Device / Feature bits}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device configurat=
ion layout}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / ATTACH request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / DETACH request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / MAP request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / UNMAP request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / PROBE request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / PROBE properties / RESVMEM}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
+\end{itemize}
diff --git a/virtio-iommu.tex b/device-types/virtio-iommu/device.tex
similarity index 100%
rename from virtio-iommu.tex
rename to device-types/virtio-iommu/device.tex
diff --git a/device-types/virtio-iommu/driver-conformance.tex b/device-type=
s/virtio-iommu/driver-conformance.tex
new file mode 100644
index 0000000..0c7bf91
--- /dev/null
+++ b/device-types/virtio-iommu/driver-conformance.tex
@@ -0,0 +1,17 @@
+\conformance{\subsection}{IOMMU Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / IOMMU Driver Conformance}
+
+An IOMMU driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / IOMMU Device / Feature bits}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device configurat=
ion layout}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device Initializa=
tion}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / ATTACH request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / DETACH request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / MAP request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / UNMAP request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / PROBE request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / PROBE properties / RESVMEM}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
+\end{itemize}
--=20
2.26.2


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

