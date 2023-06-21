Return-Path: <virtio-dev-return-13022-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1634BEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:06:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0E5632ACFD
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:06:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3E559866E3
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:06:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C22C0986830; Wed, 21 Jun 2023 20:06:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87E489865D0
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 20:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fs3ePMXfMs6fqducqdL6VA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377935; x=1689969935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4O+p/3ieuPn8GTHFXWYcrWzn54FKAnY6AKvFn43LZE=;
        b=X3gCSROoTcCy11xQpiu0sIqMFTeElDyCxdmBBhlXzs5V06lNhsg7aKf2qpOvXrQN1j
         f6Uw6fQD9efg9Nbtowil5P1plQOUN1YfovOf7gAMtLBWbxBykPk23qBNAOuCaFTQHrwC
         UFDKeMc5gN7dcqq6IaPoHyLIsDVdyJvrwp3OusTM6JKrUqiIHY1z6jFVYoF9f4LuIYID
         htBqSdVZj8uKXs7EZf3zgfy1J1ESCS9ULKUWAonlgBV0brkNdaWyE63DutexDCaIwQcU
         FUetVP/u6NLIqYFVVJM8yHq/dFWpknN2pqLvOjJrdRX8tYcHyMhc6cjwBVmIyHPaemvK
         hIOw==
X-Gm-Message-State: AC+VfDyX6fjo4j1EiYJwoVWMexTcUCIcIEHBZeXNdmj+LVCavXIE+r0g
	hSHA7h6WHU43+Rda0Zwl9FTBKZiuusSqdsvL7Ow1YE1EbIRe2Om13Lbrzu32szN13ovK7vNKOMB
	gKsSfea5IvAV6v/lFvu7WUGzqZsuA
X-Received: by 2002:a17:907:36c8:b0:982:7434:ea84 with SMTP id bj8-20020a17090736c800b009827434ea84mr20165270ejc.10.1687377934915;
        Wed, 21 Jun 2023 13:05:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bVB1FkFL2Gd6cMiXjA2ur6yN0q5H7zNbDOd7s7fZNboLKx7QDiAXvC4CH49vOeJQIswR4Ew==
X-Received: by 2002:a17:907:36c8:b0:982:7434:ea84 with SMTP id bj8-20020a17090736c800b009827434ea84mr20165253ejc.10.1687377934474;
        Wed, 21 Jun 2023 13:05:34 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:05:30 -0400
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
Message-ID: <20230621154832-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619112050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548149CD1C28AA21A203C13ADC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548149CD1C28AA21A203C13ADC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access

On Mon, Jun 19, 2023 at 09:07:56PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, June 19, 2023 12:17 PM
> 
> > I'd love to just put this stuff in a separate tex document and just link there from
> > the generic thing.
> > Or if it's too hard, please create new sections for this stuff. But in this case each
> > of these sections has to start with repeating the description when things apply.
> > E.g. "when using legacy interface"
> > when using commands "A B C to access" etc etc.
> > 
> > I wrote a bunch of comments below.
> >
> I will stick to them as most things are taken out to generic section anyway in patch 3.
> Only PCI transport part stays here.
> I will move some more text to generic section.
>  
> > > +As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]}
> > > +PCI VFs do not support the I/O space BAR. Due to this limitation, a
> > > +PCI VF hardware device that supports legacy interfaces cannot be
> > > +attached as passthrough device to the guest virtual machine.
> > 
> > That's not the only reason. Let's keep things generic and start by saying
> > something like "Some configurations with a need to support legacy drivers can
> > not implement a transitional device. For example .... ".
> >
> I will avoid For example part and move this to generic section.
>  
> > > +
> > > +To have a transitional or legacy virtio device in the guest virtual
> > > +machine, a PCI PF device as a group owner may
> > 
> > may -> can outside conformance statements.
> > 
> Ack.
> 
> > > support accessing its group member
> > 
> > Pls keep it generic. A group owner ....
> >
> Ack
>  
> > 
> > > +device's legacy configuration region using the group administration
> > > +commands listed at \ref{sec:Basic Facilities of a Virtio Device /
> > > +Device groups / Group administration commands / Legacy Interfaces: legacy
> > configuration access commands}.
> > > +These legacy configuration access commands are transported via the
> > > +administration virtqueue.
> > 
> > are these called legacy configuration access commands then?
> > why do you introduce this term? it does not look like it's used anywhere else.
> > 
> It is used and referred PCI section " Legacy Interfaces: Group member device Configuration Region Access".
> > 
> > I would prefer it if you just use the term "legacy interface"
> > it is well defined and widely used in the spec.
> > 
> It is "legacy interface", with suffix for group member config access.
> In future, there may be a section for other things than config access.
> 
> > again leave virtqueue out of it pls we'll have other ways down the road. what
> > matters is that they are transferred to a group member by sending legacy
> > configuration access commands to the group owner.
> >
> Ack.
> It is theory of operation, not a normative.
> Tomorrow if other than aq exists, one will write as "AQ or xyz"..
> 
> But fine to me to reduce changes from 216 to less lines. :)
>  
> > 
> > > This mechanism enables minimal involvement of the
> > > +hypervisor software only for the purpose of the legacy configuration region
> > access.
> > 
> > Leave marketing out of it pls, kill last sentence.
> >
> Huh, I don't see theory of operation and scope of the hypervisor as marketing at all.
> I will remove as it makes this patch shorter.
>  
> > 
> > 
> > > +
> > > +When a guest virtual machine requests legacy configuration and device
> > > +specific regions
> > 
> > wait so now it's legacy configuration and device specific regions and these two
> > are distinct?
> > 
> > > of group member device, a hypervisor software accesses
> > > +it using an administration virtqueue
> > 
> > please talk of administration commands. virtqueue does not matter at all.
> > 
> Ack.
> 
> > > on behalf of the guest virtual machine.
> > 
> > 
> > 
> > To put it in our terms, something like this:
> > 	when a legacy driver accesses a member device of
> > 	a group using the
> > 	legacy interface, a modern driver can intercept
> > 	the access and forward it to the owner device.
> > 
> I will not mention "modern driver" as it has zero reference in spec and don't want to bring Linux terms here.
> "the driver can intercept" is enough.

Good point but since you say "a legacy driver" then "the driver" seems
to refer to exactly that. How about:

 	when a legacy member device driver accesses a member device of
 	a group using the
 	legacy interface, an owner device driver can intercept
 	the access and forward it to the owner device.


> 
> > 
> > 
> > > +
> > > +Even though virtqueue driver notifications can be communicated
> > > +through administration virtqueue, if the group member device support
> > > +such
> > 
> > supports?
> >
> Ack.
>  
> > > +notifications using a memory-mapped operation, such driver
> > > +notifications are sent using a group member device defined notification
> > region.
> > 
> > what does "are sent" imply here? is there a matching conformance statement?
> > who sends them?
> > 
> It has the same meaning as "Driver notifications" section first line has.
> Isnt it implicit that driver notifications are sent by driver based on "Driver notifications" section?
> 
> > > +
> > > +The group owner device
> > 
> > this is the 1st you mention any group or its owner.
> > 
> > > should not expose PCI BAR0
> > 
> > Not PCI BAR0. That is in header. You mean VF BAR0.
> > 
> I will rewrite it as,
> 
> The group owner device should not expose PCI BAR0 in the PCI SR-IOV extended capability for the group member PCI VF devices when it prefers to
> support legacy interface for legacy configuration access using this group owner.


This seems to ignore all my comments.



> > > for the group member
> > > +devices when it prefers to support legacy interface for legacy
> > > +configuration access using its group owner.
> > 
> > don't use should outside conformance
> > 
> What should be used instead of "should"?

Depends on context, generally we just say what it does. E.g. "VF BAR0
is hardwired to zero".



> > 
> > I think this specific case actually should be more specific.
> > Something like:
> > 
> > - For PCI SRIOV groups, when group owner device implements commands
> >   A,B,C the group owner's VF BAR 0 is hardwired to 0
> >   in its PCI SRIOV capability.
> >
> I wrote it slightly differently above.

I don't see why what you wrote is any better than what you had to be
frank. You are coming up with our own terminology instead of just
using what's in the SR IOV spec. Please don't.

> > 
> > > +This facilitates hypervisor software to operate with least amount of
> > > +complexities
> > 
> > complexity is its own plural
> > 
> > > to emulate the legacy interface I/O space BAR and passthrough
> > > +other PCI BARs and PCI device capabilities to the guest virtual
> > > +machine without any translation.
> > > +
> > > +The group member device should not expose PCI BAR0 in various PCI
> > capabilities.
> > > +
> > > +\devicenormative{\subsubsection}{Legacy Interfaces Requirements:
> > > +Group Member Device Legacy Configuration Access}{Virtio Transport
> > > +Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group
> > > +Member Device Legacy Configuration Access}
> > > +
> > > +When a PCI SR-IOV group owner device supports
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group
> > owner
> > > +device SHOULD NOT expose PCI BAR0 in the SR-IOV Extended capability.
> > > +This is to facilitate the software to emulate I/O region BAR0 for supporting
> > the legacy interface.
> > 
> > not PCI BAR0 - VF BAR0. Check the PCI spec you can not "not expose it". if you
> > want to register can be "unimplemented".
> > Base Address registers are hardwired to zero
> > 
> > But it is better to be specific on what should happen. hardwire VF BAR0 to 0,
> > right?
> > 
> Hardwire to zero and not expose is same thing to me.

Maybe, though previously you said it just means not put any capabilities
there.  More importantly I don't see expose or not expose anywhere in
the PCI or SRIOV spec.  When spec wants to say how not to have a given
BAR it says exactly hardwired to zero.

> > 
> > > +
> > > +\drivernormative{\subsubsection}{Legacy Interfaces Requirements:
> > > +Group Member Device Legacy Configuration Access}{Virtio Transport
> > > +Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group
> > > +Member Device Legacy Configuration Access}
> > > +
> > > +The driver SHOULD NOT emulate I/O region BAR0 if a device group
> > > +member exposes a PCI BAR0.
> > 
> > what does "emulate" mean here? which driver it is?
> >
> I will add the line to theory of operation, but I recollect "emulate" line came from you.

I generally am fine with using this term but we need to then
define it before use.

This specific thing I would just drop.

Instead of wasting time just say device MUST hardwire VF BAR0 to zero as
opposed to SHOULD, and we do not need to worry about how drivers
recover. If they want to they will validate, if they don't then they
won't.


> > > diff --git a/transport-pci.tex b/transport-pci.tex index
> > > a5c6719..3647485 100644
> > > --- a/transport-pci.tex
> > > +++ b/transport-pci.tex
> > > @@ -541,6 +541,8 @@ \subsubsection{Notification structure
> > > layout}\label{sec:Virtio Transport Options  struct virtio_pci_notify_cap {
> > >          struct virtio_pci_cap cap;
> > >          le32 notify_off_multiplier; /* Multiplier for
> > > queue_notify_off. */
> > > +        u8 legacy_q_notify_supported;
> > 
> > I am still mulling whether VIRTIO_PCI_CAP_NOTIFY_CFG would be better.
> > 
> > 
> > > +	u8 reserved[3];
> > 
> > 
> > align with spaces pls.
> > 
> Ack.
> 
> > 
> > >  };
> > >  \end{lstlisting}
> > >
> > > @@ -560,6 +562,14 @@ \subsubsection{Notification structure
> > > layout}\label{sec:Virtio Transport Options  the same Queue Notify address for
> > all queues.
> > >  \end{note}
> > >
> > > +\field{legacy_q_notify_supported} when set to 1,
> > 
> > 
> > Do you mean something like:
> > When \field{legacy_q_notify_supported} this indicates that ...
> >
> Yes will fix.
>  
> > > indicates that the device
> > > +supports legacy queue notifications at this notification location.
> > 
> > And what location? this refers to what? the location described by this capability
> > maybe?
> > 
> Ack.
> 
> > 
> > More specifically, assume a transitional device (with an IO BAR as normal). Does
> > presence of this flag in the capability imply we can use a legacy queue but use
> > this notification with this capability?
> I don't know how this combination can be even possible by the device other than a buggy software who will do both.
> 
> > I worry that if we allow that, it opens floodgates of people who are too lazy to
> > upgrade to 1.0 but just hack this notification in there.
> >
> Don't understand the concern.
> If a device has transitional device, it is 1.0 device supporting legacy with IOBAR and newer interface.
> So...


if we are switching to admin commands for this, then let's not argue
about it.

> > 
> > 
> > 
> > 
> > > Legacy Queue
> > > +Notification address is derived within a BAR for a virtqueue:
> > > +
> > > +\begin{lstlisting}
> > > +        cap.offset
> > > +\end{lstlisting}
> > > +
> > >  \devicenormative{\paragraph}{Notification capability}{Virtio
> > > Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification
> > capability}  The device MUST present at least one notification capability.
> > >
> > 
> > I don't get what this is saying.  I *think* you really mean is that
> > queue_notify_off is 0.
> > 
> Please refer to the current notification address definition.
> Above is written in similar way where it doesnt need to describe queue_notify_off.
> > 
> > > @@ -596,6 +606,14 @@ \subsubsection{Notification structure
> > > layout}\label{sec:Virtio Transport Options  cap.length >=
> > > queue_notify_off * notify_off_multiplier + 4  \end{lstlisting}
> > >
> > > +\paragraph{Legacy Interfaces: Notification
> > > +capability}\label{par:Virtio Transport Options / Virtio Over PCI Bus
> > > +/ PCI Device Layout / Legacy Interfaces: Notification capability}
> > > +
> > > +The device SHOULD set \field{legacy_q_notify_supported}
> > 
> > why SHOULD and not MUST here - if driver checks for it then it won't work
> > without no?
> > 
> If device doesn't want to support queue notifications, it has ability to set to 0.
> 
> > > when the device
> > > +notification location supports legacy driver notifications.
> > 
> > legacy driver notifications is ambigous.
> > what you want here and elsewhere is something like "when used through a
> > legacy interface, device supports driver
> >
> Ack.
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

