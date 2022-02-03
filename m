Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v3 3/4] Add device management facility
Date: Thu, 3 Feb 2022 09:57:15 +0200
Message-ID: <20220203075716.11684-4-mgurtovoy@nvidia.com>
In-Reply-To: <20220203075716.11684-1-mgurtovoy@nvidia.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

A virtio device may be capable of managing other virtio device
features and configuration. These management operations are composed of
one or more admin commands from the admin command set. One such
management interface for issuing these commands can be the virtio admin
virtqueue.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 content.tex | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/content.tex b/content.tex
index bf46192..276a29f 100644
--- a/content.tex
+++ b/content.tex
@@ -451,6 +451,20 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 
 \input{admin.tex}
 
+\section{Device management}\label{sec:Basic Facilities of a Virtio Device / Device management}
+
+Virtualized environments might be composed of one or more virtio devices. These devices might be
+associated with each other. For example,  virtio PCI PF and its VFS are composing one virtio group.
+A PCI PF device, by default, is the primary device in the group, and its PCI VFs are the secondary devices in the group.
+A sophisticated primary device might have capabilities to manage its secondary devices. This primary
+device will be the virtio group manager and the secondary devices would be the managed devices in this group.
+
+The primary device will use the admin command set to manage secondary devices (see section
+\ref{sec:Basic Facilities of a Virtio Device / Admin command set} for more details). The primary device
+can use any management interface that is defined in the virtio specification for issuing admin commands.
+For example, the admin virtqueue (see section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtqueues} for more details)
+of the PF can be used to configure some attributes (such as MSI-X vectors) for its VFs in order to improve resource utilization.
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
-- 
2.21.0

