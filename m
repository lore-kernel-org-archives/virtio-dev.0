Return-Path: <mst@redhat.com>
Date: Sun, 20 Nov 2022 20:25:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 1/9] virtio: document forward compatibility guarantees
Message-ID: <20221121012419.317406-2-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221121012419.317406-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Feature negotiation forms the basis of forward compatibility
guarantees of virtio but has never been properly documented.
Do it now.

Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/content.tex b/content.tex
index 3051399..1e91b1d 100644
--- a/content.tex
+++ b/content.tex
@@ -114,21 +114,58 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
 In particular, new fields in the device configuration space are
 indicated by offering a new feature bit.
 
+To keep the feature negotiation mechanism extensible, it is
+important that devices \em{do not} offer feature bits they would
+not be able to handle if accepted by the driver (even though
+according to this version of the specification even if offered
+drivers are not supposed to accept them in the first place),
+while drivers \em{do not} accept feature bits they do not know
+how to handle (even though according to this version of the
+specification devices are not supposed to offer them in the first
+place).  Any reserved and unexpected features are to be by
+preference ignored by the driver.  In particular, this is
+especially important for features limited to specific transports,
+as enabling these for more transports in future versions of the
+specification is highly likely to require changing the behaviour
+from drivers and devices.  Drivers and devices supporting
+multiple transports need to carefully maintain per-transport
+lists of allowed features.
+
 \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
 The driver MUST NOT accept a feature which the device did not offer,
 and MUST NOT accept a feature which requires another feature which was
 not accepted.
 
+The driver MUST validate the feature bits offered by the device.
+The driver MUST ignore and MUST NOT accept feature bits not
+described in this specification, reserved feature bits and
+feature bits reserved or not supported for the specific transport
+or the specific device type.
+
 The driver SHOULD go into backwards compatibility mode
 if the device does not offer a feature it understands, otherwise MUST
 set the FAILED \field{device status} bit and cease initialization.
 
+By contrast, the driver MUST NOT fail solely because a feature
+it does not understand has been offered by the device.
+
 \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
 The device MUST NOT offer a feature which requires another feature
 which was not offered.  The device SHOULD accept any valid subset
 of features the driver accepts, otherwise it MUST fail to set the
 FEATURES_OK \field{device status} bit when the driver writes it.
 
+The device MUST NOT offer feature bits corresponding to features
+it would not support if accepted by the driver (even if the
+driver is prohibited from accepting the feature bits by the
+specification); for the sake of clarity, this refers to feature
+bits not described in this specification, reserved feature bits
+and feature bits reserved or not supported for the specific
+transport or the specific device type, but this does not preclude
+devices written to a future version of this specification from
+offering such feature bits should such a specification have a
+provision for devices to support the corresponding features.
+
 If a device has successfully negotiated a set of features
 at least once (by accepting the FEATURES_OK \field{device
 status} bit during device initialization), then it SHOULD
-- 
MST

