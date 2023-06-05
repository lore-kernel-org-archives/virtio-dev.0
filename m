Return-Path: <virtio-dev-return-12864-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F55C7EE2C
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 13:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0CFE968470
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 13:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2ADF986423
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 13:50:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB1769863AC; Mon,  5 Jun 2023 13:50:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97E3E9863AD
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Jun 2023 13:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xuP5yf_FP9qIHMZJ4EnVVA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685973028; x=1688565028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16XhT2NG/x/cYy++gaxr+vm9K09euZDnweE7g5Unw0c=;
        b=UVHJrLF4yWMVBEPY2x4+hgrG83s/YcTKFvEgpyoe643DOPEw+2+2gnO604LIihtCmA
         wgFhKd/BBUU+IL4UDpCK7QghYMXs6oHQXmpME8ZphJYJkaEDuie3MQvMHXQkGU9CD5yi
         C/NFveLx6isc8t8gr1WL/GTn7yBo4iOrOit3dfSJJu56vxCPCTEkpN/yWtkDfumGJmHR
         KZfE0V+yAcwhd9vaH+OCHGQrw1qs9RZrnIxBmtsbwz9alIhV0deoifWipk3eIFx6yC0D
         k0LcIxtd9EM+dZ/WHbkJztAVxNGqk0hG59hk4VC2ekritSEdnGvAe3GlSHJgKgB4dVHS
         nOWg==
X-Gm-Message-State: AC+VfDzYaxmY8c7U7Ieonh/1Ges2zRWkU9PkWUSE9lbiPyMrSyosYjQh
	Rlu62hjyiDcIq8Omncr77pTx/ccJNI58sTk19JmSUe6JfODlm7v0WgIX1Ya2tFs740xmjhPVHJ6
	PsHdlilyVeb9DqaVH7UyXzFxQhjX+
X-Received: by 2002:a5d:58e9:0:b0:309:492a:bb08 with SMTP id f9-20020a5d58e9000000b00309492abb08mr4634140wrd.43.1685973028329;
        Mon, 05 Jun 2023 06:50:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55+sgFyWuJBZfvJRWLZxEKVdkps+PWW8GowmpzxBpwMK09znti26qIcytDHO5rAb+YFp8Gqg==
X-Received: by 2002:a5d:58e9:0:b0:309:492a:bb08 with SMTP id f9-20020a5d58e9000000b00309492abb08mr4634124wrd.43.1685973027986;
        Mon, 05 Jun 2023 06:50:27 -0700 (PDT)
Date: Mon, 5 Jun 2023 09:50:21 -0400
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
Message-ID: <20230605092859-mutt-send-email-mst@kernel.org>
References: <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ

On Mon, Jun 05, 2023 at 01:27:04PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, June 5, 2023 1:52 AM
> 
> [..]
> > > > E.g. with 1.x using VIRTIO_F_NOTIF_CONFIG_DATA - probably not.
> > > >
> > > Not really because legacy doesn't have that feature.
> > > Legacy notifications are subset of 1.x feature.
> > > This was also discussed.
> > 
> > So for legacy such hardware will likely not want to use the same BAR.
> > 
> I don't follow this comment in conjunction with your below comment about offset 0.
> If we consider offset 0, legacy will use the same notification area as 1.x, right?
> So I am confused on "hardware don't want to use the same "BAR".

Never mind,

> > 
> > > > Let's just say, we are not in the position where we dictate these
> > > > things to OS vendors yet.  One of motivations of the spec is making
> > > > writing drivers easier so let's add an option for that pls.
> > > >
> > > There is no need to add multiple options at this point when the hw vendors
> > are not going to implement.
> > > When we find another vendor to implement, we can always add the new
> > method.
> > > Marvell and Nvidia both are forwarding with AQ at present proposal.
> > >
> > > > > VF has BAR for driver notifications. This BAR is used for 1.x and legacy.
> > > >
> > > > But it's the same piece of silicon - be it in PF or in VF.
> > > > I really don't see why it matters.
> > > >
> > > In same piece of silicon one needs to open yet another PCI steering entry to
> > tell that treat this for VF.
> > > This double size programming is useless.
> > >
> > > Yet again we are discussing same point as before.
> > >
> > > > > There is no need to ask vendors to build new HW to put driver
> > > > > notifications
> > > > on the PF BAR for VFs, when it already exists on the VF.
> > > > I'm talking about giving vendors an option not asking them.
> > > >
> > > Ok. Understood.
> > > When a vendor prefers to implement such cross hw forwarding it can be done.
> > > There isn't a desire to burn and program extra hw for functionality that
> > already exists on the VF.
> > > Hence, VF's doorbell on PF can be parked for the future option when one
> > actually wants to implement it.
> > 
> > I reached out to windows team to know how big a problem this is. Let's see.
> > 
> > 
> Ok. Linux didn't had multi-function driver support and infra was added.
> So even if the facility may not be there, or if the current IPR facility they may not want to use,
> 
> In future OS vendor itself can provide the new APIs.
> I certainly don't see being blocked on this.
> 
> But good to get feedback on there current state of OS.
> 
> > I have another idea meanwhile: VF already has notification capability. The only
> > issue is offset has to be queried through modern BAR.  How about we agree that
> > for legacy, we just agree that offset 0 is used?  Does not sound like a big
> > sacrifice of memory to me, and we completely avoid the new command and the
> > need to tie PF and VF.
> 
> It will not work for the SIOV which shouldn't replicate this capability (and some other cap) so many times, are you ok with it?

Yes - SIOV has both command and BAR in the PF.

> Can you explain the motivation of : why querying notification offset via the group member PF is a problem, if there is."

I tried already, I can repeat if you like:

So, I am thinking of a model of using a tiny stub driver for the member.
Control path driver is bigger as it operates AQ command, that would be
the owner driver.  E.g. for PCI this driver needs to map BAR offsets.
Then it handles all data path for this member: driver and device
notifications.  It is clean and easy on all systems assuming you know
offsets at device probe.  But getting it in software from another driver
(owner driver) is AFAIK tricky on some systems.

Generally solutions can be found, they can be more or less robust, and
if systems designers have to overcome obstacles in implementing virtio
they will just go to a competing interface as opposed to jump through
hoops and work on extending either the OS or the virtio spec.

Yes I know your sales department tells you there's no demand for this
feature on anything that is not linux/x86 and maybe arm, and maybe this
means there won't ever be either, but let's just not raise this again
can we? E.g. there was some interest from microsoft at some point,
I think there was a reorg and that project died but hey you never know.
Anyway, you asked I am trying to answer.

The cleanest way is just doing things consistently through one device.
In this case for data path it has to be the VF, so let's just make this
part simple and self contained.


> I don't see a problem with AQ that covers VF,SF/SIOV for legacy.
> 
> Proposed AQ command is cheap and covers both VF, SF/SIOV.

Well for SIOV BAR has to be the owner BAR. This was exactly the reason I
asked for this. If it's not to be I think this is my second preference:
no new command at all, and SIOV will come up with its own.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

