Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056514285
	for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200425; cv=none; b=fW58xFn5v2Ndsu2q8tFPKJyVN+7Pknu9x5v0VVwSEQOCrIvASAHEjSZdRPY2XhmfFJPI70D6rcNMz6IcDarMLs4DvkTWBLjzUEazmUU1WEc7WPexlfD+Jng4jhq5skGKtm5xcQ1Ogl45dnB0juUbA5+nQatPCVSJKNx6stPz9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200425; c=relaxed/simple;
	bh=t/a4WqbS0dY9g/oJHR3v5oR/eoBqs/pqN11hNofn2+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BEfU057yB5kLnw8ahFrxw5D3UEtDZnYVncIiYh9T4ghS0MdlywfZtqM1sN2sKShup+LOUIMlVYwNYfj0wmn978PhM72FzsoHMOKNKPTrSCBibvVh9JkzkwSWYE1FrFVUk50s+IYjm61/HnIUEBpik7lqWHAePaj6gpyJ+cCHOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7vxJEqG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7vxJEqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716200421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeBpalmqc7a0/ZXDVvMbIw/GwYeD7KeBAcVqQi4zpg0=;
	b=d7vxJEqG4eRtTNyKPPrygotirfe1HaD5WjHm6uzI295Hj1lHOKoy113pY6h9GvrM9IqWjp
	Z565Vl9zSewh3cV7CR85UM7URi8iQi1R6ZjrIR+I0byQoxP3lxO1H7BvtHcUYOr8f+u8pg
	MhNUzwv9YwtQOQavdSlj1VUY/yQOo2k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-u4s3hSC8OJqEwOMbSJw80A-1; Mon, 20 May 2024 06:20:20 -0400
X-MC-Unique: u4s3hSC8OJqEwOMbSJw80A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792ca09135dso1281777285a.0
        for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 03:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716200420; x=1716805220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeBpalmqc7a0/ZXDVvMbIw/GwYeD7KeBAcVqQi4zpg0=;
        b=QoEwrb/kuO5vqK+y7aN4yhsYiC09uElTGzSczvsC32oaXk2X7qj2usqV5G1a8HC3N5
         XBPih2F082I28SuMkwRS4sNwTMmy1/VqgKNvxr/X/fx/4101VMEnw2XLYKZr1NSr4vuk
         Hp8d060UvtvRF7sCX51ZTvNVdswznnTEcrXozU2HhXgdRJCDqadWNrWWBGemI9c1Qsmp
         roAyPLS7lnGgxw1oVardXrL/PGzCqwUX+LhupMFQe0ZFBi35Uhm8qRWkvr5JggCMrVo3
         oQPLFDV6dpixclfCAhcT138+xMUB894HPOrrcMD/8cqE3gK8tm7Crfef28y/dSO9qyqH
         Ur2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWauaZsjVFI3Hp6g+wSfjHzaOVaIhVH1ACnoHceCArfkvnrBAy4lhYd47X9Dw6f7rK0TAa3jVGdal0KaamrHixPacfX+8oDwv/xiQ==
X-Gm-Message-State: AOJu0YxM7zVRWSBk2R0Y7guPm4tc9rKJKf+6WlOMIAFkztXX73QTl+ZJ
	AGWwb3yZWW7Y96ZfHNfENbT65WH8kSNkH1Ir5Xdes9Z2rm7GidtQUxcEx2wAIvmkahj/fOIB/R8
	xbq5cIUP2GpKhpY0Klasi0h/rzOKPKblDPe0CnnZzjGfOE7z474F4r8g5k3M=
X-Received: by 2002:a05:620a:d4d:b0:792:984f:ef04 with SMTP id af79cd13be357-792c759ab10mr2873959485a.24.1716200419923;
        Mon, 20 May 2024 03:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERESeX4lNHdiYtl1uPlEhQmrx8TjOCF0q6kZewLf2ZquKEBcZR3E0G3dRid6VBj0jTuIMhdw==
X-Received: by 2002:a05:620a:d4d:b0:792:984f:ef04 with SMTP id af79cd13be357-792c759ab10mr2873958185a.24.1716200419525;
        Mon, 20 May 2024 03:20:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-77.business.telecomitalia.it. [87.12.25.77])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27f870sm1171201085a.28.2024.05.20.03.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 03:20:19 -0700 (PDT)
Date: Mon, 20 May 2024 12:20:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtio-comment@lists.linux.dev, virtio-dev@lists.linux.dev, 
	Vincent Guittot <vincent.guittot@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
	stratos-dev@op-lists.linaro.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 Resend] virtio-transport: Clarify requirements
Message-ID: <a752usapxpmlwpm5ywvccrrkmumi5aosbzvsxjghsotn4kmgyq@hlmjdhedeqbz>
References: <3543c631e29d35a667ca9d9e912d1a6db1feb0ce.1716197180.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3543c631e29d35a667ca9d9e912d1a6db1feb0ce.1716197180.git.viresh.kumar@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Viresh,
I haven't followed v1 and v2, so apologies in advance if my comments 
have already been discussed.

On Mon, May 20, 2024 at 02:59:40PM GMT, Viresh Kumar wrote:
>The virtio documentation currently doesn't define any generic
>requirements that are applicable to all transports. They can be useful
>while adding support for a new transport.
>
>This commit tries to define the same.
>
>Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>---
>V2->V3:
>- Minor fixes.
>- Added Reviewed by from Alex.
>
>V1->V2:
>- Lot of changes after discussions with Alex and Cornelia.
>- Almost a rewrite of the first commit.
>- Add Transport normative sections.
>
> commands.tex    |  3 +-
> conformance.tex | 14 +++++++++
> content.tex     | 78 +++++++++++++++++++++++++++++++++++++++++++++++--
> 3 files changed, 92 insertions(+), 3 deletions(-)
>
>diff --git a/commands.tex b/commands.tex
>index 25ea8ee3bc78..b64b14424bd2 100644
>--- a/commands.tex
>+++ b/commands.tex
>@@ -7,7 +7,8 @@
> % How we format a field name
> \newcommand{\field}[1]{\emph{#1}}
>
>-% Mark a normative section (driver or device)
>+% Mark a normative section (driver or device, or transport)
>+\newcommand{\transportnormative}[3]{#1{Transport Requirements: #2}\label{transportnormative:#3}}
> \newcommand{\drivernormative}[3]{#1{Driver Requirements: #2}\label{drivernormative:#3}}
> \newcommand{\devicenormative}[3]{#1{Device Requirements: #2}\label{devicenormative:#3}}
> \newcounter{clausecounter}
>diff --git a/conformance.tex b/conformance.tex
>index dc00e84e75ae..4a873169ce63 100644
>--- a/conformance.tex
>+++ b/conformance.tex
>@@ -11,6 +11,10 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>
> Conformance targets:
> \begin{description}
>+\item[Transport] A transport MUST conform to one conformance clauses:
>+  \begin{itemize}
>+    \item Clause \ref{sec:Conformance / Transport Conformance}.
>+  \end{itemize}
> \item[Driver] A driver MUST conform to four conformance clauses:
>   \begin{itemize}
>     \item Clause \ref{sec:Conformance / Driver Conformance}.
>@@ -66,6 +70,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>   \end{itemize}
> \end{description}
>
>+\conformance{\section}{Transport Conformance}\label{sec:Conformance / Transport Conformance}
>+
>+A transport MUST conform to the following normative statements:
>+
>+\begin{itemize}
>+\item \ref{transportnormative:Virtio Transport Options / Virtio Transport Requirements}
>+\end{itemize}
>+
> \conformance{\section}{Driver Conformance}\label{sec:Conformance / 
> Driver Conformance}
>
> A driver MUST conform to the following normative statements:
>@@ -93,6 +105,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> \item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Sending Available Buffer Notifications}
> \item \ref{drivernormative:General Initialization And Device Operation / Device Initialization}
> \item \ref{drivernormative:General Initialization And Device Operation / Device Cleanup}
>+\item \ref{drivernormative:Virtio Transport Options / Virtio Transport Requirements}
> \item \ref{drivernormative:Reserved Feature Bits}
> \end{itemize}
>
>@@ -172,6 +185,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> \item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
> \item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
> \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
>+\item \ref{devicenormative:Virtio Transport Options / Virtio Transport Requirements}
> \item \ref{devicenormative:Reserved Feature Bits}
> \end{itemize}
>
>diff --git a/content.tex b/content.tex
>index 0a62dce5f65f..a79993b5ed69 100644
>--- a/content.tex
>+++ b/content.tex
>@@ -631,8 +631,82 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
>
> \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
>
>-Virtio can use various different buses, thus the standard is split
>-into virtio general and bus-specific sections.
>+Devices and drivers can use different transport methods to enable
>+interaction, for example PCI, MMIO, or Channel I/O. The transport
>+methods define various aspects of the communication between the device
>+and the driver, like device discovery, exchanging capabilities,
>+interrupt handling, data transfer, etc. For example, in a host/guest
>+architecture, the host might expose a device to the guest on a PCI bus,
>+and the guest will use a PCI-specific driver to interact with it.
>+
>+The standard is split into sections describing general virtio
>+implementation and transport-specific sections.
>+
>+\section{Virtio Transport Requirements}\label{sec:Virtio Transport Options / Virtio Transport Requirements}
>+
>+\transportnormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options / Virtio Transport Requirements}
>+The transport MUST provide a mechanism for the driver to discover the
>+device.

This seems a little too stringent. For example, does MMIO offer a 
discovery mechanism? IIRC we have to pass the address via device tree or 
kernel command line.

>+
>+The transport MUST provide a mechanism for the driver to identify the
>+device type.
>+
>+The transport MUST provide a mechanism for communicating virtqueue
>+configurations between the device and the driver.
>+
>+The transport MUST allow multiple virtqueues per device. The number of
>+virtqueues for a pair of device-driver are governed by the individual
>+device protocol.
>+
>+The transport MUST provide a mechanism that the device and the driver
>+use to access memory for implementing virtqueues.
>+
>+The transport MUST provide a mechanism for the device to notify the
>+driver and a mechanism for the driver to notify the device, for example
>+regarding availability of a buffer on the virtqueue.
>+
>+The transport MAY provide a mechanism for the driver to initiate a
>+reset of the virtqueues and device.
>+
>+The transport SHOULD provide a mechanism for the driver to read the
>+device status. The transport MUST provide a mechanism for the driver to
>+change the device status.
>+
>+The transport MUST provide a mechanism to implement config space 

"configuration space"

>between
>+the device and the driver.
>+
>+\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options / Virtio Transport Requirements}
>+
>+The device MUST keep any data associated with a device-initiated
>+transaction accessible to the driver until the driver acknowledges the
>+transaction to be complete.
>+
>+The device MUST NOT access the contents of a virtqueue before the
>+driver notifies, in a transport defined way, the device that the
>+virtqueue is ready to be accessed.
>+
>+The device MUST NOT access or modify buffers on a virtqueue after it has
>+notified the driver about their availability.
>+
>+The device MUST reset the virtqueues if requested by the driver, in a

Should we also talk about the possibility of resetting the entire 
device?

Thanks,
Stefano

>+transport defined way, if the transport provides such a method.
>+
>+\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options / Virtio Transport Requirements}
>+
>+The driver MUST acknowledge device notifications, as mandated by the
>+transport.
>+
>+The driver MUST NOT access virtqueue contents before the device notifies
>+about the readiness of the same.
>+
>+The driver MUST NOT access buffers, after it has added them to the
>+virtqueue and notified the device about their availability. The driver
>+MAY access them after the device has processed them and notified the
>+driver of their availability, in a transport defined way.
>+
>+The driver MAY ask the device to reset the virtqueues if, for example,
>+the driver times out waiting for a notification from the device for a
>+previously queued request.
>
> \input{transport-pci.tex}
> \input{transport-mmio.tex}
>-- 
>2.31.1.272.g89b43f80a514
>
>

