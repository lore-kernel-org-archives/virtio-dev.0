Return-Path: <virtio-dev-return-13887-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A1CCE79CE
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 14:16:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9689812D358
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 14:16:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 688E098667A
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 14:16:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F4FE98666B; Wed, 20 Sep 2023 14:16:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 403D898666C
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 14:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2RS-1uPVOVGnXTm70fvVVg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219368; x=1695824168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWCZpURgCu/EOsxI5VaP1DWFknByf+RQb5nAQ5saRss=;
        b=B86nomWXSpsfo0maRjvWLxDW2XiVbLutkBlU1qR2f1h49CghT2jdttbizZHK9xnlR2
         4wxHyf2T6XS87PM3D6RzueXASoMMG4qruj/PeBJQrXhNj1nrS+7vAloOVobIDFp926oO
         4BJH+Y4x2jlVlOIWe4pPwSt5h4vAVvQd5g4TxZY0uaAJDX27luQGkNY8A/vRBLt7bgf9
         10W2cT6gFnAWPAADJDboPGxs9BYbzBmSte3Onboz7HwDRAmNlU+A74gQND4RBlRkuky+
         dP3G8hjtr7qBpvL4SYmTT+VQqk41vzbI0CsF3r8TbAartrVzfW+Ymov2BiQhXHYvlzNz
         LKWw==
X-Gm-Message-State: AOJu0YzO9FcsT9OF2j2Yx5yKgqm07nuxDKqCx5Gh7LMBMXjh7/bH6AT3
	Lp/0MoGVKJIjij4zk0sHb/CvFt/IlIFD+H8mNih48Giv0j5u/6vukpMbBJFAZtxAxFASIcUeQnw
	0KzK7BSUV2TRW3Lpe53FXLgDS3aFy
X-Received: by 2002:a17:906:5308:b0:9a1:e941:6f47 with SMTP id h8-20020a170906530800b009a1e9416f47mr2282907ejo.42.1695219368689;
        Wed, 20 Sep 2023 07:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIFufMDOmWLQAiliJpdND/Agp1baCfYJUK6R1FlsOXJNVwZwC2ppU/DZ6DMi2ItROyBcBr8A==
X-Received: by 2002:a17:906:5308:b0:9a1:e941:6f47 with SMTP id h8-20020a170906530800b009a1e9416f47mr2282891ejo.42.1695219368335;
        Wed, 20 Sep 2023 07:16:08 -0700 (PDT)
Date: Wed, 20 Sep 2023 10:16:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230920101402-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 20, 2023 at 01:41:00PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 20, 2023 6:12 PM
> 
> > And Parav same goes for you - can you summarize Zhu Lingshan's position?
> 
> Below is my summary about Zhu Lingshan's position:
> 
> One line summary of his position in my view:
> 
> 0. Use inband device migration only, use mediation, mediation is secure, but AQ is not secure.
> 
> Details of his position in my view:
> 
> 1. Device migration must be done through VF itself by suspending specific vqs and the VF device both.
> 2. When device migration is done using #1, it must be done using mediation approach in hypervisor.
> 
> 3. When migration is done using inband mediation it is more secure than AQ approach.
> (as opposed to AQ of the owner device who enables/disables SR-IOV).
> 
> 4. AQ is not secure.
> But,
> 5. AQ and admin commands can be built on top of his proposal #1, even if AQ is less secure. Opposing statements...
> 
> 6. Dirty page tracking and inflight descriptors tracking to be done in his v1. but he does not want to review such coverage in [1].
> 
> 8. Since his series does not cover any device context migration and does not talk anything about it, 
> I deduce that he plans to use cvq for setting ups RSS and other fields using inband CVQ of the VF.
> This further limit the solution to only net device, ignoring rest of the other 20+ device types, where all may not have the CVQ.
> 
> 9. trapping and emulation of following objects: AQ, CVQ, virtio config space, PCI FLR flow in hypervisor is secure, but when if AQ of the PF do far small work of it, AQ is not secure.
> 
> 10. Any traps proposed in #9 mostly do not work with future TDISP as TDISP do not bifurcate the device, so ignore them for now to promote inband migration.
> 
> 11. He do not show interest in collaboration (even after requesting few times) to see if we can produce common commands that may work for both passthrough (without mediation) and using mediation for nested case.
> 
> 12. Some how register access on single physical card for the PFs and VFs gives better QoS guarantee than virtqueue as registers can scale infinitely no matter how many VFs or for multiple VQs because it is per VF.
> 
> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead


OK so with this summary in mind, can you find any advantages to
inband+mediation that are real or do you just see disadvantages? And
it's a tricky question because I can see some advantages ;)


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

