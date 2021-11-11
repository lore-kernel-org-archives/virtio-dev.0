Return-Path: <eperezma@redhat.com>
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v3 1/2] content: Explain better the status clearing bits
Date: Thu, 11 Nov 2021 19:58:11 +0100
Message-Id: <20211111185812.2326093-2-eperezma@redhat.com>
In-Reply-To: <20211111185812.2326093-1-eperezma@redhat.com>
References: <20211111185812.2326093-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, mst@redhat.com, jasowang@redhat.com
Cc: amikheev@nvidia.com, stefanha@redhat.com, shahafs@nvidia.com, oren@nvidia.com, pasic@linux.ibm.com, cohuck@redhat.com, bodong@nvidia.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, parav@nvidia.com, mgurtovoy@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

The spec tells that "The driver MUST NOT clear a device status bit", but
a device using PCI transport reset a virtio device writing 0 to device
status. In some way, that is to clear all its bits.

Instead of add an exception, tell explicitely the status bits that
the driver cannot clear anytime in a normal operation, so conformant
device and drivers keeps being conformant.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 content.tex | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index 5d112af..2aa3006 100644
--- a/content.tex
+++ b/content.tex
@@ -60,9 +60,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 initialization sequence specified in
 \ref{sec:General Initialization And Device Operation / Device
 Initialization}.
-The driver MUST NOT clear a
-\field{device status} bit.  If the driver sets the FAILED bit,
-the driver MUST later reset the device before attempting to re-initialize.
+The driver MUST NOT clear ACKNOWLEDGE, DRIVER, DRIVER_OK, FEATURES_OK or
+DEVICE_NEEDS_RESET bits of \field{device status}, except if resetting the whole
+device.  If the driver sets the FAILED bit, the driver MUST later reset the
+device before attempting to re-initialize.
 
 The driver SHOULD NOT rely on completion of operations of a
 device if DEVICE_NEEDS_RESET is set.
-- 
2.27.0

