Return-Path: <virtio-dev-return-14358-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C51C48BF6
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 01:54:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E23E22238D
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 01:54:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DDB4698666F
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 01:54:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C91829863AB; Tue, 27 Feb 2024 01:54:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B905B98644E
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2024 01:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998852; x=1709603652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jxQ3AzAKIjqI1f0zroO9uma63qUVyrefEf06tcyrkg=;
        b=FHV1fLdQK+hDYuAyi8yZ73pqklao38MEEqdhCyfsIUjcFl+JYuS7o5MEOBXBfxDs05
         cWDfac64ofsD4cclltR8WHfjjWQB50wbLiig2D2tsxptecWecRRvUqeFSW6Jf5A1zTxx
         nna5HX9txb8EkunoPvfwgV6jRTly+mVac5/tuZf2XIoVvved0WVZVLglfPfNK1qoy3or
         wlTPEvOacz6xwV0EIXzqAhreyYUeQRHmFzboBrQp4fVtUkXXYPWziwOM9yBlmwAYwN6y
         FAKjt0E+bsxOFkCp7fjVmH2iqWQG9GJfa0qQPuKwMwB2UG3yXSddlhF5HNKQCSnu5mLl
         Reeg==
X-Forwarded-Encrypted: i=1; AJvYcCXgmGeiRfk9SElKghBvydjEPiEDitgnBVMrvpp/I5jj7eKUN5wb32+psVfuOPdJQiJ+bb2DE+0zOIIpz9z2lST569TJ83qzkOsJMpdOQaMN
X-Gm-Message-State: AOJu0YxNNNr4WugCYd6x5x3QCWiukpIqCepjKyiUyDLPMGz6gQ9uvVta
	R5RojM7Co822TUyfyvZMQ0HkLqiJhzx+1+uIxszDBAXnq2rvNj/x6vMkiuhsrJQgC84Q6SfbQko
	=
X-Google-Smtp-Source: AGHT+IEty0WX6n/H3Yya9sxkas81/0zEAzMsAsHCTgGWGPPif1wiMmNHlsfwyRu6lklA0poEch+npg==
X-Received: by 2002:a05:6a00:9382:b0:6e5:3434:d5e0 with SMTP id ka2-20020a056a00938200b006e53434d5e0mr4919776pfb.2.1708998852004;
        Mon, 26 Feb 2024 17:54:12 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: parav@nvidia.com,
	David Stevens <stevensd@chromium.org>
Date: Tue, 27 Feb 2024 10:53:45 +0900
Message-ID: <20240227015345.3614965-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240227015345.3614965-1-stevensd@chromium.org>
References: <20240227015345.3614965-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v5 1/1] Add SUSPEND bit to device status

Add a SUSPEND bit to the device status field to allow drivers to suspend
virtio devices. On systems where drivers don't directly manage interrupt
routing (e.g. Linux), this allows the drivers to suspend their devices
and prevent interrupts from being sent when the interrupt routing system
does not expect interrupts.
---
 content.tex | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/content.tex b/content.tex
index 0a62dce5f65f..2183c63c45ea 100644
--- a/content.tex
+++ b/content.tex
@@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 
 \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
   an error from which it can't recover.
+
+\item[SUSPEND (16)] Indicates that the device has been suspended by the
+  driver. Only valid when the VIRTIO_F_SUSPEND feature bit is negotiated.
 \end{description}
 
 The \field{device status} field starts out as 0, and is reinitialized to 0 by
@@ -60,9 +63,11 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 initialization sequence specified in
 \ref{sec:General Initialization And Device Operation / Device
 Initialization}.
-The driver MUST NOT clear a
-\field{device status} bit.  If the driver sets the FAILED bit,
-the driver MUST later reset the device before attempting to re-initialize.
+
+The driver MUST NOT clear a \field{device status} bit, except for the
+SUSPEND bit as described in \ref{sec:General Initialization And Device
+Operation / Device Suspend}. If the driver sets the FAILED bit, the
+driver MUST later reset the device before attempting to re-initialize.
 
 The driver SHOULD NOT rely on completion of operations of a
 device if DEVICE_NEEDS_RESET is set.
@@ -73,6 +78,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 recover by issuing a reset.
 \end{note}
 
+If VIRTIO_F_SUSPEND is negotiated, the driver MUST manage the SUSPEND bit
+as described in \ref{sec:General Initialization And Device Operation /
+Device Suspend}. Otherwise, the driver MUST NOT set the SUSPEND bit.
+
 \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
 
 The device MUST NOT consume buffers or send any used buffer
@@ -82,6 +91,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
 MUST send a device configuration change notification to the driver.
 
+If VIRTIO_F_SUSPEND is negotiated, the device MUST manage the SUSPEND bit
+as described in \ref{sec:General Initialization And Device Operation /
+Device Suspend}. Otherwise, the device MUST ignore the SUSPEND bit.
+
 \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
 
 Each virtio device offers all the features it understands.  During
@@ -99,10 +112,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
 \begin{description}
 \item[0 to 23, and 50 to 127] Feature bits for the specific device type
 
-\item[24 to 41] Feature bits reserved for extensions to the queue and
+\item[24 to 42] Feature bits reserved for extensions to the queue and
   feature negotiation mechanisms
 
-\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
+\item[43 to 49, and 128 and above] Feature bits reserved for future extensions.
 \end{description}
 
 \begin{note}
@@ -629,6 +642,67 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
 
 Thus a driver MUST ensure a virtqueue isn't live (by device reset) before removing exposed buffers.
 
+\section{Device Suspend}\label{sec:General Initialization And Device Operation / Device Suspend}
+
+When the VIRTIO_F_SUSPEND feature is negotiated, the driver can set the
+SUSPEND bit in \field{device status} to suspend a live device, and can
+clear the SUSPEND bit to resume a suspended device. A suspended device
+should pause its operation, but it must maintain it state such that it
+can immediately continue operation upon being resumed.
+
+Suspending a device via the SUSPEND bit is a seperate process from any
+transport-specific suspend mechanism.
+
+\drivernormative{\subsection}{Device Suspend}{General Initialization And Device Operation / Device Suspend}
+
+The driver MUST NOT set the SUSPEND bit if the DRIVER_OK bit is not set.
+
+After writing a new value to the SUSPEND bit, the driver MUST wait for
+the device to acknowledged the transition by reading from \field{device
+status} until the returned value of the SUSPEND bit matches the written
+value. During this period, the driver MAY abort the transition by writing
+a new value to the SUSPEND bit or by resetting the device.
+
+A driver MUST NOT access the device configuration space of a suspended
+device, except for \field{device status}.
+
+A driver MAY suspend a device that has buffers in its virtqueues. While
+the device is suspended, a driver MUST NOT modify any available buffers
+or their descriptors.
+
+A driver MUST NOT make any new buffers available to a suspended device.
+
+If a transport-specific suspend mechanism is available, the driver SHOULD
+use it to put the device into a deeper suspend state after setting the
+SUSPEND bit.
+
+\drivernormative{\subsection}{Device Suspend}{General Initialization And Device Operation / Device Suspend}
+
+A device MUST ignore writes to the SUSPEND bit if the DRIVER_OK bit is
+not set.
+
+A device MUST maintain its state while suspended such that all driver
+visible state after resuming exactly matches driver visible state
+before suspending.
+
+A device MUST ignore all writes to its configuration space while
+suspended, except for writes to \field{device status}.
+
+A device MUST NOT send notifications, access any virtqueues, or modify
+any fields in its configuration space while suspended.
+
+A device MAY send notifications, access any virtqueues, or modify its
+configuration space after the driver writes the SUSPEND bit but before
+the device acknowledges the transition by returning a \field{device
+status} value with the SUSPEND bit set. A device SHOULD finish processing
+and send the used buffer notification for any buffers it is able to
+before acknowledging the transition, but MAY retain buffers that cannot
+be immiedately processed (e.g. empty buffers in a network recieveq).
+
+A device SHOULD take steps to minimize its resource consumption while
+suspended, although what this involves is specific to the particular
+device implementation.
+
 \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
 
 Virtio can use various different buses, thus the standard is split
@@ -872,6 +946,11 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
 	handling features reserved for future use.
 
+  \item[VIRTIO_F_SUSPEND(42)] This feature indicates that the driver can
+    suspend the device via the SUSPEND bit in \field{device status} (see
+    \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}).
+
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
2.44.0.rc0.258.g7320e95886-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

