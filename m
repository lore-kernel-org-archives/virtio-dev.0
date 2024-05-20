Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D01FC0E
	for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210336; cv=none; b=rKHEBkxC2SLMrVANWekG5/gRQMzgq65DSFHt+c8MBBXuj38OS6LZpWF6CufesLrCf/3FkdmZYp/btlcXLcxaHqZSkeFFA7hJ+7IVIlcU4SzsnSy/ZbPfwybILg9jU45WLmJfsl8iJs+wJE6g2Ep0M9VSji/QPtHrH2vcrki6mGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210336; c=relaxed/simple;
	bh=COSiQNyWKmcvhLUuwcg+x304UIg3hgFpCp6h3k/MwJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KJ/kmKcxCBQt7Bc6lrYmx6fPfYQ68FMsZGvoSFTQjjFIJLOg/xkz5GMFh9rObAgVdAGGdvdeLQFfGFiR1E1NFhLXNqXE3RkbMHCzaW/H5gQzLjUc0w5EJtCe3f/8erJeisJuGqp7lVv9/NtzjmrFTIIIE4P1vY9H33/OugO+Sd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYNCnZs/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYNCnZs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716210333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4pp8219gK9qK6MxvRbQjRJVJvZWT7boFXdOsQBojzY=;
	b=LYNCnZs/4/D+i8pR8bUYP5kTh8nzozD/QD0WTb4wvRxTqtNXmTigkhjNigloQgo4i64x+f
	igU6s8Ep6J3P8LTeS946rq86so08zCwHsCxaaWAK25LdJvDF09zffw2671HhJOWxDFOtCk
	ej0xL8FKHuf8Uo6V6HL26vjI2rn/qoY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-UUqkZhUWMTWVHVrQ4m6lgA-1; Mon, 20 May 2024 09:05:32 -0400
X-MC-Unique: UUqkZhUWMTWVHVrQ4m6lgA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4200ebdbf55so47456715e9.1
        for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 06:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716210331; x=1716815131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4pp8219gK9qK6MxvRbQjRJVJvZWT7boFXdOsQBojzY=;
        b=Gh91ohCFmompba1VB+kEihH73z0VyS/CqH6EPscc8GmZqSlJGaJopJoGjAtwMW7n2D
         73PjrsNLcD8+DuGeXef7BDdh90Ly7+VgUHSaEAjaI5isaPvypYkJvcMQ1hVB8QHzFCAr
         tRSVkRJi2OmH2Hn9Ti83Q3MejHeYxTbBw8Y8gADdg35P6qblJzIi8iVI1Iw680Dhg948
         AamyF7AfcAOOk4qcdKT2fcSsl5DDjKWgel9ygbxAjGiPKJo439GenLwjglJgvcgLYowe
         bQEck83LVtK2q00ZlMNbMzdIqxYw1UpFwef8PTJhzrq7VK7A0X7cpysaIUG+dsyG+Wfx
         DDEg==
X-Forwarded-Encrypted: i=1; AJvYcCUeYw9cy1U876Zv5LwbwZDBlshJnWU5NxNfGqKTfn+htQ1aoKTh5RwecWwo9LZAMhnzihfJjsqwz6dPQeNvNKXkw20NqB4iM7HawQ==
X-Gm-Message-State: AOJu0YwGQlmrZN168vXWkoNzhO5nX0kw8AeV0BZxszQ5xuiIXv05doiZ
	c7fLz4cyQXnUnA301eQf50tm0MvXJvhUNcBR0iSehHUNg2QPSqcLWu9z6G6SairBeM1w8XWmEaN
	XzFlxCT4mZIWqK9G9ADmIUMyji7Wi6qKSXMMhahbnnRIZCwW9vQObMU8xo0Q=
X-Received: by 2002:a05:600c:3d06:b0:420:11c1:b240 with SMTP id 5b1f17b1804b1-42011c1b30amr173197475e9.24.1716210330956;
        Mon, 20 May 2024 06:05:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQho4CJZI00Fln74SaOemVdobN1URqp8L6y0iZS3o/r8hHx3KB4lSPifp6Y0wHdDiX84RHFw==
X-Received: by 2002:a05:600c:3d06:b0:420:11c1:b240 with SMTP id 5b1f17b1804b1-42011c1b30amr173197215e9.24.1716210330427;
        Mon, 20 May 2024 06:05:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:b718:2429:1dc5:dc6b:7d42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm422470085e9.2.2024.05.20.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 06:05:29 -0700 (PDT)
Date: Mon, 20 May 2024 09:05:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>,
	"virtio-dev@lists.linux.dev" <virtio-dev@lists.linux.dev>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	"stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 Resend] virtio-transport: Clarify requirements
Message-ID: <20240520090358-mutt-send-email-mst@kernel.org>
References: <3543c631e29d35a667ca9d9e912d1a6db1feb0ce.1716197180.git.viresh.kumar@linaro.org>
 <PH0PR12MB54815E4558E7577AC219F5F9DCE92@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240520082400-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B452C326D0FB614EB129DCE92@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B452C326D0FB614EB129DCE92@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 20, 2024 at 12:29:35PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, May 20, 2024 5:55 PM
> > 
> > On Mon, May 20, 2024 at 09:42:02AM +0000, Parav Pandit wrote:
> > > Michael,
> > >
> > > > From: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Sent: Monday, May 20, 2024 3:00 PM
> > > > To: virtio-comment@lists.linux.dev; virtio-dev@lists.linux.dev
> > >
> > > There is still cross posting to virtio-dev.
> > 
> > Well we say "do not do this" in the list subscription form.
> > Viresh, what gives?
> > 
> > > Is the list open to community now?
> > 
> > It's been open for a week. I think it's fair to say whoever wanted to subscribe,
> > has subscribed.
> > 
> True. I meant to ask that do contributors need to wait for patch [1] to be merged before posting patches here?
> You indicated there might be voting in [2], so trying to find what is next for contributors?
> 
> [1] https://lore.kernel.org/virtio-comment/te6tzbegqky7uz4skrag3yowet3phtq6nn7tegyrillgb4juwn@m4gi5ohfuk7m/T/#t
> [2] https://lore.kernel.org/virtio-comment/te6tzbegqky7uz4skrag3yowet3phtq6nn7tegyrillgb4juwn@m4gi5ohfuk7m/T/#m7b5d6fc76d05df528c36a70cff30afe06bb44917

I think we can assume existing contributors are aware of the process and
we do not need to vote. I spent a day on it but could not fix the voting
scripts yet.


> > > If not, can you please send out the guidance and timeline to open it on virtio-
> > comment list?
> > >
> > > This way contributors can avoid resending it multiple times.
> > >
> > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>; Vincent Guittot
> > > > <vincent.guittot@linaro.org>; Alex Bennée <alex.bennee@linaro.org>;
> > > > stratos- dev@op-lists.linaro.org; Manos Pitsidianakis
> > > > <manos.pitsidianakis@linaro.org>; Cornelia Huck <cohuck@redhat.com>;
> > > > Michael S. Tsirkin <mst@redhat.com>
> > > > Subject: [PATCH V3 Resend] virtio-transport: Clarify requirements
> > > >
> > > > The virtio documentation currently doesn't define any generic
> > > > requirements that are applicable to all transports. They can be
> > > > useful while adding support for a new transport.
> > > >
> > > > This commit tries to define the same.
> > > >
> > > > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > ---
> > > > V2->V3:
> > > > - Minor fixes.
> > > > - Added Reviewed by from Alex.
> > > >
> > > > V1->V2:
> > > > - Lot of changes after discussions with Alex and Cornelia.
> > > > - Almost a rewrite of the first commit.
> > > > - Add Transport normative sections.
> > > >
> > > >  commands.tex    |  3 +-
> > > >  conformance.tex | 14 +++++++++
> > > >  content.tex     | 78
> > > > +++++++++++++++++++++++++++++++++++++++++++++++--
> > > >  3 files changed, 92 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/commands.tex b/commands.tex index
> > > > 25ea8ee3bc78..b64b14424bd2 100644
> > > > --- a/commands.tex
> > > > +++ b/commands.tex
> > > > @@ -7,7 +7,8 @@
> > > >  % How we format a field name
> > > >  \newcommand{\field}[1]{\emph{#1}}
> > > >
> > > > -% Mark a normative section (driver or device)
> > > > +% Mark a normative section (driver or device, or transport)
> > > > +\newcommand{\transportnormative}[3]{#1{Transport Requirements:
> > > > +#2}\label{transportnormative:#3}}
> > > >  \newcommand{\drivernormative}[3]{#1{Driver Requirements:
> > > > #2}\label{drivernormative:#3}}
> > > > \newcommand{\devicenormative}[3]{#1{Device Requirements:
> > > > #2}\label{devicenormative:#3}}  \newcounter{clausecounter} diff
> > > > --git a/conformance.tex b/conformance.tex index
> > > > dc00e84e75ae..4a873169ce63
> > > > 100644
> > > > --- a/conformance.tex
> > > > +++ b/conformance.tex
> > > > @@ -11,6 +11,10 @@ \section{Conformance
> > > > Targets}\label{sec:Conformance / Conformance Targets}
> > > >
> > > >  Conformance targets:
> > > >  \begin{description}
> > > > +\item[Transport] A transport MUST conform to one conformance clauses:
> > > > +  \begin{itemize}
> > > > +    \item Clause \ref{sec:Conformance / Transport Conformance}.
> > > > +  \end{itemize}
> > > >  \item[Driver] A driver MUST conform to four conformance clauses:
> > > >    \begin{itemize}
> > > >      \item Clause \ref{sec:Conformance / Driver Conformance}.
> > > > @@ -66,6 +70,14 @@ \section{Conformance
> > > > Targets}\label{sec:Conformance / Conformance Targets}
> > > >    \end{itemize}
> > > >  \end{description}
> > > >
> > > > +\conformance{\section}{Transport Conformance}\label{sec:Conformance
> > > > +/ Transport Conformance}
> > > > +
> > > > +A transport MUST conform to the following normative statements:
> > > > +
> > > > +\begin{itemize}
> > > > +\item \ref{transportnormative:Virtio Transport Options / Virtio
> > > > +Transport Requirements} \end{itemize}
> > > > +
> > > >  \conformance{\section}{Driver Conformance}\label{sec:Conformance /
> > > > Driver Conformance}
> > > >
> > > >  A driver MUST conform to the following normative statements:
> > > > @@ -93,6 +105,7 @@ \section{Conformance
> > > > Targets}\label{sec:Conformance / Conformance Targets}  \item
> > > > \ref{drivernormative:Basic Facilities of a Virtio Device / Packed
> > > > Virtqueues / Supplying Buffers to The Device / Sending Available
> > > > Buffer Notifications}  \item \ref{drivernormative:General
> > > > Initialization And Device Operation / Device Initialization}  \item
> > > > \ref{drivernormative:General Initialization And Device Operation /
> > > > Device Cleanup}
> > > > +\item \ref{drivernormative:Virtio Transport Options / Virtio
> > > > +Transport Requirements}
> > > >  \item \ref{drivernormative:Reserved Feature Bits}  \end{itemize}
> > > >
> > > > @@ -172,6 +185,7 @@ \section{Conformance
> > > > Targets}\label{sec:Conformance / Conformance Targets}  \item
> > > > \ref{devicenormative:Basic Facilities of a Virtio Device / Packed
> > > > Virtqueues / The Virtqueue Descriptor Table}  \item
> > > > \ref{devicenormative:Basic Facilities of a Virtio Device / Packed
> > > > Virtqueues / Scatter-Gather Support}  \item
> > > > \ref{devicenormative:Basic Facilities of a Virtio Device / Shared
> > > > Memory Regions}
> > > > +\item \ref{devicenormative:Virtio Transport Options / Virtio
> > > > +Transport Requirements}
> > > >  \item \ref{devicenormative:Reserved Feature Bits}  \end{itemize}
> > > >
> > > > diff --git a/content.tex b/content.tex index
> > > > 0a62dce5f65f..a79993b5ed69 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -631,8 +631,82 @@ \section{Device Cleanup}\label{sec:General
> > > > Initialization And Device Operation /
> > > >
> > > >  \chapter{Virtio Transport Options}\label{sec:Virtio Transport
> > > > Options}
> > > >
> > > > -Virtio can use various different buses, thus the standard is split
> > > > -into virtio general and bus-specific sections.
> > > > +Devices and drivers can use different transport methods to enable
> > > > +interaction, for example PCI, MMIO, or Channel I/O. The transport
> > > > +methods define various aspects of the communication between the
> > > > +device and the driver, like device discovery, exchanging
> > > > +capabilities, interrupt handling, data transfer, etc. For example,
> > > > +in a host/guest architecture, the host might expose a device to the
> > > > +guest on a PCI bus, and the guest will use a PCI-specific driver to interact
> > with it.
> > > > +
> > > > +The standard is split into sections describing general virtio
> > > > +implementation and transport-specific sections.
> > > > +
> > > > +\section{Virtio Transport Requirements}\label{sec:Virtio Transport
> > > > +Options / Virtio Transport Requirements}
> > > > +
> > > > +\transportnormative{\subsection}{Virtio Transport
> > > > +Requirements}{Virtio Transport Options / Virtio Transport
> > > > +Requirements} The transport MUST provide a mechanism for the driver to
> > discover the device.
> > > > +
> > > > +The transport MUST provide a mechanism for the driver to identify
> > > > +the device type.
> > > > +
> > > > +The transport MUST provide a mechanism for communicating virtqueue
> > > > +configurations between the device and the driver.
> > > > +
> > > > +The transport MUST allow multiple virtqueues per device. The number
> > > > +of virtqueues for a pair of device-driver are governed by the
> > > > +individual device protocol.
> > > > +
> > > > +The transport MUST provide a mechanism that the device and the
> > > > +driver use to access memory for implementing virtqueues.
> > > > +
> > > > +The transport MUST provide a mechanism for the device to notify the
> > > > +driver and a mechanism for the driver to notify the device, for
> > > > +example regarding availability of a buffer on the virtqueue.
> > > > +
> > > > +The transport MAY provide a mechanism for the driver to initiate a
> > > > +reset of the virtqueues and device.
> > > > +
> > > > +The transport SHOULD provide a mechanism for the driver to read the
> > > > +device status. The transport MUST provide a mechanism for the
> > > > +driver to change the device status.
> > > > +
> > > > +The transport MUST provide a mechanism to implement config space
> > > > +between the device and the driver.
> > > > +
> > > > +\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio
> > > > +Transport Options / Virtio Transport Requirements}
> > > > +
> > > > +The device MUST keep any data associated with a device-initiated
> > > > +transaction accessible to the driver until the driver acknowledges
> > > > +the transaction to be complete.
> > > > +
> > > > +The device MUST NOT access the contents of a virtqueue before the
> > > > +driver notifies, in a transport defined way, the device that the
> > > > +virtqueue is ready to be accessed.
> > > > +
> > > > +The device MUST NOT access or modify buffers on a virtqueue after
> > > > +it has notified the driver about their availability.
> > > > +
> > > > +The device MUST reset the virtqueues if requested by the driver, in
> > > > +a transport defined way, if the transport provides such a method.
> > > > +
> > > > +\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio
> > > > +Transport Options / Virtio Transport Requirements}
> > > > +
> > > > +The driver MUST acknowledge device notifications, as mandated by
> > > > +the transport.
> > > > +
> > > > +The driver MUST NOT access virtqueue contents before the device
> > > > +notifies about the readiness of the same.
> > > > +
> > > > +The driver MUST NOT access buffers, after it has added them to the
> > > > +virtqueue and notified the device about their availability. The
> > > > +driver MAY access them after the device has processed them and
> > > > +notified the driver of their availability, in a transport defined way.
> > > > +
> > > > +The driver MAY ask the device to reset the virtqueues if, for
> > > > +example, the driver times out waiting for a notification from the
> > > > +device for a previously queued request.
> > > >
> > > >  \input{transport-pci.tex}
> > > >  \input{transport-mmio.tex}
> > > > --
> > > > 2.31.1.272.g89b43f80a514
> > > >
> > >

