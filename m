Return-Path: <virtio-dev-return-11935-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F6C761AF
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 21:14:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5B6C641A36
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 21:14:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 392BB986420
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 21:14:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2706B9843C6; Mon,  3 Apr 2023 21:14:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 169D29863E5
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 21:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: -lzMc_9OM8OhfduPOJ9LVQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDv1mUhRPtjSsOpVBfQNGnwYv4AFRgkb74tpvs1Q4cU=;
        b=jGCLC/i1mGfFD/OgJ6piyT/Peln+EXxAMovWseN2nRKs/sHuT27pLHsuvbOfKlv7ye
         FjsgB0v1Mk02NWkY23cS+7KQRuTnU0CMp1Zj010aMKTGrG6JlpyHp2XyrUYs28HAmjkv
         vXh3/c/45MdqjhRaAfEu/luB1DGCSXcMYjT6jASbMEAIxCgvmvGqIqVcVMC5bIVOljMm
         WcFpHXwt6j+NrjnIS01/UO40/43S9NEw6OWuXaNjezmjwMdahd0kKZM1isqBlmo/qfZ3
         u/d3ROwpEjX7qeTSXs3Cma1G+8YW2A36Frs1qgWJ0vPhj6rGUet2C903hwbJOTuqY+Iw
         fMtw==
X-Gm-Message-State: AAQBX9f6PiEqX1yockGQp9kj+x+dS4c8Ma/tI/F+A5LHKgAngRhv/KDO
	IzlKWvrEJGcoJJ2AZWpiut+Uoq38WZ6QN6R6cBDFWDGI4114vw3ITqDs3jaRezE26Und3h05xV8
	81QQ530FAwtUJs1d3bHBI2jfb5m2u
X-Received: by 2002:a17:906:cc48:b0:947:ad38:6184 with SMTP id mm8-20020a170906cc4800b00947ad386184mr325976ejb.31.1680556484078;
        Mon, 03 Apr 2023 14:14:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZstxjVsfGkwf3cW1NqnFDeEg0MwqI/41Tn530hOdMWC4I5maGX3redfIe03Pt2/CKSEr56zw==
X-Received: by 2002:a17:906:cc48:b0:947:ad38:6184 with SMTP id mm8-20020a170906cc4800b00947ad386184mr325962ejb.31.1680556483712;
        Mon, 03 Apr 2023 14:14:43 -0700 (PDT)
Date: Mon, 3 Apr 2023 17:14:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230403170525-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
 <20230403134407-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F46C61C499621DB5563DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403155310-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FCD5F8C57821B14FF360DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FCD5F8C57821B14FF360DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device

On Mon, Apr 03, 2023 at 08:42:52PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 3, 2023 4:03 PM
> > 
> > On Mon, Apr 03, 2023 at 07:48:56PM +0000, Parav Pandit wrote:
> > > > OK but supporting them with a passthrough driver such as vfio does
> > > > not seem that important.
> > > Not sure on what basis you assert it.
> > > I clarified in the cover letter that these are the user level requirements to
> > support transitional and non-transitional devices both via single vfio subsystem.
> > 
> > And what is so wrong with vdpa?  Really I don't see how the virtio spec needs to
> > accomodate specific partitioning between linux modules, be it vdpa or vfio.
> > Way beyond the scope of the driver.
> >
> vdpa has its own value.
> 
> Here requirements are different as listed so let's focus on it.

I'm not sure how convincing that is. Yes simpler software is good,
it's nice to have, but it's not such a hard requirement to use vfio
when vdpa is there. And again, the cost is reduced robustness.

> > But anyway, my main
> > point is about DMA. On the one hand you are asking for a VQ based
> > management interface because it saves money. On the other you are saying
> > DMA operations take extremely long to the point where they are unusable in
> > the boot sequence.
> 
> I think you missed the point I described few emails back.
> The legacy registers are subset of the 1.x registers, so a device that implements existing 1.x registers, they get legacy registers for free.
> Hence, there is no _real_ saving.

First not 100%.  E.g. MAC is writeable so that's a R/W register as
opposed to RO.  But generally, why implement 1.0 registers at all? Do it
all in transport vq.

> > So what is it? Was admin vq a mistake and we should do memory mapped?
> No. Certainly not.
> AQ is needed for LM, SR-IOV (SR-PCIM management), SIOV device life cycle.
> 
> > Or is
> > legacy emulation doable over a vq and latency is not a concern, and the real
> > reason is because it makes you push out a host driver with a bit less effort?
> > 
> Legacy registers emulation is doable over VQ and has its merits (I listed in previous email).
> I forgot to mention in previous email that device reset is also better via tvq.
> It is just that legacy_registers_transport_vq (LRT_VQ) requires more complex hypervisor driver and only works for the VFs.
> 
> At spec level, MMR has value on the PF as well, hence I previously proposed last week on your first email that spec should allow both.
> 
> Efforts of hypervisor not really a big concern.
> Once we converge that LRT_VQ is good, it is viable option too.
> I will shortly send out little more verbose command on lrt_vq so that its optimal enough.
> 
> > I just do not see how these claims do not contradict each other.
> 
> An AQ for queuing, parallelism, memory saving.

Ok that all sounds good.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

