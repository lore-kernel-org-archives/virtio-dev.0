Return-Path: <virtio-dev-return-12407-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7C6C77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:31:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EC8AC2ACAF
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:31:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4386986463
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:31:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C14B3986447; Tue, 25 Apr 2023 13:31:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD2B698644B
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 13:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1wDkLqo9PRum0BVGOscE8A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429499; x=1685021499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtNHPIFUbzsrcR2eLCwa84RGhSSok/fmbns0yW72U6Y=;
        b=hUDVb8xdfxOZW1ryIzZwdFA81osVJQo9qzjhZZMXwWGzRnybFGnADc3dwyA4Og9/7p
         O6V8JRQC5BgXvcjlnrQVClMGVBRi18EzJXlCt2NBG2VCD7rUJ6CE++p/1E09WMrPNhkz
         NufQBn0CrfDEYedjlUgmIn8okw/T51/yoyRVqdE3BmtNB9Rpk41rNp4JvZkwguD6s+6V
         STXU3Ja5c/AYBCFUt/0XoD/eCwCIvxdZx4a8315iC41c6j4DZALP58qj3OSmihk+BIkh
         B4xDzjwfxmo+SgQE93cOcYvtadSW7eZt0GdE6moO1cX+OicFNnbvoMy/7xrKo1+g8Aau
         MxhQ==
X-Gm-Message-State: AAQBX9fc/4Kn3sKlyD+3/mofoWYPOhIjxJ5LwoAVY39q9hAUtEXHBth4
	ifuEMiYVpyMSMJXIDIEaT84+I0f/gi371Xhrj4ry4TsTDS89PxbsTG/MRRrua+MzKHR7wwkgrJJ
	s5WV7Hrds41VNpVJY0uTQQ0dyZiro
X-Received: by 2002:a5d:6789:0:b0:2ef:e73d:605d with SMTP id v9-20020a5d6789000000b002efe73d605dmr15074068wru.30.1682429499131;
        Tue, 25 Apr 2023 06:31:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRc9SL5vtgWdeIRBqGhRR3kfPP1YYgAQksent31BtCYhjsuqK6fwVSxp8dNj4vW41wpPJ2WA==
X-Received: by 2002:a5d:6789:0:b0:2ef:e73d:605d with SMTP id v9-20020a5d6789000000b002efe73d605dmr15074047wru.30.1682429498775;
        Tue, 25 Apr 2023 06:31:38 -0700 (PDT)
Date: Tue, 25 Apr 2023 09:31:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230425092651-mutt-send-email-mst@kernel.org>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
 <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
 <20230425020925-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9A42176A43075D4AD4DDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D9A42176A43075D4AD4DDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 03/10] admin: introduce group administration commands

On Tue, Apr 25, 2023 at 01:25:24PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 25, 2023 2:20 AM
> 
> > > Below paragraph is no longer applies as we already discussed more use
> > > cases of the AQ such as accessing the PCI VF's legacy config space registers.
> > > Please drop below paragraph.
> > 
> > Look - at one point you want commit log to record design process, an another
> > you turn around and ask me to drop it.
> > I feel like keeping this around frankly. Maybe I will add a sentence or two along
> > the lines of "Note that nothing limits us from extending this down the road
> > though - but let's focus on what we already know for now".
> > 
> I am requesting to drop the commit point that limits the usage of the AQ.
> Do you agree that AQ can be extended for use beyond VF and SIOV group management commands?
> Or one should create a new VQ type?
> If it is the later, I don't see the need of multiple AQ.

not management. that is old term and indeed too narrow.
administration as in hypervisor (admin) access through PF while 
guest has access through VF.

legacy access you link to below seems to fall within scope:
we access VF through a PF.

So what is the problem?

maybe we'll change the meaning down the road. I do not
see the immediate need currently though.


> > This extreme focus on commit log is poinless anyway - it makes much more
> > sense for code since commit log describes the change in english. Here the
> > whole change is english anyway.
> > 
> > > > Without this the admin vq would become a "whatever" vq which does
> > > > not do anything specific at all, just a general transport like thing.
> > > > I feel going this way opens the design space to the point where we
> > > > no longer know what belongs in e.g. config space what in the control
> > > > q and what in the admin q.
> > > > As it is, whatever deals with groups is in the admin q; other things
> > > > not in the admin q.
> > > >
> > >
> > > A PF can use same or different AQ with a new struct
> > > virtio_legacy_register_access with a different opcode range.
> > 
> > We'll get to that bridge and we'll cross it, the proposal is not on list even yet. 
> It is at [1].
> [1] https://lists.oasis-open.org/archives/virtio-dev/202304/msg00511.html
> I cannot draft the legacy command using AQ because AQ patch-5 in v12 fails to merge.
> 
> Before I draft it, I sent [1] on the design way forward.
> 
> > I
> > actually think that yes, you need it in a separate function. If PF is passed
> > through to guest then PF can not also safely DMA into host memory.
> That is fine. Only some user tests would pass the PF and VF to the VMs.
> One can create N combinations to make it not work.
> In all practical purposes, PF is owned by the hypervisor, trusted sw as listed in the PCI spec.
> 
> > Alternatively, we could use an MMIO based mechanism for admin commands.
> > And maybe that would be a good fit.
> We discussed that MMIO is not a good fit for the VFs at scale as listed in [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202304/msg00511.html

Then I don't see a problem. It's just commit log, not spec. Let it
slide is my suggestion, this is spec text not code.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

