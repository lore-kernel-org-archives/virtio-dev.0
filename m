Return-Path: virtio-dev-return-5695-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53019986018
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Apr 2019 18:28:02 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Fri, 26 Apr 2019 21:27:16 +0300
Message-Id: <1556303237-19393-4-git-send-email-ndragazis@arrikto.com>
In-Reply-To: <1556303237-19393-1-git-send-email-ndragazis@arrikto.com>
References: <1556303237-19393-1-git-send-email-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v2 3/4] vhost-user: add requirements for the notification capability
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The configuration structure for the notification capability has certain
device/driver requirements, similar to those of the MSI-X vector
configuration. Add these requirements to the device spec.

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 virtio-vhost-user.tex | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index 13ecd41..d1b9957 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -275,6 +275,46 @@ \subsubsection{Notification structure layout}\label{sec:Device Types / Vhost-use
 \field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to change the
 MSI-X vector for that notification.
 
+\devicenormative{\paragraph}{Notification capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
+
+If MSI-X is available, device MUST support mapping any master queue
+event to any valid vector 0 to MSI-X \field{Table Size}. The valid
+vectors are reported in \field{Table Size} in the MSI-X Capability as
+specified in \hyperref[intro:PCI]{[PCI]}.
+
+Device MUST support unmapping any master queue event.
+
+The device MUST return vector mapped to a given master queue event,
+(\field{NO_VECTOR} if unmapped) on read of
+\field{notification_msix_vector}. The device MUST have all master queue
+events unmapped upon reset.
+
+Devices SHOULD NOT cause mapping an event to vector to fail unless it is
+impossible for the device to satisfy the mapping request. Devices MUST
+report mapping failures by returning the \field{NO_VECTOR} value when
+the relevant \field{notification_msix_vector} field is read.
+
+\drivernormative{\paragraph}{Notification capability}{Device Types /
+Vhost-user Device Backend / Additional Device Resources over PCI /
+Noification capability}
+
+Driver MUST support device with any MSI-X Table Size 0 to 0x7FF. Driver
+MAY fall back on using INT\#x interrupts for a device which only
+supports one MSI-X vector (MSI-X Table Size = 0).
+
+Driver MAY intepret the \field{Table Size} as a hint from the device for
+the suggested number of MSI-X vectors to use.
+
+Driver MUST NOT attempt to map an event to a vector outside the MSI-X
+Table supported by the device, as reported by \field{Table Size} in the
+MSI-X Capability.
+
+After mapping an event to vector, the driver MUST verify success by
+reading the Vector field value: on success, the previously written value
+is returned, and on failure, \field{NO_VECTOR} is returned. If a mapping
+failure is detected, the driver MAY retry mapping with fewer vectors,
+disable MSI-X or report device failure.
+
 \subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
 
 The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

