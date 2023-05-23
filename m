Return-Path: <virtio-dev-return-12794-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A700DC7EE2D
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 18:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 16CC2673BE
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 18:50:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72B1698674B
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 18:50:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CE97B9863E8; Tue, 23 May 2023 18:50:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DEE1B9863D0
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 May 2023 18:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: W-0wSEY3MKmZdyJAggSL-w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684867733; x=1687459733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q1FahXhtXa+RSnz1S9asfV6TdCOnnU2VwTFyxaUvS8=;
        b=TH5zjtDN0eYDC/CwqhH5H8yRz1GoAv88kDIWzEB/SJX5tFTKSzPcwszaytTunU+uq5
         BAMXt8PaNR1swadegnEexETNbZNgRRWwteRjU7t4X8VIKxSDtMlFZhk1M8+T6l5XoCmG
         A47lLZ0W4J+NKS8VYW882yfp1DW2FyfwD3vwETYY1FEpUxurvNI8bNvrRPQ87vHgvk6r
         lB5+fWh+TtZjpgAmqvSrcS7biDKsCs7TWjHCHVmyZ6u4gUHlB3Rgaa1iAZvLnTrUnGzf
         qErxJp9RjUliJM7oYFn+xtbKWKmrtTF/4HdiTbVUqhOjXGrJbR317/I4R/BzfRp7voyf
         qsVg==
X-Gm-Message-State: AC+VfDxGNAfmP8xmzp68wuOyVCwkj6yQAGrVGQtTgljShcCO4p3Tg5Ga
	rmdkEG2wGtwuKX1D6kylyihBHG6mDtJwdXHkGCeeA3YWnrZ6Ms1UdZlcV63bOKV/sDGX4ttyuZ/
	7HrATn7YznD/Sa/Y6i/2E4CYqh5sV
X-Received: by 2002:a05:600c:ad2:b0:3f6:d2:d8c0 with SMTP id c18-20020a05600c0ad200b003f600d2d8c0mr7686690wmr.19.1684867733305;
        Tue, 23 May 2023 11:48:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eCVOiRvSvxiNtXXyh0/Xw4jLDKqfOOfxDHwt6YSD48ji2/nYkOj1mjzryqahnozv1whwCTQ==
X-Received: by 2002:a05:600c:ad2:b0:3f6:d2:d8c0 with SMTP id c18-20020a05600c0ad200b003f600d2d8c0mr7686675wmr.19.1684867732854;
        Tue, 23 May 2023 11:48:52 -0700 (PDT)
Date: Tue, 23 May 2023 14:48:48 -0400
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
Message-ID: <20230523141718-mutt-send-email-mst@kernel.org>
References: <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522170700-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Tue, May 23, 2023 at 05:13:54PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, May 22, 2023 5:35 PM
> 
> > 
> > iokit is from my previous work experience not virtio.
> > For virtio we had a lot of trouble with hacks like this on windows.
> I don't know why windows driver need to talk to PF driver until now when the AQ doesn't exists.

What is it you want to know?

> > That's an important platform.
> > 
> I am not sure how important is it.
> What I learnt that a decade has passed and even after that virtio drivers are not part of the OS distro.

Because with QEMU they are so easy to side-load. So we never bothered.

> > > > If you are mapping VF BAR, this has to be done by VF driver, and
> > > > please just avoid pain for everyone by exposing the necessary info
> > > > through the VF itself.
> > > > A capability seems perfect for this.
> > > >
> > > Why not the MMIO region as proposed in v0?
> > 
> > Are you asking what were issues with v0? The issue with v0 was not MMIO as
> > such at least for me.  The issue was that it was not giving us any way to work
> > around bugs in the legacy interface. AQ was a fix for that.
> > 
> It doesn't need to because guest is anyway going to do whatever it does. 

yes. But hypervisor can do work-arounds or detect broken functionality
and stop cleanly.

> The clear requirement is: to not fix legacy but to support legacy.
> Fixing legacy is role of 1.x. Not the role of legacy interface itself using AQ/MMIO.
> 
> And even if one desire to coalesce MMIO writes, it can still do it for mac address.
> We discussed this.
> We also discussed that kernel as old as 2.6.32 uses CVQ for mac address.
> 
> And Even device can apply mac address when it reaches the count of byte writes to 6, if wishes to.
> > 
> > > Capability based read/write requires extra redirection, it is less optimal than
> > MMIO.
> > >
> > > > An alternative is not to map VF BAR at all, steal space from PF BAR instead.
> > > Come an iokit will be able to access this PF BAR without binding to it?
> > 
> > I don't get what you are saying here.  You have to bind a PF driver.
> > Otherwise you can not send AQ command. That driver can map PF BAR into
> > applications.
> > 
> This is usual model that we follow. When PF driver is serving and emulating it provides the shared platform for other devices for legacy functionality.
> It is for legacy not for any other newer interface.
> 
> And for purpose of BAR mapping, such BAR in the VF can be mapped too.
> You didn't answer why VF BAR is a problem and suggest PF BAR.

VF BAR by itself is not a problem. Discovering VF BAR mapping offset
through PF is.


> Such VF BAR already exists and asking for new resource creation doesn't fit in your "simple" scheme suggestion either.
> 
> > 
> > > > Guest is not accessing this anyway. So I really do not see why not
> > > > from software point of view. There's a hardware reason? Could you
> > > > talk to hardware guys about this? You objected to AQ too then
> > > > hardware guys told you it is not a big deal.
> > > I didn't object to AQ on hw reason.
> > > I explained AQ is not the best compared to MMIO because it is slow
> > compared to MMIO by law of physics as it needs to move more bits than
> > MMIO.
> > > And so, the capability based tunneling too is slow to MMIO.
> > > >
> > > > > > So we have legacy emulation send commands to VF or to PF.  Okay.
> > > > > > But let us avoid the need for VF driver to send commands to PF to
> > initialize.
> > > > > > Just get all information it needs from VF itself.
> > > > > >
> > > > > >
> > > > > > Maybe it's a good idea to reuse existing notification
> > > > > > capability, or maybe a new one, but let's avoid making VF driver
> > > > > > depend on PF
> > > > commands.
> > > > > >
> > > > > We agreed in v1 on Jason's suggestion to have the AQ command and
> > > > > yet you and Jason hinder this in v2 with this exact repeated question.
> > > > > Lets please avoid this and move forward.
> > > >
> > > > How was I supposed to raise this issue on v1 if it was not there?
> > > > Stop arguing in circles and things will move forward.
> > > v1 version clearly had AQ commands.
> > >
> > > Please revisit your comments.
> > > v0 -> you suggested:
> > >  - "why not AQ, like transport vq, it can coalesce partial mac writes".
> > >
> > > v1-> over AQ, you suggested:
> > >  - to "drop the size"
> > > - summarized to split 2 commands to 4 commands to split device and config
> > area.
> > >
> > > After that summary, you propose, why not self-contained in VF itself? -> circle
> > back to v0 method.
> > > (Instead of mmio, suggesting capability, but not explaining why mmio is not
> > fine. Which is better than cap).
> > >
> > > Then now you propose "have BAR in the PF which is owned by other PF
> > driver", with least reasoning.
> > > And it convolutes with your suggestion of PF driver access...
> > >
> > > So, I am bit lost on your circular proposal, or it was just a probe question...
> > > Not sure.
> > 
> > You did move things to AQ however not completely.  You kept notification in
> > MMIO. If everything was in AQ we would be done as far as I am concerned
> > (though Jason still does not like duplication of functionality with transport vq,
> > but that is a separate issue).
> > 
> It is a wrong design point to ask to "move everything to AQ", because AQ cannot be the data link layer for everything.
> One can ask in the, why don't I put my 1GB of data inside the AQ itself? AQ should do everything...
> Why not device build MB of shared memory for MMIO, queue data ... one shared memory should do everything.
> 
> And list like that can continue with no end.
> 
> We have seen the perf numbers with iobar and memory bar both for PCI devices in lab.
> For the PCI transport, perf wise, memory bar for notification, second is iobar, 3rd is AQ.
> They are order of magnitude apart for latency.
> So AQ to send DB is only looks good in the PDF like how INTX looks good in PDF with SR-IOV but doesn't work well on perf wise.
>
> > As notification is in VF MMIO I am trying to help you by suggesting other ways
> > to keep things consistent. If it's in VF I think it follows that where it is has to be
> > in VF as well. Not in AQ.
> Huh.
> If notification for VF is in VF -> hence other config registers also in VF, such blanket statements does not help.

not other config registers. what's needed in VF driver should be
retrievable through VF.


> I explained in past that notifications are latency sensitive, and they are best served using MMIO.
> 
> Can one implement legacy registers as MMIO as proposed in v0?
> Yes, comes at high cost to build such hw.
> Is there a better optimal option for legacy?
> Yes, i.e. use AQ which is what we wrote in cover letter of AQ.
> 
> b. Use MMIO registers pair on the VF itself for example,
> legacy_register_addr = offset + size + operation + completion
> legacy_register_data = register content
> 
> an example sequence is:
> hv sw writes 
> legacy_register_addr = offset=0x2, size=0x4, operation=read,
> Poll for 
> legacy_register_addr = offset=0x2, size=0x4, operation=read, cmpl=1
> Read the register data from legacy_register_data.
> 
> This way a small register footprint on device. Self-contained. Works for the device reset too.
> Less memory footprint on the device too.
> 
> Does this solve the legacy interface problem? No. Because that is not the objective.
> 
> Is this small enough to carry in spec without disrupting the spec too much -> yes.
> Is this lighter for sw and device to do? -> yes.
> Does it work at scale of VFs? -> yes.
> Does it work as_is with legacy sw? -> No.
> 
> > 
> > And look if that just serves to annoy I can just point out issues and complain
> > without suggestions. Was trying to be helpful here really.
> > 
> Your comments and suggestions are helpful.
> Some of them follow the loop that doesn't help.
> Again, thanks a lot for the inputs and reviews.
> 
> The design discussion helped to produce two solutions here than what was started in v0.

OK good. Now I suggest you make an effort to come up with some
compromise that will make this thread stop. I really can't say
I even remember what we said in the beginning.
You had this idea of starting with a problem statement document
how about doing that? Because I feel every time people bring
up some idea and a problem this idea would solve, you go
"this is out of scope". Let's decide what the scope is?


> > > >
> > > > If we have trouble converging on the notification thing, how about
> > > > we make progress without it for now?  Merge a slow version that
> > > > sends kicks through aq, then work on the best way to make notifications
> > faster, separately.
> > > >
> > > Sure, we can differ, but the VF has the notification BAR to utilize.
> > > So why not use it?
> > 
> > Are you asking why is merging a smaller partial patch then adding functionality
> > a good idea?
> > 
> I am asking a 1.x PCI device has the VF notification BAR already, why we don't use it, why to build an additional one in device?

Following this logic, a 1.x PCI device also has modern common config.
All you really truly need is a flag to make it behave like legacy,
from POV of device config and VQs.


> > > > VF(member) driver can't implement AQ commands at all. They are sent
> > > > to
> > > > PF(owner) thus by PF(owner) driver.  In virt configs, VMM can trap
> > > > legacy access and talk to owner driver to send them.  It can also
> > > > talk to member driver to send notifications.  You can I guess have
> > > > VMM get member BAR offsets from owner and pass them to member for
> > > > mapping. This raises all kind of questions of trust.
> > > Only the member driver has access to the owner driver via kernel API.
> > 
> > Assuming you can predict existance of specific kernel APIs on all OSes is IMO a
> > fool's errand. 
> A specific kernel API is not expected.
> A framework is expected in OS.
> And sw improvise as use case arise.
> 
> Driver to driver communication may be possible in WDM using [1].
> Outside of virtio, I can imagine for PRI level functionality two drivers interaction would be needed too.
> 
> [1] https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/different-ways-of-handling-irps-cheat-sheet#scenario-3-forward-with-a-completion-routine
> 
> > > Part of the VF BAR information at the PCI level is also on the PF.
> > > There is no trust break here. A kernel exposes single self-contained object to
> > user space VMM.
> > 
> > That is ok.  The trust break is if PF driver is in userspace. You then are trusting
> > userspace to pass offsets back to kernel VF driver.
> > 
> > 
> I don't see how a MMIO over PF is somehow more secure than AQ over PF regardless of in user or kernel.
> I don't see how this a problem is.
> Even today when/if IOBAR is trapped by the user space forwarding to kernel can modify the offset and value without any AQ etc.
> 
> I don't even see how one OS can spawn SR-IOV VFs from the user space driver in the kernel.
> 
> Look one can even take the PF from user space to yet another guest VM and add ten other complexities to put oneself to a dead end.

So let's try to keep drivers self-contained as much as possible.


> > 
> > > > If you can map BAR from PF that would be simplest, VMM then only
> > > > pokes at PF and not VF. If not then we really should expose this
> > > > info n the VF if at all possible.
> > > >
> > > There is clearly no need to use PF for notification when the notification
> > method already exists on the VF.
> > 
> > All this looks backwards with mixed up functionality.  What VF has is modern
> > BAR. If you insist on reusing modern functionality for legacy when it suits you
> > then maybe we should reuse it for everything, that would be extending
> > transport vq to support legacy somehow.
> > 
> You bring back same point that we already closed in discussion.
> It is not about suiting me.
> It is what is there in the spec and in device for transitional device. (not specific to 1.x).
> The design criteria is: 
> a. use as much as possible from 1.x and transitional device for the legacy support so that spec changes, device side, sw side changes are minimal.
> AQ fits very well to this criteria.
> 
> b. Avoid inventing new interfaces between driver and device, specifically at PCI device level for things that are often implemented in hw.
> Here also AQ scores well.
> MMIO two register example also works well.
> 
> And notification also works well that reuses transitional device's notification.

I don't know what these are. You had some weird
+struct virtio_admin_cmd_lq_notify_query_result {
+       u8 bar; /* PCI BAR number of the member VF */
+       u8 reserved[7];
+       le64 offset; /* Byte offset within the BAR */
+};
if you want to re-use the normal notifications for VFs we already
describe them using capabilities.

However, this creates a weird mix where there's this command that mostly
follows legacy pci config layout except notifications which are there in
the legacy pci config are actually somewhere else.  And this is just
inconsistent and confusing, and the reason for this is implementation
defined.



> 3 out of 4 functionalities are done on AQ of the TVQ.
> So, it is time to stop asking to replicate the AQ functionality on some new TVQ.
> This was discussed in depth.

I don't think I ever did that.

> > 
> > > In fact, it is yet extra steering entry for the hw to perform such mapping.
> > >
> > > To iterate what presented yday in [1] to Jason.
> > >
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-comment/202305/msg00298.h
> > > tml
> > >
> > > 1. legacy register access via AQ (v1)
> > > Pros:
> > > a. Light weight for hypervisor and devices (mainly PCI) to implement.
> > > b. Enables sw to coalesce some device specific registers, if needed.
> > > Cons:
> > > a. Not self-contained, requires PF's AQ which is anyway designed for such
> > purpose.
> > >
> > > 2. Legacy registers access via new MMIO region (v0 + sane reset)
> > 
> > I think I would buy this one if it was actually in BAR0 exactly legacy with no
> > changes, no reset no nothing. a hack like Jason described that at least makes
> > legacy linux drivers work with no software glue.  That is horrible, fragile but
> > engineering history is full of hacks like this.
> > If you need software in the middle then let's please make it robust.
> > 
> Your ignorance and inclination to see only from the sw pov is not helpful here.
> Feedback from the PCI device side given here to be considered too.

After hearing this for the 10th time I don't think I'm not aware, thanks
for bringing this to my attention for the 11th time.
My point however is the last sentence *If you need software in the
middle then let's please make it robust.* If BAR0 hack does not work
then let's use sane interfaces as much as possible.

> This approach doesn't work well for device reset at scale which is a one way signal.
> 
> Hence, I proposed the either the AQ over PF or the two-register scheme of above over MMIO VF.
> 
> Does that work for you?

AQ works fine I think. This new one I haven't seen yet hard to say.
Probably has its own set of problems ...

> > 
> > > Pros:
> > > a. smaller code in slow register access than AQ b. Sw cannot coalesce
> > > some device specific registers.
> > > c. Self-contained in the VF
> > >
> > > Cons:
> > > a. Relatively burdensome for the device as it requires more RW registers at
> > scale, but it can be indirect register.
> > 
> > what I keep saying
> > 
> > b. a ton of legacy bugs which hypervisor can't detect or work around
> >    (reset is just one issue)
> > 
> > 
> > > 3. legacy registers tunneling with additional indirection via PCI
> > > capability
> > 
> > 
> > I don't know what's this one.
> 
> Above example of legacy_register_addr and legacy register_data on the VF.

Talking about the two register thing.  We actually have this already:
VIRTIO_PCI_CAP_PCI_CFG.  We could allow access to IO BAR through it.


But really since apparently you want to focus on how we solve
notifications let's focus on that. I feel the main issue is
poking at 1.x registers and at the same time at legacy registers.
The spec was written with a strong assumption that it is either or,
never a mix. Changing that will be painful.
This is why I was asking about VIRTIO_NET_F_LEGACY_HEADER - 
legacy can live in software then and we do not need to worry
about it in the spec. I got it that there's too much software
here for your taste, but the problem with legacy is really
that it was always ad hoc and implementation derived.
So we need to keep it siloed.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

