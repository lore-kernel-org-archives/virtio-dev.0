Return-Path: <virtio-dev-return-11484-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F04C6FD1A
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:30:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 707EC26A30
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:30:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FEC59866D0
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:30:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 51D8F9866C6; Tue,  7 Mar 2023 16:30:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EBA09866C7
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Mar 2023 16:30:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: A8ooIzA9MSqvqXoHtq1lTQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98uTpV145EHl6mWYX6PEdg9YvFQFDXpZnjZkBUxBGOA=;
        b=lxXyGkAOemKfLwrdI6JPh94ll2LW8w77Y5ON/vEhZKPEc4jn75DrbDgrxBEIFg0PTL
         ZnUmtAzL/h92OQG3uvEyWB1BLX9q+cxts6sjLhVAGRaB33Xf1j4XQZOnpo4hDBA4Lh7h
         w8XLc5C1Ns560CKv3LYGs9sC/Hc7AP/QdSiIfbK901JiFAtUK4iNSKga0cQYeFq7Qp6k
         Rw24JEuuPiQ/pmpBu4PzYGyshIT50KyIeV/HxyiM16wmfMSp7ltmI1pj7qIwPbggqMi3
         2HktMQT7VjpO0RfLHGQFu1jZcCXB9MThbIycpgBVzxL24MxzV5JUx0A/tD62t+HaUVy5
         QJ5Q==
X-Gm-Message-State: AO0yUKXE/DOjn9onty2QgmreNkAHwcEIXp8zRwTFXmFskKNF5SwLKCaf
	4U4XbV7BgBC/KEBX4TWCcZ0d4wvu7FELyCulVVBvToiuZs7qUJkarNboBAMVGd4y6ElZTUWEWOP
	k9dMNKs+3S/2htDDjH2L1tz+evjS3
X-Received: by 2002:a05:600c:4592:b0:3dc:4b87:a570 with SMTP id r18-20020a05600c459200b003dc4b87a570mr15049168wmo.35.1678206622779;
        Tue, 07 Mar 2023 08:30:22 -0800 (PST)
X-Google-Smtp-Source: AK7set/3cGwPVcLPEiWEN9ZllIVLV+KRX2c60uew36WCnuHEF/YjPIU531LHeUqATzFQ/uVEVn08hQ==
X-Received: by 2002:a05:600c:4592:b0:3dc:4b87:a570 with SMTP id r18-20020a05600c459200b003dc4b87a570mr15049147wmo.35.1678206622440;
        Tue, 07 Mar 2023 08:30:22 -0800 (PST)
Date: Tue, 7 Mar 2023 11:30:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230307111458-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAbpiRVdo8BciELX@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

On Tue, Mar 07, 2023 at 08:36:41AM +0100, Jiri Pirko wrote:
> Hmm, if not for now, the future exension would not be so simple, I fear.

Without knowing what it is I can't say.

> 
> >
> >Passing commands to devices themselves is already covered in spec
> >reasonably well though not in a generic way.
> 
> You mean using the control queue, correct?

Depends on the device type. network devices have a control queue, yes.

> >From one of the patch description of this patchset I understand that you
> cannot use control queue for this because control queue is
> device-specific, yet group control is device-agnostic.
> 
> My undestanding therefore was, that the admin queue you are introducing
> serves as a generic carrier for device-agnostic commands, in parallel
> for having control queue serving as a generic carrier of device-specific
> commands. If this is not the case, I think it would be nice to describe
> the exact monivation and scope of admin queue.

Nope unfortunately.  This queue is just a carrier for admin commands.
admin commands are commands that talk to one device about other
devices. There's clearly no mechanism in the spec to do that,
so we plug this hole.



> 
> >
> >What we lack is passing commands about one device to another device.
> >E.g. control VFs through PFs.
> 
> Could you provide examples of such commands please?

For example a common feature is to program a vlan and have device
put a given VF inside this vlan.

In a virtualization scenario host controls this vlan programming giving
the network a measure of protection from VFs.  If a VF is passed through
to a VM, IOMMU limits VFs to only access guest memory so host has to do
this programming through a PF.



> 
> >This is what groups do.
> >But if we see more uses we can always add them.
> >
> >
> >I'd rather avoid being too generic though.
> 
> In that case, why not to avoid using generic terms and stay
> "group-centric"? What I mean is:
> "Administration Virtqueues" -> "Group Administration Virtqueues"
> "struct virtio_admin_cmd" -> "struct virtio_group_admin_cmd"
> 
> Etc. Helps to avoid confusion.

Sure, I tried to do that but missed some opportunities.
Will address.

> 
> >
> >
> >
> >
> >> 
> >> >+than one administration virtqueue.
> 
> 
> [...]
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

