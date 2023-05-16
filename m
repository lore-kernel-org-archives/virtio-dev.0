Return-Path: <virtio-dev-return-12732-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD97EC77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:09:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E24364290B
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:09:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA62F9865B7
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:09:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE3DF9862F7; Tue, 16 May 2023 21:09:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA0E99862FA
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 21:09:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 07ZhtsX9Ns-OmC5ZoMpecg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271366; x=1686863366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQV0u3X52CyopF7GnpPbbEIyr8N3j8XVSiw0eAiT3KI=;
        b=UEsDhtVPaLbzoM+vrF9ThmHnuL4TEZeUTK14YqmnLNNtm1m3z30hjoUjpaQmS8tzBk
         zOE/QLK9Ss/KkjzqouH1DCfp99XBjHGt4WeL92mPMsDS8vzBvjTkwMj05WHD+idO1rdk
         lhdILFDOSnQOUPDipcAeSABZ0gApuywGiYpnVcs+bNFmWog+05+XFVzvmOZiejoKUNjc
         /vsI05asZcXDGdIZmWAwvhNQIFFo7bh16i4al6bp2A5NPdqFixTMReKkhFqCh6u3+lIb
         W/uaUO09daoO6CSSPo5AsMumcX3jGNc35hzYIxa+4Cfv38qWCYoi04Fy9r3qVTsqB65Q
         HnLQ==
X-Gm-Message-State: AC+VfDx3+h8cP/VPzx1Zn7D9RBOmpR79UaTxl85RCRQBQJC+oj/Yh/8p
	B1vgfjJjc0bAvY4REa1Fe4opANZH1e8bxZwFNZRQJHTgwLrUl4pFPraqtKmHsH6N9d4nC9u0txz
	31wUbgRjp3Nd8W86vwRsCInii+mN2
X-Received: by 2002:a05:600c:3b92:b0:3f4:220e:bff7 with SMTP id n18-20020a05600c3b9200b003f4220ebff7mr57423wms.5.1684271366541;
        Tue, 16 May 2023 14:09:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rxcf/9Trxg/vHfapsIH/yjbZRmYb4o2K73f3JG7Y/OLfPTdD8GZK4m/Z8T16u/XmFH3BQ1Q==
X-Received: by 2002:a05:600c:3b92:b0:3f4:220e:bff7 with SMTP id n18-20020a05600c3b9200b003f4220ebff7mr57407wms.5.1684271366198;
        Tue, 16 May 2023 14:09:26 -0700 (PDT)
Date: Tue, 16 May 2023 17:09:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230516165853-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078af8e2-fb10-b33a-6751-374c4fbd09a9@redhat.com>
 <PH0PR12MB5481F2BE9C7CB89282E4053DDC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHqD4UUB8PSpSmwYRhvthGzPJ7Up-9xQ+RO8a1N01-rw@mail.gmail.com>
 <PH0PR12MB5481205FAA079FAB1F0E22C2DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481205FAA079FAB1F0E22C2DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Tue, May 16, 2023 at 07:29:44PM +0000, Parav Pandit wrote:
> 
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, May 16, 2023 12:08 AM
> 
> > > For guest and by guest are two different things.
> > > I am proposing that a cfgq/cmdq should be used directly by the guest driver as
> > base line like any other VQ.
> > 
> > I'm fine with this, but if I understand correctly, but I don't see any proposal like
> > this that is posted to the list?
> > 
> Because it is orthogonal to the work here, it's hard to make progress by mixing everything.
> 
> > > And if there is a need for mediation, it should be possible.
> > >
> > > > I think we've discussed many times that legacy is tricky for hardware.
> > > And we want to proceed for the described use case and requirements.
> > >
> > > > And your proposal proves this further by introducing modern alike
> > > > notification areas.
> > > Not really. A modern device is offering the notification area like legacy to the
> > legacy interface.
> > > So this is just fine.
> > 
> > I don't say it's not fine, it's pretty fine and transport virtqueue have similar
> > commands. And this also answer the question that you think tunnel PCI over
> > adminq is not scalable. We can keep this command in that case as well, or
> > invent new capabilities.
> > 
> Ok. so virtio_admin_q_cmd_lq_notify_result is fine.
> 
> > >
> > > > We probably need to deal with others like endianess.
> > > >
> > > No point in discussing this again. One size does not fit all.
> > > It solves large part of the use cases so it is valuable and will be supported.
> > 
> > This is doable, we need to leave some space for future development. Or is it
> > just complicated to have an endian command?
> > 
> Possibly one can set. I don’t know if any actual device really supported endianness.
> No users have asked for it, even asking explicitly to those non_little_endian users.

For sure, ARM BE does exist and Red Hat supports it because yes,
it was requested. You can not just go by what marketing tells you
today we either try to build future proof interfaces or we don't
bother at all - by the time these things are in the field everything
shifted.

> So may be when there is/if a real user, it can be done in future.

The concern is if you assume LE is default, no way to say
"I do not support LE". Something like an explicit
"SET LE" and "SET BE" commands will automatically allow
discovering which endian-ness is supported.

> > >
> > > > For any case, having a simple and deterministic device design is
> > > > always better assuming we've agreed that mediation is a must for
> > > > legacy drivers. Using dedicated commands can make sure the
> > > > implementation won't need to go with corner cases of legacy.
> > > >
> > > Corner case handling just moved from the device to hypervisor.
> > 
> > That's not safe, the device should be ready for malicious inputs.
> > 
> With current offset, register, device will be just fine as most implementations have to program control path etc on these registers write/read etc.
> So, device will be able to handle them with plain 2 commands.

Except legacy is broken broken broken.  It just does not work for
physical devices in a crazy number of ways. How about the weird 48 bit
limitation on PAs? Because no one ever will need any more.

I have 0 sympathy to this idea of reviving all these bugs then circling
back and coming up with weird work arounds.  Please, just build a sane
transport and have software deal with bugs as best it can.



> > > For SIOV there is no backward compatibility requirement.
> > 
> > It has several ways to support current virtio-pci drivers in the guest, and such
> > compatibility is almost a must for the public cloud.
> > We can't enforce the user to reinstall/recompile their kernels/application in
> > order to work for SIOV.
> Sure, an SIOV device emulating PCI device for guest is one requirement.
> 
> And SIOV device working natively spawned from the parent PF and used without guest is another requirement.
> 
> And second can be done bit elegantly in self-contained way without depending on the parent PF.
> And requires more work unrelated to this one.
> 
> > I think we are discussing what it can be, so see the above reply for the
> > notification areas, we can stick virtio_admin_cmd_lq_notify_query_result
> > command for PCI over adminq, or invent new capabilities to make it fully self
> > contained.
> > 
> As we both understand well that a queue is not going to transport a doorbell and actual IMS interrupts, we will mostly have commands to service some needs for backward compat.
> It is a separate work when there are no PCI VF devices.
> 
> > >
> > > >
> > > > >
> > > > > You only want to exchange currently defined config registers,
> > > > > interrupts and
> > > > notification configuration using AQ.
> > > > >
> > > > > Transport VQ is NOT transporting actual data, it is not
> > > > > transporting
> > > > notifications etc.
> > > > > It is just a config channel.
> > > > > Hence, they are just commands not a "full transport".
> > > >
> > > >
> > > > For any case, a virtqueue could not be a full transport. It needs
> > > > bus facilities to do bootstrap/DMA/notifications at least. The idea
> > > > is to save for transport specific resources and use a more scalable
> > > > way to config devices.
> > > >
> > > Hence it needs only needs a cfgq, not the full transport. :)
> > >
> > 
> > Well, not a native speaker but I'm fine if you want to call it configq.
> Michael called it admin vq, so will stick to it for now. :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

