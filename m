Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2F36139
	for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197387; cv=none; b=WzklLp0CNCXw5OGdZKKT3Qkk8y6BwpdNROu/zKkqWn0taq+6DosmLGy/loPDucwe5x7JnbuHdEP55a/2fXLrl7MRdvQEuqqHNTH0Afxvll6oTG44SSrlSlewpfX7tkV/8nd3ec1iK6sO1+c1yRrXVp0KIjj++2yjb4L6R3Ckq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197387; c=relaxed/simple;
	bh=7ctcgPh15jjSCGoZki0JEOj3XUWS5LIlzI1E4luHZY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YeNdQqvCR5lXVORzqnwj51/qCo7SGAiuIC4WiFiCo40gpGb+LzKlaqY57xu89MOJnpjBb5YQmmONkMfoKsLAxCTJq00vYOnJmZwrLLMyD3Sz+gF3A5eetlgWYFBvWJgWZKPp71m8a3zx333so/XzyqF1/Fz7U8BtkAqYoRYeJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7ickD81; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7ickD81"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f10092c8c7so2020686a34.1
        for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716197385; x=1716802185; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GKgbFqqGJPcT/JmvLIyjTk8WBY1efHY0YB4KJ2vnDk=;
        b=G7ickD81CX615jvsjXF0MoOB7XIjbG8x/mLmUaXhpfWgKp5e3JNt8Nbqoj9EuJ5I9n
         9Vj/2of166vYoqtVR0XqE1xynD4WPJIBFQE4qnNY5BWZ7IT1mQCVQiJCoe+7zPtLVCIq
         ECngzcVpFD+6RmedbRQOsoyk+eOQbznCItqOxswKTCB0xQ08leS5/bYS1JPDvatxylwY
         zZHVDEqlCysst2lSSgMj1hU6bBKascFNjrgDLR8l2H/cSKJKMdlIjDSqvnRl8/T7GMIH
         s8LRFrk6Szm8UZXznABofC8ERkxwA137bG7YEHneubkhU+9IUOtRu86NQjBNW0g94BbP
         97YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716197385; x=1716802185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GKgbFqqGJPcT/JmvLIyjTk8WBY1efHY0YB4KJ2vnDk=;
        b=pWZ/ZsgZ4BhDDCjVeX7aulPI3UUdPDpxRM4bnI2TCxphZQnkOecJEyIGRUvR4XewN8
         o7dmjudXykVCTM8hVtFODXXiuOirMVnL9njw5RJ9JNql+6P05903eTA3xJXQsjxlyC13
         gRDLJ1EgfGChiDlD2hNqXzQy8Ph4HfjsPJnCwRH6wobW/YCDs2G5z062tW+xQgu5IHR2
         8n/bdRwXD3FvRIV75dST9Mv60TsTyIwTVGzaGQiBY4fCaKNGXlKLAdyYuiJCYhpnEMWJ
         cJfuWwDh41xKcDvI6vgIF9ABs/+uaeXJLbLUm6dWcaJBLXoc5345f2aFCLx891HVp7wf
         APLw==
X-Forwarded-Encrypted: i=1; AJvYcCVU4SXKknRLw3LAetcqXKvw9XscKGC6i1avD4ZVinWkx87k/i3H3CKEGC5OCFWlPOQS6ZN+Iy7SzW7w/i+MwqS5Ct29yDakBAu5Mw==
X-Gm-Message-State: AOJu0Yz5S2/ACYL9IiXjPdsAGdJMFN7/LurnHh3BHMYITMP4dxsqG6oN
	rRTRpP1tdaGYf/PvWoM/VxGVU1XikQJbLsLodZDWs5jpjEnjKvlTZ/nWBy+hQow=
X-Google-Smtp-Source: AGHT+IEElCMvpUMXJVxl+nEnCx7mTgQuupenCOvsZLzIQGoeZY6teHCmqYpqB21sjAjnOLx2TrCWUA==
X-Received: by 2002:a05:6830:1d76:b0:6f1:2ff2:d89b with SMTP id 46e09a7af769-6f12ff2da75mr14441715a34.21.1716197384958;
        Mon, 20 May 2024 02:29:44 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a6327fcsm18738958a12.14.2024.05.20.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 02:29:44 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: virtio-comment@lists.linux.dev,
	virtio-dev@lists.linux.dev
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH V3 Resend] virtio-transport: Clarify requirements
Date: Mon, 20 May 2024 14:59:40 +0530
Message-Id: <3543c631e29d35a667ca9d9e912d1a6db1feb0ce.1716197180.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The virtio documentation currently doesn't define any generic
requirements that are applicable to all transports. They can be useful
while adding support for a new transport.

This commit tries to define the same.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Minor fixes.
- Added Reviewed by from Alex.

V1->V2:
- Lot of changes after discussions with Alex and Cornelia.
- Almost a rewrite of the first commit.
- Add Transport normative sections.

 commands.tex    |  3 +-
 conformance.tex | 14 +++++++++
 content.tex     | 78 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/commands.tex b/commands.tex
index 25ea8ee3bc78..b64b14424bd2 100644
--- a/commands.tex
+++ b/commands.tex
@@ -7,7 +7,8 @@
 % How we format a field name
 \newcommand{\field}[1]{\emph{#1}}
 
-% Mark a normative section (driver or device)
+% Mark a normative section (driver or device, or transport)
+\newcommand{\transportnormative}[3]{#1{Transport Requirements: #2}\label{transportnormative:#3}}
 \newcommand{\drivernormative}[3]{#1{Driver Requirements: #2}\label{drivernormative:#3}}
 \newcommand{\devicenormative}[3]{#1{Device Requirements: #2}\label{devicenormative:#3}}
 \newcounter{clausecounter}
diff --git a/conformance.tex b/conformance.tex
index dc00e84e75ae..4a873169ce63 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -11,6 +11,10 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 
 Conformance targets:
 \begin{description}
+\item[Transport] A transport MUST conform to one conformance clauses:
+  \begin{itemize}
+    \item Clause \ref{sec:Conformance / Transport Conformance}.
+  \end{itemize}
 \item[Driver] A driver MUST conform to four conformance clauses:
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Driver Conformance}.
@@ -66,6 +70,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
   \end{itemize}
 \end{description}
 
+\conformance{\section}{Transport Conformance}\label{sec:Conformance / Transport Conformance}
+
+A transport MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{transportnormative:Virtio Transport Options / Virtio Transport Requirements}
+\end{itemize}
+
 \conformance{\section}{Driver Conformance}\label{sec:Conformance / Driver Conformance}
 
 A driver MUST conform to the following normative statements:
@@ -93,6 +105,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Sending Available Buffer Notifications}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Initialization}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Cleanup}
+\item \ref{drivernormative:Virtio Transport Options / Virtio Transport Requirements}
 \item \ref{drivernormative:Reserved Feature Bits}
 \end{itemize}
 
@@ -172,6 +185,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Transport Requirements}
 \item \ref{devicenormative:Reserved Feature Bits}
 \end{itemize}
 
diff --git a/content.tex b/content.tex
index 0a62dce5f65f..a79993b5ed69 100644
--- a/content.tex
+++ b/content.tex
@@ -631,8 +631,82 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
 
 \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
 
-Virtio can use various different buses, thus the standard is split
-into virtio general and bus-specific sections.
+Devices and drivers can use different transport methods to enable
+interaction, for example PCI, MMIO, or Channel I/O. The transport
+methods define various aspects of the communication between the device
+and the driver, like device discovery, exchanging capabilities,
+interrupt handling, data transfer, etc. For example, in a host/guest
+architecture, the host might expose a device to the guest on a PCI bus,
+and the guest will use a PCI-specific driver to interact with it.
+
+The standard is split into sections describing general virtio
+implementation and transport-specific sections.
+
+\section{Virtio Transport Requirements}\label{sec:Virtio Transport Options / Virtio Transport Requirements}
+
+\transportnormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options / Virtio Transport Requirements}
+The transport MUST provide a mechanism for the driver to discover the
+device.
+
+The transport MUST provide a mechanism for the driver to identify the
+device type.
+
+The transport MUST provide a mechanism for communicating virtqueue
+configurations between the device and the driver.
+
+The transport MUST allow multiple virtqueues per device. The number of
+virtqueues for a pair of device-driver are governed by the individual
+device protocol.
+
+The transport MUST provide a mechanism that the device and the driver
+use to access memory for implementing virtqueues.
+
+The transport MUST provide a mechanism for the device to notify the
+driver and a mechanism for the driver to notify the device, for example
+regarding availability of a buffer on the virtqueue.
+
+The transport MAY provide a mechanism for the driver to initiate a
+reset of the virtqueues and device.
+
+The transport SHOULD provide a mechanism for the driver to read the
+device status. The transport MUST provide a mechanism for the driver to
+change the device status.
+
+The transport MUST provide a mechanism to implement config space between
+the device and the driver.
+
+\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options / Virtio Transport Requirements}
+
+The device MUST keep any data associated with a device-initiated
+transaction accessible to the driver until the driver acknowledges the
+transaction to be complete.
+
+The device MUST NOT access the contents of a virtqueue before the
+driver notifies, in a transport defined way, the device that the
+virtqueue is ready to be accessed.
+
+The device MUST NOT access or modify buffers on a virtqueue after it has
+notified the driver about their availability.
+
+The device MUST reset the virtqueues if requested by the driver, in a
+transport defined way, if the transport provides such a method.
+
+\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options / Virtio Transport Requirements}
+
+The driver MUST acknowledge device notifications, as mandated by the
+transport.
+
+The driver MUST NOT access virtqueue contents before the device notifies
+about the readiness of the same.
+
+The driver MUST NOT access buffers, after it has added them to the
+virtqueue and notified the device about their availability. The driver
+MAY access them after the device has processed them and notified the
+driver of their availability, in a transport defined way.
+
+The driver MAY ask the device to reset the virtqueues if, for example,
+the driver times out waiting for a notification from the device for a
+previously queued request.
 
 \input{transport-pci.tex}
 \input{transport-mmio.tex}
-- 
2.31.1.272.g89b43f80a514

