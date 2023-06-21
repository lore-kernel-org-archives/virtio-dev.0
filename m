Return-Path: <virtio-dev-return-13027-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A25EB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:31:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 85BC814E688
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:31:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 621309865D1
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:31:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 49D88983DDB; Wed, 21 Jun 2023 20:31:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35C739865CF
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 20:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 46U0jy88PgOesdpg0V9e0g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687379465; x=1689971465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1HtUgMZpWqDrm+TA6mtreqWM+c1GKwMTYE6R4FBFX8=;
        b=QOe9SBdaTBMA9kq6s0viJA86WE/Gzk6dhMKs4AdiJubg27dxoEK+SfU7y2w6uOzWid
         BeTF+PvD0Sj1zv1l3t9a5WehU0RnbfVji0aX5uh6RgSwP/OOCVmkD26NoyoXSFePPkO2
         ilkwMPo9w9v9OyvfqCQpZk/AIqa0AkRhbGrwx+e22epkgRuEXPBLSK7beqjJh/Z8OooG
         fgKze2CXXBIZKqxjgIcI7xi5HCGVFzlqaCYBW9UqE0kvclWwJWyooCftacOdrPV5GOMS
         NwI4IYjPcagplikaqwqDfTjYGFzjVrt4R9DT+6H6jH5TmPHYbNhacL3pLPsSSIpZ82SU
         gQJw==
X-Gm-Message-State: AC+VfDwdVPsvK6tAQCQgmR8pjHCpWitvIc50Q9PqejIJ0NN7MJT75wX4
	fRl5U8DgNrMhCEcAK2QOyDCLdBmrwf1VaXm52gA2Dao1xvaSFwQvwo4svJkv4Tni3LjlYR+TENq
	SfqTKa2onOr/8HW/MQTeDjBDL9ASI
X-Received: by 2002:aa7:ca4a:0:b0:51a:5b39:5cfc with SMTP id j10-20020aa7ca4a000000b0051a5b395cfcmr6295638edt.18.1687379465470;
        Wed, 21 Jun 2023 13:31:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yjDusbc5rgV9nf0sN9ONAVvOaKJUSJYFcEe+RRlVAnefbiBayIPpt5uQMf1p2xSxsdKdesQ==
X-Received: by 2002:aa7:ca4a:0:b0:51a:5b39:5cfc with SMTP id j10-20020aa7ca4a000000b0051a5b395cfcmr6295626edt.18.1687379465132;
        Wed, 21 Jun 2023 13:31:05 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:31:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230621162636-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619112050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548149CD1C28AA21A203C13ADC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621154832-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815544B2D409AC9BBDAAC6DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815544B2D409AC9BBDAAC6DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access

On Wed, Jun 21, 2023 at 08:22:58PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 21, 2023 4:06 PM
> 
> [..]
> > > > To put it in our terms, something like this:
> > > > 	when a legacy driver accesses a member device of
> > > > 	a group using the
> > > > 	legacy interface, a modern driver can intercept
> > > > 	the access and forward it to the owner device.
> > > >
> > > I will not mention "modern driver" as it has zero reference in spec and don't
> > want to bring Linux terms here.
> > > "the driver can intercept" is enough.

Maybe a (non legacy) driver can intercept? Would that be acceptable?
Just to clarify the confusion above.


> > 
> > Good point but since you say "a legacy driver" then "the driver" seems to refer
> > to exactly that. How about:
> > 
> >  	when a legacy member device driver accesses a member device of
> >  	a group using the
> >  	legacy interface, an owner device driver can intercept
> >  	the access and forward it to the owner device.
> > 
> Above is not correct.
> 
> We have 3 drivers in picture.
> 1. guest driver

this is legacy driver, so easy

> 2. hypervisor level member device driver

this is just for notifications, optionally, yes?


> 3. group owner device driver
> 
> Trying to write without introducing guest and hypervisor term,
> 
> A group owner device driver provides the service to access member device's configuration region. 
> A member device driver avail this service when it wants to access the member device's configuration region.


I agree, it's getting complicated.

> 
> > > I will rewrite it as,
> > >
> > > The group owner device should not expose PCI BAR0 in the PCI SR-IOV
> > > extended capability for the group member PCI VF devices when it prefers to
> > support legacy interface for legacy configuration access using this group owner.
> >
> > 
> > This seems to ignore all my comments.
> >
> I replied after that, probably missed in exchanges.
> 
> How about:
> The group owner device MUST hardwire PCI BAR0 in the PCI SR-IOV extended capability for the group member PCI VF devices when it supports legacy configuration access commands.
>

better but it's not a PCI BAR0. let's add link to sriov spec,
and name it VF BAR0 same as in that spec.


> > 
> > 
> > > > > for the group member
> > > > > +devices when it prefers to support legacy interface for legacy
> > > > > +configuration access using its group owner.
> > > >
> > > > don't use should outside conformance
> > > >
> > > What should be used instead of "should"?
> > 
> > Depends on context, generally we just say what it does. E.g. "VF BAR0 is
> > hardwired to zero".
> > 
> Ok.
> 
> > 
> > 
> > > >
> > > > I think this specific case actually should be more specific.
> > > > Something like:
> > > >
> > > > - For PCI SRIOV groups, when group owner device implements commands
> > > >   A,B,C the group owner's VF BAR 0 is hardwired to 0
> > > >   in its PCI SRIOV capability.
> > > >
> > > I wrote it slightly differently above.
> > 
> > I don't see why what you wrote is any better than what you had to be frank. You
> > are coming up with our own terminology instead of just using what's in the SR
> > IOV spec. Please don't.
> > 
> > > >
> > > > > +This facilitates hypervisor software to operate with least amount
> > > > > +of complexities
> > > >
> > > > complexity is its own plural
> > > >
> > > > > to emulate the legacy interface I/O space BAR and passthrough
> > > > > +other PCI BARs and PCI device capabilities to the guest virtual
> > > > > +machine without any translation.
> > > > > +
> > > > > +The group member device should not expose PCI BAR0 in various PCI
> > > > capabilities.
> > > > > +
> > > > > +\devicenormative{\subsubsection}{Legacy Interfaces Requirements:
> > > > > +Group Member Device Legacy Configuration Access}{Virtio Transport
> > > > > +Options / Virtio Over PCI Bus / Legacy Interfaces Requirements:
> > > > > +Group Member Device Legacy Configuration Access}
> > > > > +
> > > > > +When a PCI SR-IOV group owner device supports
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group
> > > > owner
> > > > > +device SHOULD NOT expose PCI BAR0 in the SR-IOV Extended capability.
> > > > > +This is to facilitate the software to emulate I/O region BAR0 for
> > > > > +supporting
> > > > the legacy interface.
> > > >
> > > > not PCI BAR0 - VF BAR0. Check the PCI spec you can not "not expose
> > > > it". if you want to register can be "unimplemented".
> > > > Base Address registers are hardwired to zero
> > > >
> > > > But it is better to be specific on what should happen. hardwire VF
> > > > BAR0 to 0, right?
> > > >
> > > Hardwire to zero and not expose is same thing to me.
> > 
> > Maybe, though previously you said it just means not put any capabilities there.
> > More importantly I don't see expose or not expose anywhere in the PCI or
> > SRIOV spec.  When spec wants to say how not to have a given BAR it says exactly
> > hardwired to zero.
> > 
> Hardwired to zero is fine, done above now.
> 
> > > >
> > > > > +
> > > > > +\drivernormative{\subsubsection}{Legacy Interfaces Requirements:
> > > > > +Group Member Device Legacy Configuration Access}{Virtio Transport
> > > > > +Options / Virtio Over PCI Bus / Legacy Interfaces Requirements:
> > > > > +Group Member Device Legacy Configuration Access}
> > > > > +
> > > > > +The driver SHOULD NOT emulate I/O region BAR0 if a device group
> > > > > +member exposes a PCI BAR0.
> > > >
> > > > what does "emulate" mean here? which driver it is?
> > > >
> > > I will add the line to theory of operation, but I recollect "emulate" line came
> > from you.
> > 
> > I generally am fine with using this term but we need to then define it before
> > use.
> > 
> > This specific thing I would just drop.
> > 
> > Instead of wasting time just say device MUST hardwire VF BAR0 to zero as
> > opposed to SHOULD, and we do not need to worry about how drivers recover. If
> > they want to they will validate, if they don't then they won't.
> >
> This limitation seems fine to me.
> Will drop.
>  
> > 
> > > > > diff --git a/transport-pci.tex b/transport-pci.tex index
> > > > > a5c6719..3647485 100644
> > > > > --- a/transport-pci.tex
> > > > > +++ b/transport-pci.tex
> > > > > @@ -541,6 +541,8 @@ \subsubsection{Notification structure
> > > > > layout}\label{sec:Virtio Transport Options  struct virtio_pci_notify_cap {
> > > > >          struct virtio_pci_cap cap;
> > > > >          le32 notify_off_multiplier; /* Multiplier for
> > > > > queue_notify_off. */
> > > > > +        u8 legacy_q_notify_supported;
> > > >
> > > > I am still mulling whether VIRTIO_PCI_CAP_NOTIFY_CFG would be better.
> > > >
> > > >
> > > > > +	u8 reserved[3];
> > > >
> > > >
> > > > align with spaces pls.
> > > >
> > > Ack.
> > >
> > > >
> > > > >  };
> > > > >  \end{lstlisting}
> > > > >
> > > > > @@ -560,6 +562,14 @@ \subsubsection{Notification structure
> > > > > layout}\label{sec:Virtio Transport Options  the same Queue Notify
> > > > > address for
> > > > all queues.
> > > > >  \end{note}
> > > > >
> > > > > +\field{legacy_q_notify_supported} when set to 1,
> > > >
> > > >
> > > > Do you mean something like:
> > > > When \field{legacy_q_notify_supported} this indicates that ...
> > > >
> > > Yes will fix.
> > >
> > > > > indicates that the device
> > > > > +supports legacy queue notifications at this notification location.
> > > >
> > > > And what location? this refers to what? the location described by
> > > > this capability maybe?
> > > >
> > > Ack.
> > >
> > > >
> > > > More specifically, assume a transitional device (with an IO BAR as
> > > > normal). Does presence of this flag in the capability imply we can
> > > > use a legacy queue but use this notification with this capability?
> > > I don't know how this combination can be even possible by the device other
> > than a buggy software who will do both.
> > >
> > > > I worry that if we allow that, it opens floodgates of people who are
> > > > too lazy to upgrade to 1.0 but just hack this notification in there.
> > > >
> > > Don't understand the concern.
> > > If a device has transitional device, it is 1.0 device supporting legacy with
> > IOBAR and newer interface.
> > > So...
> > 
> > 
> > if we are switching to admin commands for this, then let's not argue about it.
> > 
> Ok.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

