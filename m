Return-Path: <virtio-dev-return-13508-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900CFC0015E
	for <virtio-dev@archiver.kernel.org>; Fri, 11 Aug 2023 14:20:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D17552AEDC
	for <virtio-dev@archiver.kernel.org>; Fri, 11 Aug 2023 14:20:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF7B19865D9
	for <virtio-dev@archiver.kernel.org>; Fri, 11 Aug 2023 14:20:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AA3F9983D99; Fri, 11 Aug 2023 14:20:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 931B19865CE
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Aug 2023 14:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763641; x=1692368441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A2H32MvxyVA92h2iLfjVjwDp89Sr/D9cbLXIfhXhxw=;
        b=lGfP9I66b1xMCybkmNXb2dCy+iFsJBJ5umtB0dQfDir7lQFx/jSuWMh1uFf/ts3fUs
         8Wc7RSw0KRc1QhDnXKd/X+MbDq0jxxUNnRgGnUWjVhShm/u/FDbK3eDWbMhJ+wrR1I7+
         DJexHOLJMhVxGK6JVcaVItY8bxDSsKL8Ri3AfQ91dNTYqTTX9k/UXQk55FRsXf13WXgW
         pzV5jIf+IHGeqTGrjxuuxdOnfNoJOKKj0I7jnG73YJPv8TqG2x0luVyZUnSZIFPL5rpb
         PRz3MbqWoSAGPawF33gP2LCAEsnF+GamH+OSIs0eWN4ze6HfgvEOLGGbGjEzxp4POBEO
         nGTw==
X-Gm-Message-State: AOJu0YxhL/vnM4bs3b2B6DafQUNWVC4YVsM/eakEU0WS2LH65n+5l05+
	6CjoUSf2vsM3QeEYtGFcaJ5iJQ==
X-Google-Smtp-Source: AGHT+IGybX2kP1N4QFNMH3vH0B1xxvhxyNZeZBK8iASGdQciE4qG8niSomC+IC8/YVleIfbGJjyeog==
X-Received: by 2002:a5d:42d2:0:b0:317:52d2:d05f with SMTP id t18-20020a5d42d2000000b0031752d2d05fmr1713414wrr.26.1691763641433;
        Fri, 11 Aug 2023 07:20:41 -0700 (PDT)
Date: Fri, 11 Aug 2023 15:20:39 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: virtio-comment@lists.oasis-open.org, eric.auger@redhat.com,
	virtio-dev@lists.oasis-open.org,
	Zide Chen <zide.chen@intel.corp-partner.google.com>,
	crosvm-dev@chromium.org
Message-ID: <20230811142039.GA2189828@myrica>
References: <20230803153238.541803-1-jean-philippe@linaro.org>
 <20230803153238.541803-5-jean-philippe@linaro.org>
 <ca33f633-26ea-b254-a75d-3bbf86d15d24@daynix.com>
 <20230810151036.GA1901900@myrica>
 <96d8b628-3f21-40de-ab2e-20e6043dc937@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d8b628-3f21-40de-ab2e-20e6043dc937@daynix.com>
Subject: [virtio-dev] Re: [PATCH 4/4] virtio-iommu: Clarify hot-unplug behavior

On Fri, Aug 11, 2023 at 07:21:29AM +0900, Akihiko Odaki wrote:
> On 2023/08/11 0:10, Jean-Philippe Brucker wrote:
> > On Fri, Aug 04, 2023 at 03:19:27PM +0900, Akihiko Odaki wrote:
> > > On 2023/08/04 0:32, Jean-Philippe Brucker wrote:
> > > > Since it is not obvious what the virtio-iommu device or driver should do
> > > > when an endpoint is removed [1], add some guidance in the specification.
> > > > Follow the same principle as other (hardware) IOMMU devices: clearing
> > > > endpoint ID state on endpoint removal is the responsibility of the
> > > > driver, not the IOMMU device.
> > > > 
> > > > On most hardware IOMMU devices, the endpoint ID state is kept in tables
> > > > managed by the driver, so intuitively the driver should be updating the
> > > > tables on hot-unplug, so that a new endpoint plugged later with the same
> > > > ID does not inherit stale translations. Besides, hardware IOMMUs have no
> > > > knowledge of endpoint removal. It is less obvious for virtio-iommu
> > > > because endpoint states are managed with ATTACH/DETACH requests, and a
> > > > virtual platform could in theory update the endpoint state when it is
> > > > removed. Existing VMMs like QEMU don't do it, and rightly expect the
> > > > driver to manage endpoint ID state like with other IOMMUs. It is not
> > > > invalid for a VMM to clean up state on endpoint removal, but a driver
> > > > shouldn't count on it.
> > > 
> > > I think it's better to say it's invalid to detach on endpoint removal.
> > 
> > It's certainly not a clear cut choice and I'm still hesitating whether we
> > should allow, deny or let the VMM choose what to do.
> > 
> > However, it looks like crosvm already detaches the domain when an endpoint
> > is unplugged:
> > 
> > https://github.com/google/crosvm/blob/e8b2cd080e8174948563567d395c2a42416f2807/devices/src/virtio/iommu/sys/unix.rs#L68
> > 
> > If I understood correctly, this function is called on PCIe hot-unplug, and
> > endpoint_map represents the domain attached to an endpoint ID. So the
> > domain is detached on endpoint removal. If a DETACH request is sent
> > afterwards, it will still succeed (detach_endpoint() in
> > devices/src/virtio/iommu.rs returns detached=true, which causes DETACH to
> > succeed, even if the endpoint is not in endpoint_map). But I could be
> > wrong as I'm not familiar with crosvm or rust.
> > 
> > That does make the decision a little easier, because if we did
> > retroactively specify that detaching on removal is invalid, this code
> > would become a bug. But in my opinion crosvm isn't doing anything wrong
> > here. It feels valid and even good practice to clean up all state
> > associated to an endpoint when it is removed, to avoid leaks and stale
> > objects.
> 
> In this case I think it's creating use-after-free hazard. The guest believes
> it is managing domains and assume a domain is available until it makes a
> DETACH request for the last endpoint attached to the domain.
> 
> However, if the host automatically detaches an endpoint from a domain and if
> the domain has no other endpoints, the domain will be gone and the domain ID
> may be reused for another domain. If the guest makes a request with the
> stale domain ID before it becomes aware that the device is unplugged, the
> request will be performed on some arbitrary domain and may break things.

That's an excellent point, there is a race:

        VMM                        GUEST
     Remove ep 1
       detach domain 1
       destroy domain 1
                                ATTACH ep 2 to domain 1
     Handle ATTACH
       create domain 1

     Notify that ep 1 is gone
                                Handle notification, DETACH ep 1

The guest tries to attach ep 2 to domain 1, which succeeds. So the
guest expects that ep 2 is now able to access the mappings that were on
domain 1. But instead it's a new empty domain.

I think that's a good justification for adding a device normative
statement, something like:

  The device SHOULD only detach endpoints from domains when requested by
  the driver; either when handling ATTACH and DETACH requests or when
  performing a device reset.

> 
> By the way, crosvm's logic to detach endpoint on removal looks incorrect for
> me. A domain may have several endpoints attached, but the code looks like
> it's always destroying a domain whether there are other endpoints attached
> to the domain. I'm adding Zide Chen, who wrote the code according to git
> blame, and crosvm-dev@chromium.org to CC.

Link to this thread for more context:
https://lore.kernel.org/virtio-dev/20230803153238.541803-5-jean-philippe@linaro.org/

I thought crosvm rejected attaching multiple endpoints to one domain but I
think I misread. Rejecting multiple attach would be a straightforward fix
(it's allowed by the spec), though it would prevent assigning endpoints
that cannot be isolated from each others by the hardware (the driver won't
attach those to different domains, if it's made aware that they should be
in the same IOMMU group, for example if they are on a conventional PCI
bus).

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

