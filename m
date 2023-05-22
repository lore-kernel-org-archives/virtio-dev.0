Return-Path: <virtio-dev-return-12781-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13196C77B73
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 21:35:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71180EEA26
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 21:35:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2317986746
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 21:35:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6910F9863C0; Mon, 22 May 2023 21:35:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 849009863BA
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 May 2023 21:34:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tl3nwwWmMMuDHKmgG5UzcA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684791293; x=1687383293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee255M/HK/Rs53vYWBX4gOTQWuDypPLJvXpH6aQPc14=;
        b=kGi8bTPJKuX/XGIRTgVYdchSryZ2t+E9tXefqmE1tKUTmyFKKEfas/nuTFjvcdtsdg
         E1MIgY+6W6elxEZvlg4s6L4yw6ooQAeYQXS6KA8LbEuEFAYwQZCwNghmmmnMtgQ/7qO/
         IJ1zXGJ8A6nq2gI72YvDrQ3yz9qDTc1Pedil95/wdR2lD9Ey62Sqb8SnZVupE0ROZW0Q
         Ce8VjUoBVVE/RwPPPwaTlCGR9eryxUZa1758zGaa11VjygUPYuUVnqsUtDgPc4yXW1Yg
         YMDvPDXg1BeShupPTSzzQsyJVtTu0TE627K6oAql9gaozPgLxi5tptR07gt+KZNfsqd0
         GOYQ==
X-Gm-Message-State: AC+VfDzyAy6XIynVKmf2pU9Og7NC1QXLXHSfZ7aXYwXjCrz7kDDzWrCK
	3msFaEFAjxOADAGPxMV9S3kZwcAXzD2S/pf2QiD/HoeWyKiOqiVEHdA99Uw0jI3ArS0Y0hairZv
	TzcN2sS2PltrEEQBh1IBRMwPidFfi
X-Received: by 2002:a5d:428a:0:b0:309:471c:9916 with SMTP id k10-20020a5d428a000000b00309471c9916mr8433601wrq.0.1684791293528;
        Mon, 22 May 2023 14:34:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SLTo6uJdsDUoVs1NHcxoESj6gE8sSzRlG78pQ3Nm8W0a5h9gd+JApzAeMiExNWcgsPbLNqA==
X-Received: by 2002:a5d:428a:0:b0:309:471c:9916 with SMTP id k10-20020a5d428a000000b00309471c9916mr8433579wrq.0.1684791293135;
        Mon, 22 May 2023 14:34:53 -0700 (PDT)
Date: Mon, 22 May 2023 17:34:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230522170700-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Mon, May 22, 2023 at 09:05:13PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, May 22, 2023 4:07 PM
> > 
> > On Sun, May 21, 2023 at 02:44:03PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Sunday, May 21, 2023 10:33 AM
> > >
> > > > > Yet you initiate same discussion point that we already discussed
> > > > > again after
> > > > summarizing.
> > > > > A driver is not attached to two devices.
> > > > > A driver is attached to a single device.
> > > >
> > > > And that device is the owner no? to send commands?
> > > >
> > > Not for legacy registers access as discussed before.
> > 
> > Now I am lost. legacy register access is on top of aq which sends commands
> > through pf.  
> 
> > how are you going to send commands without attaching a driver, I
> > don't know.
> 
> A VF driver can send command to its parent PF driver using well defined kernel API.
> There is no need to attach PF driver.
> Upper and lower devices are common concept.
> > > Not limited to QEMU.
> > > A driver will be able to do this as well.
> > 
> > No, on some OS-es (windows, iokit, more) a single driver can't bind to many
> > devices without a lot of pain.  
> There is no need to bind. A well-defined kernel API is enough.
> 
> It's been while I worked on iokit, but iokit has similar kernel APIs.
> 
> It is very exciting to think that one has built iokit based hypervisor and hosting PCI accelerated device and VMs in it.
> Last time when I checked, I was told that virtio driver is not present in the latest OS, not sure how true it is.

iokit is from my previous work experience not virtio.
For virtio we had a lot of trouble with hacks like this on windows.
That's an important platform.

> > If you are mapping VF BAR, this has to be done by
> > VF driver, and please just avoid pain for everyone by exposing the necessary
> > info through the VF itself.
> > A capability seems perfect for this.
> > 
> Why not the MMIO region as proposed in v0?

Are you asking what were issues with v0? The issue with v0 was not MMIO
as such at least for me.  The issue was that it was not giving us any
way to work around bugs in the legacy interface. AQ was a fix for that.


> Capability based read/write requires extra redirection, it is less optimal than MMIO.
> 
> > An alternative is not to map VF BAR at all, steal space from PF BAR instead.
> Come an iokit will be able to access this PF BAR without binding to it?

I don't get what you are saying here.  You have to bind a PF driver.
Otherwise you can not send AQ command. That driver can map PF BAR into
applications.


> > Guest is not accessing this anyway. So I really do not see why not from software
> > point of view. There's a hardware reason? Could you talk to hardware guys
> > about this? You objected to AQ too then hardware guys told you it is not a big
> > deal.
> I didn't object to AQ on hw reason.
> I explained AQ is not the best compared to MMIO because it is slow compared to MMIO by law of physics as it needs to move more bits than MMIO.
> And so, the capability based tunneling too is slow to MMIO.
> > 
> > > > So we have legacy emulation send commands to VF or to PF.  Okay. But
> > > > let us avoid the need for VF driver to send commands to PF to initialize.
> > > > Just get all information it needs from VF itself.
> > > >
> > > >
> > > > Maybe it's a good idea to reuse existing notification capability, or
> > > > maybe a new one, but let's avoid making VF driver depend on PF
> > commands.
> > > >
> > > We agreed in v1 on Jason's suggestion to have the AQ command and yet
> > > you and Jason hinder this in v2 with this exact repeated question.
> > > Lets please avoid this and move forward.
> > 
> > How was I supposed to raise this issue on v1 if it was not there?
> > Stop arguing in circles and things will move forward.
> v1 version clearly had AQ commands.
> 
> Please revisit your comments.
> v0 -> you suggested:
>  - "why not AQ, like transport vq, it can coalesce partial mac writes".
> 
> v1-> over AQ, you suggested:
>  - to "drop the size"
> - summarized to split 2 commands to 4 commands to split device and config area.
> 
> After that summary, you propose, why not self-contained in VF itself? -> circle back to v0 method.
> (Instead of mmio, suggesting capability, but not explaining why mmio is not fine. Which is better than cap).
> 
> Then now you propose "have BAR in the PF which is owned by other PF driver", with least reasoning.
> And it convolutes with your suggestion of PF driver access...
> 
> So, I am bit lost on your circular proposal, or it was just a probe question...
> Not sure.

You did move things to AQ however not completely.  You kept notification
in MMIO. If everything was in AQ we would be done as far as I am
concerned (though Jason still does not like duplication of functionality
with transport vq, but that is a separate issue).

As notification is in VF MMIO I am trying to help you by suggesting
other ways to keep things consistent. If it's in VF I think it follows
that where it is has to be in VF as well. Not in AQ.

And look if that just serves to annoy I can just point out issues and
complain without suggestions. Was trying to be helpful here really.


> 
> > 
> > If we have trouble converging on the notification thing, how about we make
> > progress without it for now?  Merge a slow version that sends kicks through aq,
> > then work on the best way to make notifications faster, separately.
> > 
> Sure, we can differ, but the VF has the notification BAR to utilize.
> So why not use it?

Are you asking why is merging a smaller partial patch then adding
functionality a good idea?


> > 
> > > > > We have already these design choices and tradeoff in v0 and v1, it
> > > > > doesn't fit
> > > > the requirements.
> > > >
> > >
> > > > So, I am saying one model is small driver for VF and a big one for PF.
> > > > And to keep the VF driver simple, it should get information simply
> > > > from config space capability.
> > >
> > > VF driver is small that does usual vfio passthrough work.
> > > PF driver implement AQ for variety of use cases that we listed in the AQ
> > cover letter.
> > > VF driver implements 5 AQ commands that you suggested to split from 2 to 4.
> > 
> > VF(member) driver can't implement AQ commands at all. They are sent to
> > PF(owner) thus by PF(owner) driver.  In virt configs, VMM can trap legacy access
> > and talk to owner driver to send them.  It can also talk to member driver to
> > send notifications.  You can I guess have VMM get member BAR offsets from
> > owner and pass them to member for mapping. This raises all kind of questions
> > of trust.
> Only the member driver has access to the owner driver via kernel API.

Assuming you can predict existance of specific kernel APIs on all OSes
is IMO a fool's errand. One of the things virtio is supposed to be about
is precisely simple straight forward design for drivers.  Which this is
not.

> Part of the VF BAR information at the PCI level is also on the PF.
> There is no trust break here. A kernel exposes single self-contained object to user space VMM.

That is ok.  The trust break is if PF driver is in userspace. You then
are trusting userspace to pass offsets back to kernel VF driver.



> > If you can map BAR from PF that would be simplest, VMM then only pokes at PF
> > and not VF. If not then we really should expose this info n the VF if at all
> > possible.
> > 
> There is clearly no need to use PF for notification when the notification method already exists on the VF.

All this looks backwards with mixed up functionality.  What VF has is
modern BAR. If you insist on reusing modern functionality for legacy
when it suits you then maybe we should reuse it for everything, that
would be extending transport vq to support legacy somehow.





> In fact, it is yet extra steering entry for the hw to perform such mapping.
> 
> To iterate what presented yday in [1] to Jason.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00298.html
> 
> 1. legacy register access via AQ (v1)
> Pros:
> a. Light weight for hypervisor and devices (mainly PCI) to implement.
> b. Enables sw to coalesce some device specific registers, if needed.
> Cons:
> a. Not self-contained, requires PF's AQ which is anyway designed for such purpose.
> 
> 2. Legacy registers access via new MMIO region (v0 + sane reset)

I think I would buy this one if it was actually in BAR0 exactly legacy
with no changes, no reset no nothing. a hack like Jason described that
at least makes legacy linux drivers work with no software glue.  That is
horrible, fragile but engineering history is full of hacks like this.
If you need software in the middle then let's please make it robust.


> Pros:
> a. smaller code in slow register access than AQ
> b. Sw cannot coalesce some device specific registers.
> c. Self-contained in the VF
> 
> Cons:
> a. Relatively burdensome for the device as it requires more RW registers at scale, but it can be indirect register.

what I keep saying

b. a ton of legacy bugs which hypervisor can't detect or work around
   (reset is just one issue)


> 3. legacy registers tunneling with additional indirection via PCI capability


I don't know what's this one.


> Cons:
> a. transport specific (but not big concern to me)
> b. Twice the slow as it requires RW cap.
> c. Inferior to #2, still requires sane reset as #2
> d. MMIO indirect registers are better than capabilities because PCI caps are largely for read only purpose.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

