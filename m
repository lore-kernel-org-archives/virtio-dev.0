Return-Path: <mst@redhat.com>
Date: Sun, 20 Nov 2022 20:25:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 2/9] admin: introduce device group and related concepts
Message-ID: <20221121012419.317406-3-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221121012419.317406-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Each device group has a type. For now, define one initial group:

SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
PCI SR-IOV physical function (PF). This group may contain one or more
virtio devices.

Each device within a group has a unique identifier. This identifier
is the group member identifier.

Note: one can argue both ways whether the new device group handling
functionality (this and following patches) is closer
to a new device type or a new transport type.

However, I expect that we will add more features in the near future. To
facilitate this as much as possible of the text is located in the new
admin chapter.

I did my best to minimize transport-specific text.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100644 admin.tex

diff --git a/admin.tex b/admin.tex
new file mode 100644
index 0000000..4337db0
--- /dev/null
+++ b/admin.tex
@@ -0,0 +1,50 @@
+\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
+
+It is occasionally useful to have a device control a group of
+other devices. Terminology used in such cases:
+
+\begin{description}
+\item[Device group]
+        or just group, includes zero or more devices.
+\item[Owner device]
+        or owner, the device controlling the group.
+\item[Member device]
+        a device within a group. Owner device itself is not
+	a member of the group. In the future it is envisoned that
+	new group types may be introduced where the owner
+	device is a member of the group.
+\item[Member identifier]
+        each member has this identifier, unique within the group
+	and used to address it through the owner device.
+\item[Group type identifier]
+	specifies what kind of member devices there are in a
+	group, how is the member identifier interpreted
+	and what kind of control does the owner have.
+	At the moment, a given owner can control
+	a single group of a given type, thus the type and
+	the owner together identify the group.
+	It is envisioned that this last restriction might be relaxed in the future,
+	with multiple groups of the same type for a given owner.
+\end{description}
+
+A single group type is currently specified:
+\begin{description}
+\item[SR-IOV group type]
+This device group has a PCI Single Root I/O Virtualization
+(SR-IOV) physical function (PF) device as the owner and includes
+all its SR-IOV virtual functions (VFs) as members (see
+\hyperref[intro:PCIe]{[PCIe]}).
+
+The PF device itself is not a member of the group.
+
+The group type identifier for this group is 0x1.
+
+A member identifier for this group can have a value 0x1 to 0xFFFF
+and equals the SR-IOV VF number of the member device (see
+\hyperref[intro:PCIe]{[PCIe]}).
+
+Both owner and member devices for this group type use the Virtio
+PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
+\end{description}
+
+
diff --git a/content.tex b/content.tex
index 1e91b1d..9deacbf 100644
--- a/content.tex
+++ b/content.tex
@@ -486,6 +486,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\input{admin.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
-- 
MST

