Return-Path: <virtio-dev-return-14308-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE567C4829A
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 05:55:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 27AEE33087
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 05:55:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1821B986596
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 05:55:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0B7F6986589; Wed, 14 Feb 2024 05:55:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E988198658E
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Feb 2024 05:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890146; x=1708494946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GKgbFqqGJPcT/JmvLIyjTk8WBY1efHY0YB4KJ2vnDk=;
        b=nwPlXsRsViz6FV3kl1WeMmNY5oOmUbRmwSi9DkdEW/EFdjHbfo0pQOgMHroOD21zaM
         AA8X9jo5brtiK5AMI8RsLEFH5O61zVA794hwbhIfDDC2UgfXFwJQJCiSkpQz93/0zBWl
         h6colBsO7MR6lBsnFW7Cd2P0bo5HPwJPRaKU77GEQHcF1SVPcG30Vg5kR3/ASUfKEjFD
         mgX/g3xTrvyHzHI6IubQSa53hrxQSHvjjjl1CZXm9xLWe7+HAsScK8ujS/Md78mi52lv
         lZbDnXTP8Rs8lUlK5JE/xAzAOa9M/uAceTRkKdCfKtMRhiao5zBmWMvWM7E2t6Ov/lgW
         W+fA==
X-Gm-Message-State: AOJu0Yw24FUGthxnyUXR8dhbW3GQ8ApYXKvV/FdNQQbHw4CuiTnE+nKR
	jzBv9xJxE3YoioYHC77OUPn3Y1Z3PuKv5sM/9eSBb5rg+VsfspUoZCjV9qZjAqxmWtr+zvCYkSh
	3
X-Google-Smtp-Source: AGHT+IEmREhU+bYX+8S60p45d4tSpramG7gaBH9aMS07ZkdkshbA2UiNneAhVCQtJrvdIc0O2CZ+qw==
X-Received: by 2002:a9d:7a4c:0:b0:6e2:decb:246a with SMTP id z12-20020a9d7a4c000000b006e2decb246amr1636443otm.3.1707890146249;
        Tue, 13 Feb 2024 21:55:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQVEbcOCPbFP3PcdKxDbBMiJ46xVDfY5ZJS1W4vv4lBbFIeA9HDFp95T7sHCxGDzzMZ7C4twmfJ8NfPwQUdirNgVSuWfrQZ4baU+dyOeNUDfQLy9pl+aptveGuauZg1CrL5ZXuM8OKaMjWP2S4goBpQ9R5ktp/UlVEMyysgiY5IeDVpYayjuV6b0nQZ4YtBhO3JnkIozqfJPC1i8QelRhGM+ZZsrwwJG3Hunexx16lU01+i0eSOzvKkDBp966iOOoTpYsakE6KBoNMTwcsjkygevzqw2vOK48MBj85ixCwv8G0ugfK6J19fu84
From: Viresh Kumar <viresh.kumar@linaro.org>
To: virtio-dev@lists.oasis-open.org,
	Cornelia Huck <cohuck@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtio-comment@lists.oasis-open.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 14 Feb 2024 11:25:40 +0530
Message-Id: <3543c631e29d35a667ca9d9e912d1a6db1feb0ce.1707890070.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH V3] virtio-transport: Clarify requirements

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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

