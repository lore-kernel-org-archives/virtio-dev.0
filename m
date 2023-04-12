Return-Path: <virtio-dev-return-12178-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFC9C7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:03:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92A03419A9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:03:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BB389865B2
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:03:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 81D0398650E; Wed, 12 Apr 2023 05:03:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7196A986509
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 05:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 5TlKdWLzNqGsWAudCV42dA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681275776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RgyQScNj5DeCERmyiYZY8GJSw8uO6dFFaeCeu+QIGw=;
        b=LyeF/2qHrUCMHwMJA+ma6cz8qHlsBaMbDlxqaH8z6+fXmkZ0HsEK4MeSfQO+dnO6h3
         mRrlm4L9/tzdlMlgfNqYpPJijnVdbR8A2U1mTeggdIJuXx23LBxcZuJPpkuyKUn8p1pA
         PgDB2f4Dk66FuPxyxYVy6m38ei1vn8513uPnB1jRiUyrO04izCe4MaqItKjs3sz2Z13C
         3C/+f6DCD7utKaGzPgbBuOCunA6lR0Ry7u8tBl9/KHJLrEZFXY1fT4MXwsnl+/0F4keU
         a4DKgKKN169Oc04elnXqeEOdj3B/tfzaqU4Y83b6V8WcA3f60mR0tCaE3udi7pi5cvyt
         /5Gw==
X-Gm-Message-State: AAQBX9fwEUdWNKtT2wnm8KlmHR2PXwlkr96CxAMYSWFJ/2n4jYjRefww
	nGI0Kp2Mtb/zYWTfjs6iRPGd8DaPA34KHwhBxoNZDCrMaRHQDRD0Zx/S2IkudPj3dPp2PynNcBr
	vjN1fkQKDSqpUOjf2NVAvkVwvFSvD8QozL7tO
X-Received: by 2002:a7b:c406:0:b0:3ed:ca62:418e with SMTP id k6-20020a7bc406000000b003edca62418emr11571200wmi.9.1681275775893;
        Tue, 11 Apr 2023 22:02:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvNygYf/Otg1bFsEEuG5GbzcIhIS+C/XZsT/ZMv5X0NALsP3cvuyl9zMJSKI1l91KCOF/BZg==
X-Received: by 2002:a7b:c406:0:b0:3ed:ca62:418e with SMTP id k6-20020a7bc406000000b003edca62418emr11571192wmi.9.1681275775607;
        Tue, 11 Apr 2023 22:02:55 -0700 (PDT)
Date: Wed, 12 Apr 2023 01:02:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230412010224-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-11-parav@nvidia.com>
 <20230412003006-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481394D07C5CFBB2347B5F0DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412004152-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548170E8002F19709C6D55ADDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548170E8002F19709C6D55ADDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 10/11] transport-pci: Use driver notification PCI
 capability

On Wed, Apr 12, 2023 at 04:48:41AM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 12, 2023 12:43 AM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: virtio-dev@lists.oasis-open.org; cohuck@redhat.com; virtio-
> > comment@lists.oasis-open.org; Shahaf Shuler <shahafs@nvidia.com>;
> > Satananda Burla <sburla@marvell.com>
> > Subject: Re: [PATCH 10/11] transport-pci: Use driver notification PCI capability
> > 
> > On Wed, Apr 12, 2023 at 04:37:05AM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, April 12, 2023 12:31 AM
> > > >
> > > > On Fri, Mar 31, 2023 at 01:58:33AM +0300, Parav Pandit wrote:
> > > > > PCI devices support memory BAR regions for performant driver
> > > > > notifications using the notification capability.
> > > > > Enable transitional MMR devices to use it in simpler manner.
> > > > >
> > > > > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > ---
> > > > >  transport-pci.tex | 28 ++++++++++++++++++++++++++++
> > > > >  1 file changed, 28 insertions(+)
> > > > >
> > > > > diff --git a/transport-pci.tex b/transport-pci.tex index
> > > > > 55a6aa0..4fd9898 100644
> > > > > --- a/transport-pci.tex
> > > > > +++ b/transport-pci.tex
> > > > > @@ -763,6 +763,34 @@ \subsubsection{Notification structure
> > > > > layout}\label{sec:Virtio Transport Options  cap.length >=
> > > > > queue_notify_off * notify_off_multiplier + 4  \end{lstlisting}
> > > > >
> > > > > +\paragraph{Transitional MMR Interface: A note on Notification
> > > > > +Capability} \label{sec:Virtio Transport Options / Virtio Over PCI
> > > > > +Bus / Virtio Structure PCI Capabilities / Notification capability
> > > > > +/ Transitional MMR Interface}
> > > > > +
> > > > > +The transitional MMR device benefits from receiving driver
> > > > > +notifications at the Queue Notification address offered using the
> > > > > +notification capability, rather than via the memory mapped legacy
> > > > > +QueueNotify configuration register.
> > > > > +
> > > > > +Transitional MMR device uses same Queue Notification address
> > > > > +within a BAR for all virtqueues:
> > > > > +\begin{lstlisting}
> > > > > +cap.offset
> > > > > +\end{lstlisting}
> > > > > +
> > > > > +The transitional MMR device MUST support Queue Notification
> > > > > +address within a BAR for all virtqueues at:
> > > > > +\begin{lstlisting}
> > > > > +cap.offset
> > > > > +\end{lstlisting}
> > > > > +
> > > > > +The transitional MMR driver that wants to use driver
> > > > > +notifications offered using notification capability MUST use same
> > > > > +Queue Notification address within a BAR for all virtqueues at:
> > > > > +
> > > > > +\begin{lstlisting}
> > > > > +cap.offset
> > > > > +\end{lstlisting}
> > > > > +
> > > > Why? What exactly is going on here? legacy drivers will not do this.
> > >
> > > Legacy driver does in the q notify register that was sandwitched in between
> > of slow configuration registers.
> > > This is the notification offset for the hypervisor driver to perform the
> > notification on behalf of the guest driver so that the acceleration available for
> > the non-transitional device can be utilized here as well.
> > 
> > I don't get it. What acceleration? for guests you need a separate page so card
> > can be mapped directly while config causes an exit. But hypervisor can access
> > any register without vmexits.
> 
> Typically when guest VM writes to IOBAR q notification register, a vmexit occurs.
> On that occurrence, hypervisor driver forwards the q notification using the q notification region which is defined by struct virtio_pci_notify_cap.

What is wrong with forwarding it on the legacy window?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

