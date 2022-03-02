Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 3/5] Introduce DEVICE INFO Admin command
Date: Wed, 2 Mar 2022 17:56:06 +0200
Message-ID: <20220302155608.24189-4-mgurtovoy@nvidia.com>
In-Reply-To: <20220302155608.24189-1-mgurtovoy@nvidia.com>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The DEVICE INFO command will return a basic information for a virtio
device.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin.tex | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index 1e30e01..9a8969b 100644
--- a/admin.tex
+++ b/admin.tex
@@ -67,7 +67,9 @@ \section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admi
 \hline
 0001h   & VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY    & O  \\
 \hline
-0002h - 7FFFh   & Generic admin cmds    & -  \\
+0002h   & VIRTIO_ADMIN_DEVICE_INFO    & O  \\
+\hline
+0003h - 7FFFh   & Generic admin cmds    & -  \\
 \hline
 8000h - FFFFh   & Reserved    & - \\
 \hline
@@ -94,7 +96,8 @@ \subsection{VIRTIO ADMIN DEVICE IDENTIFY command}\label{sec:Basic Facilities of
        /* This field indicates which of the below optional admin
         * capabilities are supported by the device:
         * Bit 0 - if set, VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY supported
-        * Bits 1 - 63 - reserved for future capabilities.
+        * Bit 1 - if set, VIRTIO_ADMIN_DEVICE_INFO supported
+        * Bits 2 - 63 - reserved for future capabilities.
         */
        le64 optional_caps_support;
        u8 reserved[4072];
@@ -127,3 +130,31 @@ \subsection{VIRTIO ADMIN SUBSYSTEM IDENTIFY command}\label{sec:Basic Facilities
        u8 reserved[4056];
 };
 \end{lstlisting}
+
+\subsection{VIRTIO ADMIN DEVICE INFO command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE INFO command}
+
+The VIRTIO_ADMIN_DEVICE_INFO command has no command specific data set by the driver.
+The \field{command} is set to VIRTIO_ADMIN_DEVICE_INFO.
+
+The VIRTIO_ADMIN_DEVICE_INFO upon success, returns a data buffer that describes a basic information for the target virtio device.
+Upon success, the returned data buffer is of form:
+\begin{lstlisting}
+struct virtio_admin_device_info_result {
+        /* For compatibility - indicates which of the below fields were returned
+         * (1 means that field was returned):
+         * Bit 0 - vf_number
+         * Bits 1 - 63 - reserved for future fields
+         */
+        le64 attrs_mask;
+        /* The virtual function number */
+        le16 vf_number;
+        u8 reserved[1014];
+};
+\end{lstlisting}
+
+\begin{note}
+{Bit 0 in \field{attrs_mask} will be set only if the target virtio device represents a PCI Virtual function.
+In this case, the \field{vf_number} value can't be greater than TotalVFs value as defined in the PCI
+specification and can't be equal to zero. If bit 0 is not set, the driver will ignore \field{vf_number}.}
+\end{note}
+
-- 
2.21.0

