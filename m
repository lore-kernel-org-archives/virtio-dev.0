Return-Path: <virtio-dev-return-12522-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1A4C77B78
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFAEC11B682
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:20:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66AED9866CB
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:20:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E0F8B9865F0; Wed,  3 May 2023 19:20:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90A499865A1
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 May 2023 19:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wSQr3VH9PQKLcM3O1qea4A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141537; x=1685733537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1Y3yxDZcV/u1QAlX+ci/HGx1VQ6PRImQZbFIHfUUOE=;
        b=bznhJV6go9lRTcBDDK4x4N9qANnbb4syd/KXw01kpMyZAmn+8/D9bmm1dtb4tfcWGt
         K5ZG0UT0HVbfnx5gQ6oF9BiHsH5hh/7LNxMFAVx14+KhPKZJawefgqj1oZyOfQGKrIYB
         ZR7Xlxi8DtzZ2eGnEn4HSBO7+DD83QaeVx4ydLjt96P8lvQq3YmvBrYJUE7xQhvPm8Pi
         PRbGE6PnrNitk2TTn5tztBzr1/gMscLsApymWHPSRGScCk4vmOA4KgHFajLLep6b3RkC
         nuTwYPXi0c+tEeyu4HMG2mU2ozNsK1iBx1SavxlUYHHr8b5htsmtR9+tw9m/rdTU8GLO
         9stw==
X-Gm-Message-State: AC+VfDwclgdGcXI3ruvjjdw/Cybcq1IKKMlCYhMYcFS3h97Lg1Otulev
	AoYkve/KYrodL8nLMbC326BmjXOPMj5NQ3KcMcFAKXdNU1Fc+JZoLwwemrWOo0G46g/62lIzP1L
	4G0UdaJ4Yqzg3hC/1Uw/KWZuDIrlt
X-Received: by 2002:adf:fc06:0:b0:306:484e:e568 with SMTP id i6-20020adffc06000000b00306484ee568mr859168wrr.40.1683141537741;
        Wed, 03 May 2023 12:18:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NjTOwk5FweEJb3lH3YIU0/wEmjo6lQM6OelH1MRSlKVSN6VF5+3pXFhoc5bt7Ip1DFMXjKg==
X-Received: by 2002:adf:fc06:0:b0:306:484e:e568 with SMTP id i6-20020adffc06000000b00306484ee568mr859151wrr.40.1683141537388;
        Wed, 03 May 2023 12:18:57 -0700 (PDT)
Date: Wed, 3 May 2023 15:18:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230503151509-mutt-send-email-mst@kernel.org>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-3-parav@nvidia.com>
 <20230503014259-mutt-send-email-mst@kernel.org>
 <f9ecf8f5-1be7-179c-4d96-1c44d4601710@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <f9ecf8f5-1be7-179c-4d96-1c44d4601710@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v1 2/2] transport-pci: Add legacy
 register access conformance section

On Wed, May 03, 2023 at 10:53:56AM -0400, Parav Pandit wrote:
> 
> 
> On 5/3/2023 1:48 AM, Michael S. Tsirkin wrote:
> > On Wed, May 03, 2023 at 06:26:59AM +0300, Parav Pandit wrote:
> > > Add device and driver conformanace section for legacy registers access
> > > commands interface.
> > > 
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >   conformance.tex           |  2 ++
> > >   transport-pci-vf-regs.tex | 31 +++++++++++++++++++++++++++++++
> > >   2 files changed, 33 insertions(+)
> > > 
> > > diff --git a/conformance.tex b/conformance.tex
> > > index 01ccd69..dbd8cd6 100644
> > > --- a/conformance.tex
> > > +++ b/conformance.tex
> > > @@ -109,6 +109,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
> > >   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
> > >   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
> > > +\item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
> > >   \end{itemize}
> > >   \conformance{\subsection}{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
> > > @@ -194,6 +195,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
> > >   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
> > >   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
> > > +\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
> > >   \end{itemize}
> > >   \conformance{\subsection}{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
> > > diff --git a/transport-pci-vf-regs.tex b/transport-pci-vf-regs.tex
> > > index 16ced32..7d0574b 100644
> > > --- a/transport-pci-vf-regs.tex
> > > +++ b/transport-pci-vf-regs.tex
> > > @@ -82,3 +82,34 @@ \subsubsection{Legacy Queue Notify Offset Query}\label{sec:Virtio Transport Opti
> > >   	le64 offset; /* Byte offset within the BAR */
> > >   };
> > >   \end{lstlisting}
> > > +
> > > +\devicenormative{\paragraph}{SR-IOV VFs Legacy Registers Access}{Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
> > > +
> > > +If the PCI PF device supports legacy registers access, it SHOULD set
> > > +corresponding bits for commands VIRTIO_ADMIN_CMD_LREG_WRITE,
> > > +VIRTIO_ADMIN_CMD_LREG_READ and VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY in
> > > +command result of VIRTIO_ADMIN_CMD_LIST_QUERY in
> > > +\field{device_admin_cmd_opcodes}.
> > 
> > Don't repeat documentation of VIRTIO_ADMIN_CMD_LIST_QUERY please.
> yeah, I had dual thoughts, I am fine if this looks duplicate.
> Will remove.
> 
> > just say all these must be supported.
> > In fact what are you saying here? That all 3 are supported
> > or none at all? What about just
> > VIRTIO_ADMIN_CMD_LREG_READ/VIRTIO_ADMIN_CMD_LREG_WRITE?
> > Looks like a slower but working way to do notifications
> > is through a common config write, no?
> Notifications to be done using the notification region exposed and queried
> using the 3rd QUERY command.
> > 
> > > +
> > > +The device MUST support legacy configuration registers to its defined width.
> > 
> > what is this?
> > 
> Each register has its defined width as 8-bit, 16-bit, 32-bit etc.
> So device support the access to its defined width.
> May be to rewrite it differently?

Again you are duplicating the existing text, no?
And in this case, contradicting it?

	When using the legacy interface the driver MAY access
	the device-specific configuration region using any width accesses, and
	a transitional device MUST present driver with the same results as
	when accessed using the ``natural'' access method (i.e.
	32-bit accesses for 32-bit fields, etc).


> > > +
> > > +The device MAY fail legacy configuration registers access when either the
> > > +access is for an incorrct register width or if the register offset is incorrect.
> > 
> Spell checkers didnt capture the error of incorrct. Need to find better
> tool.
> 
> > with which error code?
> EINVAL
> but should we repeat the general section here?

this is a command specific case, isn't it?


> > 
> > > +
> > > +The device MUST allow access of one or multiple bytes of the registers when
> > > +such register is defined as byte array, for example \field{mac} of \field{struct
> > > +virtio_net_config} of the Network Device.
> > 
> > so which accesses need to be supported then?
> > 
> Not sure I follow the question.
> Can you please explain?

Consider mac, do you allow access to any length at all, from 1 to 6
bytes?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

