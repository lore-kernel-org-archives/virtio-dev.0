Return-Path: <virtio-comment-return-2974-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Wed, 27 Apr 2022 01:58:18 +0300
Message-ID: <20220426225824.5918-2-mgurtovoy@nvidia.com>
In-Reply-To: <20220426225824.5918-1-mgurtovoy@nvidia.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v5 1/7] Introduce device group
Content-Type: text/plain
To: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org
Cc: oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Each device group has a type. For now, define initial type of device
groups: Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI
SR-IOV virtual functions (VFs). This group may contain one or more
virtio devices.

Each device within a device group has a unique identifier. This
identifier is the virtio device id (vdev_id).

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 introduction.tex | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/introduction.tex b/introduction.tex
index 4dc7085..4358ab1 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -155,6 +155,18 @@ \subsection{Transition from earlier specification drafts}\label{sec:Transition f
 sections tagged "Legacy Interface" in the section title.
 These highlight the changes made since the earlier drafts.
 
+\subsection{Device group}\label{sec:Introduction / Terminology / Device group}
+
+A device group includes one or more virtio devices.
+Each virtio device has a unique virtio device id (vdev_id) within a device group. A valid vdev_id is a 64-bit field in the range of
+0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that refers to all devices in a device group and isn't a valid vdev_id.
+
+For now, the supported device groups are:
+\begin{enumerate}
+\item Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI SR-IOV virtual functions (VFs). For this group type, the PF device has vdev_id that is equal to 0
+and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification).
+\end{enumerate}
+
 \section{Structure Specifications}\label{sec:Structure Specifications}
 
 Many device and driver in-memory structure layouts are documented using
-- 
2.21.0


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

