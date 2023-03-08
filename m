Return-Path: <virtio-dev-return-11507-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843C8C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:50:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D72152B062
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:50:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFCE09866F9
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:50:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C43A29866EF; Wed,  8 Mar 2023 11:50:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AA249866FD
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 11:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OY56LbZNNwqt6HN9lmeYww-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2GPFjrQ1CfMCyHjnQX20+BKx03PRS9ZfqJ0o9AZ380=;
        b=k2ArGDHJ8VOaOigE3qQ2eOST2dOMp+VV/PnFoMu9vdCbZL6CmrSjDL2+0RitW7NF9M
         K+aeVFoZD5gSpeKOIGX2RrHTWKkDiqc3LD1kss/rFsab9+Htjl5A6DlMQkGfIehrO0H+
         g5vusPD+fg4NBHdgqAIbgquwhlmAmryHdumkr9rmGK6KyfAbXkJI4yOQseSMhRS0Yy6u
         XYtC1dUV0JBInsA+6tZ0yuBPtpYINiHmuEQmZQbdzfJLHiApSWV4n1IjPHw4xDvQCRrX
         VF/as6hkigFcQzVmwqsRh3BKyxNjA33dMzcBYsG5SJ8hnMvWTXL+c+Ik7Bzqke0LFPdU
         KEXA==
X-Gm-Message-State: AO0yUKVQBIMML0tL0XNHSG+VjWW2D/nbaN+AVM/3fc2EyQMsN6xY9v8L
	G0ngcW9RXJRmVQm6/7pAlOo+GHetyrfAVHtRdOYBqJoiqsQATEX5eCMjsvtzx/YgnC5ANm/kR9P
	Ezc5zYzMYDfWjgT4ddmhlqecR0spv
X-Received: by 2002:a5d:4445:0:b0:2c3:f79a:7319 with SMTP id x5-20020a5d4445000000b002c3f79a7319mr12284337wrr.17.1678276253247;
        Wed, 08 Mar 2023 03:50:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8hhLeg+wcJMmnmv2Aei9HH4jb7ofAViUm3Hd8uL1mAcJpvSpcw+Lk2csIG531yTQRDRvi3kw==
X-Received: by 2002:a5d:4445:0:b0:2c3:f79a:7319 with SMTP id x5-20020a5d4445000000b002c3f79a7319mr12284323wrr.17.1678276252921;
        Wed, 08 Mar 2023 03:50:52 -0800 (PST)
Date: Wed, 8 Mar 2023 06:50:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308064505-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAhdzCd6qwWydesz@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

On Wed, Mar 08, 2023 at 11:05:00AM +0100, Jiri Pirko wrote:
> Tue, Mar 07, 2023 at 05:30:18PM CET, mst@redhat.com wrote:
> >On Tue, Mar 07, 2023 at 08:36:41AM +0100, Jiri Pirko wrote:
> >> Hmm, if not for now, the future exension would not be so simple, I fear.
> >
> >Without knowing what it is I can't say.
> 
> Yep, so basically you say, for other things if they appear,
> let's introduce another queue type? If yes, sounds fair to me.

Yes. For example I find it likely that live migration/failover support
will require a queue where driver pre-adds buffers and then device
supplies information as state changes.

> 
> >
> >> 
> >> >
> >> >Passing commands to devices themselves is already covered in spec
> >> >reasonably well though not in a generic way.
> >> 
> >> You mean using the control queue, correct?
> >
> >Depends on the device type. network devices have a control queue, yes.
> >
> >> >From one of the patch description of this patchset I understand that you
> >> cannot use control queue for this because control queue is
> >> device-specific, yet group control is device-agnostic.
> >> 
> >> My undestanding therefore was, that the admin queue you are introducing
> >> serves as a generic carrier for device-agnostic commands, in parallel
> >> for having control queue serving as a generic carrier of device-specific
> >> commands. If this is not the case, I think it would be nice to describe
> >> the exact monivation and scope of admin queue.
> >
> >Nope unfortunately.  This queue is just a carrier for admin commands.
> >admin commands are commands that talk to one device about other
> >devices. There's clearly no mechanism in the spec to do that,
> >so we plug this hole.
> 
> Okay, in that case "admin" sounds a bit misleading as for me it
> implicates that this is for "administration" of the device. Yet is is
> for the administration of other devices (slaves).
> 
> Perhaps there could be different term used to clarify?
> Group leader virtqueue?
> Group owner virtqueue?
> Group master virtqueue?

I used group administration virtqueue in a couple of places,
just inconsistently. Good enough?


> >
> >
> >
> >> 
> >> >
> >> >What we lack is passing commands about one device to another device.
> >> >E.g. control VFs through PFs.
> >> 
> >> Could you provide examples of such commands please?
> >
> >For example a common feature is to program a vlan and have device
> >put a given VF inside this vlan.
> 
> I don't follow entirely. The way how the VF is connected to network
> should be ouf of the scope of this interface. The eswitch manager should
> take care. What you say sounds awfully like the "ip vf" legacy
> interface, which should not be considered here I believe.
> 
> If PF would be the eswitch manager, there are other means to do network
> programming, using eswitch port representors. But I don't think this is
> the can of worms we want to open now. I don't think we have a usecase
> for it currently. Am I wrong Parav?
> 
> 
> 
> >
> >In a virtualization scenario host controls this vlan programming giving
> >the network a measure of protection from VFs.  If a VF is passed through
> >to a VM, IOMMU limits VFs to only access guest memory so host has to do
> >this programming through a PF.
> 
> Understood. This really looks like "ip vf" legacy. I strongly believe
> it should not be supported.
> 
> Any other commands you have in mind?
> 
> 
> >
> >
> >
> >> 
> >> >This is what groups do.
> >> >But if we see more uses we can always add them.
> >> >
> >> >
> >> >I'd rather avoid being too generic though.
> >> 
> >> In that case, why not to avoid using generic terms and stay
> >> "group-centric"? What I mean is:
> >> "Administration Virtqueues" -> "Group Administration Virtqueues"
> >> "struct virtio_admin_cmd" -> "struct virtio_group_admin_cmd"
> >> 
> >> Etc. Helps to avoid confusion.
> >
> >Sure, I tried to do that but missed some opportunities.
> >Will address.
> 
> Cool.
> 
> 
> >
> >> 
> >> >
> >> >
> >> >
> >> >
> >> >> 
> >> >> >+than one administration virtqueue.
> >> 
> >> 
> >> [...]
> >> 
> >
> >
> >This publicly archived list offers a means to provide input to the
> >OASIS Virtual I/O Device (VIRTIO) TC.
> >
> >In order to verify user consent to the Feedback License terms and
> >to minimize spam in the list archive, subscription is required
> >before posting.
> >
> >Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >List help: virtio-comment-help@lists.oasis-open.org
> >List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> >Committee: https://www.oasis-open.org/committees/virtio/
> >Join OASIS: https://www.oasis-open.org/join/
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

