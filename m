Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v5 3/7] Introduce new destination type for admin commands
Date: Wed, 27 Apr 2022 01:58:20 +0300
Message-ID: <20220426225824.5918-4-mgurtovoy@nvidia.com>
In-Reply-To: <20220426225824.5918-1-mgurtovoy@nvidia.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org
Cc: oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce a new mechanism to issue commands with dst_type field that is
not "self". With the new mechanism, driver can set dst_type to 1
and use the vdev_id common field to describe the designated vdev_id.

This mechanism is useful for device groups with multiple devices
with various different capabilities. For example, a type 1 device group
that contains a PCI PF and its VF. For this group, a clever system
administrator can use admin commands to manipulate the PF/VF resources.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin.tex | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/admin.tex b/admin.tex
index 6725daa..f816c3b 100644
--- a/admin.tex
+++ b/admin.tex
@@ -11,11 +11,13 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
         le16 command;
         /*
          * 0 - self
-         * 1 - 65535 are reserved
+         * 1 - other virtio device (identified by vdev_id) in the same device group
+         * 2 - 65535 are reserved
          */
         le16 dst_type;
+        le64 vdev_id;
         /* reserved for common cmd fields */
-        u8 reserved[20];
+        u8 reserved[12];
         u8 command_specific_data[];
 
         /* Device-writable part */
@@ -39,9 +41,11 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
 \hline
 03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field was set  \\
 \hline
+04h   & VIRTIO_ADMIN_STATUS_INVALID_VDEV_ID    & invalid vdev_id was set  \\
+\hline
 \end{tabular}
 
-The \field{command}, \field{dst_type} and \field{command_specific_data} are
+The \field{command}, \field{dst_type}, \field{vdev_id} and \field{command_specific_data} are
 set by the driver, and the device sets the \field{status}, the
 \field{command_specific_error} and the \field{command_specific_result},
 if needed.
@@ -50,9 +54,15 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
 
 The mandatory fields to be set by the driver, for all admin commands, are \field{command} and \field{dst_type}.
 
+The optional unused fields to be zeroed by the driver.
+
 The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
 
-The \field{dst_type} defines the designated virtio device for the command. This value should be set to 0 (self).
+The \field{dst_type} defines the designated virtio device for the command. This value can be set to 0 (self) or 1 (other virtio device in the same device
+group) by the driver. Not all the commands allow setting \field{dst_type} to 1. Refer to each command description explicitly to check whether this operation is allowed.
+If \field{dst_type} is set to 0 by the driver, the \field{vdev_id} isn't valid, should be zeroed by the driver and should be ignored by the device.
+If \field{dst_type} is set to 1 by the driver, the \field{vdev_id} is valid and used to describe the vdev_id of the designated virtio device (see section
+\ref{sec:Introduction / Terminology / Device group} for vdev_id numbering for type 1 device groups).
 
 The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
 VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
-- 
2.21.0

